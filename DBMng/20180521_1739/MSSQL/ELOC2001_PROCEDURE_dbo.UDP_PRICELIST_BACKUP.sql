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
	-- ���ν����� : UDP_PRICELIST_BACKUP
	-- ��  ��  �� : �յ���
	-- ��  ��  �� : 2007.06.29
	-- ��      �� : ���� 1ȸ PRICELIST ���
	-------------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	2008.06.10		WOOKKI25		���� : SET @NEXTID = DBO.UDF_GET_WEEKPERIOD(GETDATE())
									���� : SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	*/	
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF OBJECT_ID('TMP_PRICELIST_FOR_GRAPH') IS NOT NULL
		DROP TABLE TMP_PRICELIST_FOR_GRAPH

	-- �����ֱ� ����� �� Ȯ��.  
	DECLARE @NEXTID VARCHAR(8)
	SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	
	-- ������ ���ó��
	DECLARE @SNUM BIGINT, @ROWCNT BIGINT
	IF EXISTS(SELECT TOP 1 * FROM weekdata.dbo.TBL_WEEK_GOODS WITH (READUNCOMMITTED) WHERE WG_DATE_ID = @NEXTID)
	BEGIN
		-- �ӽ� ���̺� ���� & �ε��� ����
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
		SET @ROWCNT = 2500	-- @ROWCNT��ŭ�� �Է�
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
		
		-- �ӽ����̺� ����
		DROP TABLE TMP_PRICELIST_FOR_GRAPH 
	END
END
