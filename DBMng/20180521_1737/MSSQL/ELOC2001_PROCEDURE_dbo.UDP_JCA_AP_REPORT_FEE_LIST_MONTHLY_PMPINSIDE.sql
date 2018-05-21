/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_PMPINSIDE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-19 10:54:36.85
 *        Modify: 2018-05-03 17:23:36.02
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_PMPINSIDE]
	@YEAR	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.03.11
	-- 설  명 : AP 월별 수수료 리스트
	-- 실  행 : UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_PMPINSIDE 2008
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	SELECT	SHOP_NAME,
			AS_MONTH1,AS_MONTH2,AS_MONTH3,AS_MONTH4,AS_MONTH5,
			AS_MONTH6,AS_MONTH7,AS_MONTH8,AS_MONTH9,AS_MONTH10,
			AS_MONTH11,AS_MONTH12,
			AS_MONTH_SUM,
			CASE WHEN SHOP_NAME = '합계' AND ISNULL(AS_MONTH_SUM,0) > 0 THEN
			AS_MONTH_SUM/(
			ISNULL(SIGN(AS_MONTH1+1),0)+
			ISNULL(SIGN(AS_MONTH2+1),0)+
			ISNULL(SIGN(AS_MONTH3+1),0)+
			ISNULL(SIGN(AS_MONTH4+1),0)+
			ISNULL(SIGN(AS_MONTH5+1),0)+
			ISNULL(SIGN(AS_MONTH6+1),0)+
			ISNULL(SIGN(AS_MONTH7+1),0)+
			ISNULL(SIGN(AS_MONTH8+1),0)+
			ISNULL(SIGN(AS_MONTH9+1),0)+
			ISNULL(SIGN(AS_MONTH10+1),0)+
			ISNULL(SIGN(AS_MONTH11+1),0)+
			ISNULL(SIGN(AS_MONTH12+1),0)		
			) ELSE AS_MONTH_SUM_AVG END AS AS_DAY_SUM_AVG			 	
	FROM
	(			
		SELECT MAX(CASE WHEN NUM = 1 THEN  SHOP_NAME ELSE '합계' END) AS SHOP_NAME,
		SUM([1월]) AS AS_MONTH1,SUM([2월]) AS AS_MONTH2,SUM([3월]) AS AS_MONTH3,SUM([4월]) AS AS_MONTH4,SUM([5월]) AS AS_MONTH5,SUM([6월]) AS AS_MONTH6,
		SUM([7월]) AS AS_MONTH7,SUM([8월]) AS AS_MONTH8,SUM([9월]) AS AS_MONTH9,SUM([10월]) AS AS_MONTH10,SUM([11월]) AS AS_MONTH11,SUM([12월]) AS AS_MONTH12,
		SUM(AS_MONTH_SUM) AS AS_MONTH_SUM, SUM(AS_MONTH_SUM_AVG) AS AS_MONTH_SUM_AVG
		FROM	
			(
				SELECT	SHOP_NAME, 
						SUM(CASE AS_DATE_MONTH WHEN 1 THEN AS_MONTH END) AS '1월',
						SUM(CASE AS_DATE_MONTH WHEN 2 THEN AS_MONTH END) AS '2월',
						SUM(CASE AS_DATE_MONTH WHEN 3 THEN AS_MONTH END) AS '3월',
						SUM(CASE AS_DATE_MONTH WHEN 4 THEN AS_MONTH END) AS '4월',
						SUM(CASE AS_DATE_MONTH WHEN 5 THEN AS_MONTH END) AS '5월',
						SUM(CASE AS_DATE_MONTH WHEN 6 THEN AS_MONTH END) AS '6월',
						SUM(CASE AS_DATE_MONTH WHEN 7 THEN AS_MONTH END) AS '7월',
						SUM(CASE AS_DATE_MONTH WHEN 8 THEN AS_MONTH END) AS '8월',
						SUM(CASE AS_DATE_MONTH WHEN 9 THEN AS_MONTH END) AS '9월',
						SUM(CASE AS_DATE_MONTH WHEN 10 THEN AS_MONTH END) AS '10월',
						SUM(CASE AS_DATE_MONTH WHEN 11 THEN AS_MONTH END) AS '11월',
						SUM(CASE AS_DATE_MONTH WHEN 12 THEN AS_MONTH END) AS '12월',
						SUM(AS_MONTH) AS AS_MONTH_SUM, SUM(AS_MONTH) / SUM(1) AS AS_MONTH_SUM_AVG
				FROM	TBL_AP_SHOP_PMPINSIDE 
							INNER JOIN
						SHOPLIST
							ON AS_SHOP = SHOP_VCODE
							AND shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
				WHERE	AS_DATE_YEAR = @YEAR AND
						AS_MONTH IS NOT NULL
				GROUP BY SHOP_NAME
			
			) TBL_TMP
				CROSS JOIN
			(SELECT 1 NUM UNION ALL SELECT 2) COPY_T
		GROUP BY (CASE WHEN NUM = 1 THEN SHOP_NAME ELSE '합계' END)
	) TBL_TMP2
	ORDER BY (CASE WHEN SHOP_NAME = '합계' THEN -1 ELSE ISNULL(AS_MONTH_SUM,0) END) DESC, TBL_TMP2.SHOP_NAME ASC