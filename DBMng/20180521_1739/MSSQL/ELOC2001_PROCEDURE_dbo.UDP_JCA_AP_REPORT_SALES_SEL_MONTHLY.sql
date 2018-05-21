/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SALES_SEL_MONTHLY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 15:06:33.21
 *        Modify: 2018-05-03 17:23:34.217
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JCA_AP_REPORT_SALES_SEL_MONTHLY
	@YYYY	VARCHAR(4)
,	@SHOP_GROUP CHAR(1) = NULL
,	@device char(1) = null
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2010.03.10
	-- ��  �� : AP ��ü ���� �����
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
		,		[1��] = SUM(CASE WHEN MONTH(SALES_DATE) = 1 THEN SALES_SUM END) 
		,		[2��] = SUM(CASE WHEN MONTH(SALES_DATE) = 2 THEN SALES_SUM END)
		,		[3��] = SUM(CASE WHEN MONTH(SALES_DATE) = 3 THEN SALES_SUM END)
		,		[4��] = SUM(CASE WHEN MONTH(SALES_DATE) = 4 THEN SALES_SUM END)
		,		[5��] = SUM(CASE WHEN MONTH(SALES_DATE) = 5 THEN SALES_SUM END)
		,		[6��] = SUM(CASE WHEN MONTH(SALES_DATE) = 6 THEN SALES_SUM END)
		,		[7��] = SUM(CASE WHEN MONTH(SALES_DATE) = 7 THEN SALES_SUM END)
		,		[8��] = SUM(CASE WHEN MONTH(SALES_DATE) = 8 THEN SALES_SUM END)
		,		[9��] = SUM(CASE WHEN MONTH(SALES_DATE) = 9 THEN SALES_SUM END)
		,		[10��] = SUM(CASE WHEN MONTH(SALES_DATE) = 10 THEN SALES_SUM END)
		,		[11��] = SUM(CASE WHEN MONTH(SALES_DATE) = 11 THEN SALES_SUM END)
		,		[12��] = SUM(CASE WHEN MONTH(SALES_DATE) = 12 THEN SALES_SUM END)
		,		[MONTH_SUM] = SUM(SALES_SUM)
		FROM TBL_AP_SHOP_SALES
		WHERE SALES_DATE BETWEEN @SDATE AND 
				case when cast(@yyyy as int)=year(getdate()) then 
						getdate() - day(getdate())
					else 
						@EDATE 
				end 
		AND	SHOP_GROUP = @SHOP_GROUP
		and device = isnull(@device, device)
		GROUP BY SHOP_VCODE
	) A INNER JOIN SHOPLIST B ON A.SHOP_VCODE = B.SHOP_VCODE
	ORDER BY CASE WHEN @SHOP_GROUP = 'B' THEN CAST(100000000 - MONTH_SUM AS INT) ELSE ROW_NUMBER() OVER(ORDER BY B.SHOP_NAME asc) END

