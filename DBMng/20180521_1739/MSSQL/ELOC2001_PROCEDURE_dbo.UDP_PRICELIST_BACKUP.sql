/* *************************************************************************
 * NAME : dbo.UDP_PRICELIST_BACKUP
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-07 22:21:57.783
 *        Modify: 2018-05-03 17:23:35.613
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC DBO.UDP_PRICELIST_BACKUP
AS
BEGIN
	-------------------------------------------------------------------------------------
	-- 프로시저명 : UDP_PRICELIST_BACKUP
	-- 작  성  자 : 손동욱
	-- 작  성  일 : 2007.06.29
	-- 설      명 : 매주 1회 PRICELIST 백업
	-------------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	2008.06.10		WOOKKI25		기존 : SET @NEXTID = DBO.UDF_GET_WEEKPERIOD(GETDATE())
									수정 : SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	*/	
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF OBJECT_ID('TMP_PRICELIST_FOR_GRAPH') IS NOT NULL
		DROP TABLE TMP_PRICELIST_FOR_GRAPH

	-- 가장최근 백업한 주 확인.  
	DECLARE @NEXTID VARCHAR(8)
	SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	
	-- 데이터 백업처리
	DECLARE @SNUM BIGINT, @ROWCNT BIGINT
	IF EXISTS(SELECT TOP 1 * FROM weekdata.dbo.TBL_WEEK_GOODS WITH (READUNCOMMITTED) WHERE WG_DATE_ID = @NEXTID)
	BEGIN
		-- 임시 테이블 생성 & 인덱스 생성
		SELECT	IDENTITY(BIGINT, 1,1) AS NUM, @NEXTID AS DATE_ID, PL_MODELNO, PL_VCODE, PL_PRICE
		INTO	TMP_PRICELIST_FOR_GRAPH
		FROM	PRICELIST  
		WHERE	PL_MODELNO > 0   
		AND		PL_PRICE > 0   
		AND		PL_VCODE <> 590  
		AND		pl_status in ('0','1,','2','8','9') 
		and		pl_esstockflag='0'  
		and		isnull(option_flag2,'0')='0'  
		and		pl_srvflag in ('0','r','l')

		CREATE CLUSTERED INDEX CL_TMP_PRICELIST_FOR_GRAPH ON TMP_PRICELIST_FOR_GRAPH(NUM)
		
		-- 196.TBL_WEEK_DATA
		SET @ROWCNT = 2500	-- @ROWCNT만큼씩 입력
		SET @SNUM = 1
		WHILE 1=1
		BEGIN
			INSERT INTO WEEKDATA_196.WEEKDATA.DBO.PLIST_ADD(DATE_ID, SEQNO, VCODE, PRICE)
			SELECT DATE_ID, PL_MODELNO, PL_VCODE, PL_PRICE
			FROM TMP_PRICELIST_FOR_GRAPH
			WHERE NUM >= @SNUM AND NUM < @SNUM + @ROWCNT
			order by num
			
			IF @@ROWCOUNT < @ROWCNT
			BEGIN
				BREAK;
			END			
			ELSE
			BEGIN
				SET @SNUM = @SNUM + @ROWCNT
			END
		END
		
		-- 임시테이블 삭제
		DROP TABLE TMP_PRICELIST_FOR_GRAPH 
	END
END
