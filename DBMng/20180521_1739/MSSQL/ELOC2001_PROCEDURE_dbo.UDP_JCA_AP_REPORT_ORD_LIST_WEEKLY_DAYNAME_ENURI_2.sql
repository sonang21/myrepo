/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_ORD_LIST_WEEKLY_DAYNAME_ENURI_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 16:07:49.13
 *        Modify: 2018-05-03 17:23:34.58
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE PROC UDP_JCA_AP_REPORT_ORD_LIST_WEEKLY_DAYNAME_ENURI_2
	@YEAR SMALLINT
AS
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.28
	-- 설  명 : AP 주별 주문액 리스트
	-- 참  조 : ELOC2001.DOB.UDP_JCA_AP_REPORT_ORD_LIST_WEEKLY_ENURI
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------	
	2009.04.02		WOOKKI25		~~~
	*/	
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
		
	SELECT DATEPART(WEEKDAY, sale_date) AS DAY_NAME_NO,			
		DATEPART(WW, sale_date) AS WEEKOFYEAR,	
		sum(sales)		
	FROM tbl_ap_sales
	WHERE	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
	and		sale_date < dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
	AND		shop_vcode NOT IN (6052,5893,1719,1733,5892) -- 체결데이터 제외, 오버추어 제외
	group by DATEPART(WW, sale_date), DATEPART(WEEKDAY, sale_date)
	order by 1, 2
