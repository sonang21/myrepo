/* *************************************************************************
 * NAME : dbo.UDP_WEEKGOODS_BACKUP
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-07 22:21:57.61
 *        Modify: 2017-09-06 23:00:46.5
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC DBO.UDP_WEEKGOODS_BACKUP
AS  
BEGIN  
	-------------------------------------------------------------------------------------
	-- ���ν����� : UDP_WEEKGOODS_BACKUP
	-- ��  ��  �� : �յ���
	-- ��  ��  �� : 2007.06.29
	-- ��      �� : ���� 1ȸ GOODS ���
	-------------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	2008.06.10		WOOKKI25		���� : SET @NEXTID = DBO.UDF_GET_WEEKPERIOD(GETDATE())
									���� : SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))
	2012.03.29		wookki25		���� : where g_minprice > 0
									���� : where  g_minprice > 0 and g_mallcnt > 0
									���� : ������ ���� �׷��� ���� ������ �ʴ´�.
	2013.04.27		wookki25	wg_no ���� ����.
	*/		
	SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
	
	-- �����ֱ� ����� �� Ȯ��.  // �ſ� ù��° �Ͽ��Ͽ� �����Ǵ� �����ʹ� ������ ���������̴�.
	DECLARE @NEXTID VARCHAR(8)
	SET @NEXTID = DBO.UDF_GET_WEEKOFMONTH(DATEADD(DD, -DATEPART(WEEKDAY,GETDATE()), GETDATE()))

	if object_id('TMP_GOODS_FOR_GRAPH') is not null 
		drop table TMP_GOODS_FOR_GRAPH

	-- ������ ���ó��
	DECLARE @SNUM BIGINT, @ROWCNT BIGINT
	IF NOT EXISTS(SELECT TOP 1 * FROM WEEKDATA.dbo.TBL_WEEK_GOODS WITH (READUNCOMMITTED) WHERE WG_DATE_ID = @NEXTID)
	BEGIN  
		-- �ӽ� ���̺� ���� & �ε��� ����
		SELECT	G_MODELNO, @NEXTID AS DATE_ID, ISNULL(G_JOBCODE, '0') AS G_JOBCODE, G_MODELNM, G_FACTORY, G_MINPRICE, G_AVGPRICE, G_MAXPRICE, G_MALLCNT
		INTO	TMP_GOODS_FOR_GRAPH
		FROM	GOODS  
		WHERE	g_mallcnt > 0 and g_minprice > 0 and g_avgprice > 0 and g_maxprice > 0
		AND		(G_OPENEXPECTFLAG <> '1' OR G_OPENEXPECTFLAG IS NULL)  

		-- 188.TBL_WEEK_DATA
		INSERT INTO WEEKDATA.dbo.TBL_WEEK_GOODS(WG_DATE_ID,WG_MODELNO,WG_JOBCODE,WG_MODELNM,WG_FACTORY,WG_MINPRICE,WG_AVGPRICE,WG_MAXPRICE,WG_SHOP_CNT)
		SELECT DATE_ID, G_MODELNO, G_JOBCODE, G_MODELNM, G_FACTORY, G_MINPRICE, G_AVGPRICE, G_MAXPRICE, G_MALLCNT
		FROM TMP_GOODS_FOR_GRAPH

		-- �ӽ����̺� ����
		--DROP TABLE TMP_GOODS_FOR_GRAPH		 //

		-- 2017.09.06 // wookki25
		create clustered index cl_TMP_GOODS_FOR_GRAPH on 	TMP_GOODS_FOR_GRAPH(g_modelno)


	END  
END





