/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_SEL_MONTHLY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 15:08:00.647
 *        Modify: 2018-05-03 17:23:34.227
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JCA_AP_REPORT_FEE_SEL_MONTHLY
	@YYYY	VARCHAR(4)
,	@SHOP_GROUP CHAR(1) = NULL
,	@device char(1) = null
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2010.03.10
	-- ��  �� : AP ��ü ���� ������
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	DECLARE @SDATE SMALLDATETIME, @EDATE SMALLDATETIME
	SET @SDATE = CAST(@YYYY+'-01-01' AS SMALLDATETIME)
	SET @EDATE = CAST(@YYYY+'-12-31' AS SMALLDATETIME)
	
	SELECT SHOP_NAME, [1��],[2��],[3��],[4��],[5��],[6��]
	,		[7��],[8��],[9��],[10��],[11��],[12��]
	,		MONTH_SUM
	from 
	(
		SELECT	SHOP_VCODE
		,		[1��] = SUM(CASE WHEN MONTH(FEE_DATE) = 1 THEN FEE_SUM END) 
		,		[2��] = SUM(CASE WHEN MONTH(FEE_DATE) = 2 THEN FEE_SUM END)
		,		[3��] = SUM(CASE WHEN MONTH(FEE_DATE) = 3 THEN FEE_SUM END)
		,		[4��] = SUM(CASE WHEN MONTH(FEE_DATE) = 4 THEN FEE_SUM END)
		,		[5��] = SUM(CASE WHEN MONTH(FEE_DATE) = 5 THEN FEE_SUM END)
		,		[6��] = SUM(CASE WHEN MONTH(FEE_DATE) = 6 THEN FEE_SUM END)
		,		[7��] = SUM(CASE WHEN MONTH(FEE_DATE) = 7 THEN FEE_SUM END)
		,		[8��] = SUM(CASE WHEN MONTH(FEE_DATE) = 8 THEN FEE_SUM END)
		,		[9��] = SUM(CASE WHEN MONTH(FEE_DATE) = 9 THEN FEE_SUM END)
		,		[10��] = SUM(CASE WHEN MONTH(FEE_DATE) = 10 THEN FEE_SUM END)
		,		[11��] = SUM(CASE WHEN MONTH(FEE_DATE) = 11 THEN FEE_SUM END)
		,		[12��] = SUM(CASE WHEN MONTH(FEE_DATE) = 12 THEN FEE_SUM END)
		,		MONTH_SUM = SUM(FEE_SUM)
		FROM TBL_AP_SHOP_FEE
		WHERE FEE_DATE BETWEEN @SDATE AND @EDATE
		AND	SHOP_GROUP = @SHOP_GROUP
		and device = isnull(@device, device)
		GROUP BY SHOP_VCODE
	) A INNER JOIN SHOPLIST B ON A.SHOP_VCODE = B.SHOP_VCODE
	ORDER BY A.SHOP_VCODE

