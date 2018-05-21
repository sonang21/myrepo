/* *************************************************************************
 * NAME : dbo.UDP_WEEKGOODS_BACKUP
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-07 22:21:57.61
 *        Modify: 2017-09-06 23:00:46.5
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC DBO.UDP_WEEKGOODS_BACKUP
AS  
BEGIN  
	-------------------------------------------------------------------------------------
	-- 프로시저명 : UDP_WEEKGOODS_BACKUP
	-- 작  성  자 : 손동욱
	-- 작  성  일 : 2007.06.29
	-- 설      명 : 매주 1회 GOODS 백업
	-------------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	2008.06.10		WOOKKI25		기존 : SET @NEXTID = DBO.UDF_GET_WEEKPERIOD(GETDATE())
									수정 : SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	2012.03.29		wookki25		기존 : where g_minprice > 0
									수정 : where  g_minprice > 0 and g_mallcnt > 0
									사유 : 삭제된 모델은 그래프 정보 남기지 않는다.
	2013.04.27		wookki25	wg_no 없이 저장.
	*/		
	SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
	
	-- 가장최근 백업한 주 확인.  // 매월 첫번째 일요일에 생성되는 데이터는 전달의 마지막주이다.
	DECLARE @NEXTID VARCHAR(8)
	SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))

	if object_id('TMP_GOODS_FOR_GRAPH') is not null 
		drop table TMP_GOODS_FOR_GRAPH

	-- 데이터 백업처리
	DECLARE @SNUM BIGINT, @ROWCNT BIGINT
	IF NOT EXISTS(SELECT TOP 1 * FROM WEEKDATA.dbo.TBL_WEEK_GOODS WITH (READUNCOMMITTED) WHERE WG_DATE_ID = @NEXTID)
	BEGIN  
		-- 임시 테이블 생성 & 인덱스 생성
		SELECT	G_MODELNO, @NEXTID AS DATE_ID, ISNULL(G_JOBCODE, '0') AS G_JOBCODE, G_MODELNM, G_FACTORY, G_MINPRICE, G_AVGPRICE, G_MAXPRICE, G_MALLCNT
		INTO	TMP_GOODS_FOR_GRAPH
		FROM	GOODS  
		WHERE	g_mallcnt > 0 and g_minprice > 0 and g_avgprice > 0 and g_maxprice > 0
		AND		(G_OPENEXPECTFLAG <> '1' OR G_OPENEXPECTFLAG IS NULL)  

		-- 188.TBL_WEEK_DATA
		INSERT INTO WEEKDATA.dbo.TBL_WEEK_GOODS(WG_DATE_ID,WG_MODELNO,WG_JOBCODE,WG_MODELNM,WG_FACTORY,WG_MINPRICE,WG_AVGPRICE,WG_MAXPRICE,WG_SHOP_CNT)
		SELECT DATE_ID, G_MODELNO, G_JOBCODE, G_MODELNM, G_FACTORY, G_MINPRICE, G_AVGPRICE, G_MAXPRICE, G_MALLCNT
		FROM TMP_GOODS_FOR_GRAPH

		-- 임시테이블 삭제
		--DROP TABLE TMP_GOODS_FOR_GRAPH		 //

		-- 2017.09.06 // wookki25
		create clustered index cl_TMP_GOODS_FOR_GRAPH on 	TMP_GOODS_FOR_GRAPH(g_modelno)


	END  
END





