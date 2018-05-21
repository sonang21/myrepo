/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SALES_SEL_MONTHLY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 15:06:33.21
 *        Modify: 2018-05-03 17:23:34.217
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_JCA_AP_REPORT_SALES_SEL_MONTHLY
	@YYYY	VARCHAR(4)
,	@SHOP_GROUP CHAR(1) = NULL
,	@device char(1) = null
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2010.03.10
	-- 설  명 : AP 업체 월별 매출액
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	DECLARE @SDATE SMALLDATETIME, @EDATE SMALLDATETIME
	SET @SDATE = CAST(@YYYY+'-01-01' AS SMALLDATETIME)
	SET @EDATE = CAST(@YYYY+'-12-31' AS SMALLDATETIME)

	SELECT SHOP_NAME, [1월],[2월],[3월],[4월],[5월],[6월]
	,		[7월],[8월],[9월],[10월],[11월],[12월]
	,		MONTH_SUM


	from 
	(
		SELECT	SHOP_VCODE
		,		[1월] = SUM(CASE WHEN MONTH(SALES_DATE) = 1 THEN SALES_SUM END) 
		,		[2월] = SUM(CASE WHEN MONTH(SALES_DATE) = 2 THEN SALES_SUM END)
		,		[3월] = SUM(CASE WHEN MONTH(SALES_DATE) = 3 THEN SALES_SUM END)
		,		[4월] = SUM(CASE WHEN MONTH(SALES_DATE) = 4 THEN SALES_SUM END)
		,		[5월] = SUM(CASE WHEN MONTH(SALES_DATE) = 5 THEN SALES_SUM END)
		,		[6월] = SUM(CASE WHEN MONTH(SALES_DATE) = 6 THEN SALES_SUM END)
		,		[7월] = SUM(CASE WHEN MONTH(SALES_DATE) = 7 THEN SALES_SUM END)
		,		[8월] = SUM(CASE WHEN MONTH(SALES_DATE) = 8 THEN SALES_SUM END)
		,		[9월] = SUM(CASE WHEN MONTH(SALES_DATE) = 9 THEN SALES_SUM END)
		,		[10월] = SUM(CASE WHEN MONTH(SALES_DATE) = 10 THEN SALES_SUM END)
		,		[11월] = SUM(CASE WHEN MONTH(SALES_DATE) = 11 THEN SALES_SUM END)
		,		[12월] = SUM(CASE WHEN MONTH(SALES_DATE) = 12 THEN SALES_SUM END)
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

