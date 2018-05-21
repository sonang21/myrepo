/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_ORD_LIST_DAILY_HANAFOS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-19 10:22:15.607
 *        Modify: 2018-05-03 17:23:35.813
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_ORD_LIST_DAILY_HANAFOS]
	@YEAR	SMALLINT
,	@MONTH	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.18
	-- 설  명 : AP 일별 주문액 리스트
	-- 실  행 : UDP_JCA_AP_REPORT_ORD_LIST_DAILY_HANAFOS 2007, 3
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	-- 일별 리스트
	SELECT	SHOP_NAME,
			AS_DAY1,AS_DAY2,AS_DAY3,AS_DAY4,AS_DAY5,
			AS_DAY6,AS_DAY7,AS_DAY8,AS_DAY9,AS_DAY10,
			AS_DAY11,AS_DAY12,AS_DAY13,AS_DAY14,AS_DAY15,
			AS_DAY16,AS_DAY17,AS_DAY18,AS_DAY19,AS_DAY20,
			AS_DAY21,AS_DAY22,AS_DAY23,AS_DAY24,AS_DAY25,
			AS_DAY26,AS_DAY27,AS_DAY28,AS_DAY29,AS_DAY30,
			AS_DAY31, SHOP_NAME, AS_DAY_SUM,
			AS_DAY_SUM_AVG =
			CASE WHEN AS_DAY_SUM = 0 THEN 0
			ELSE AS_DAY_SUM/(
			ISNULL(SIGN(AS_DAY1+1),0)+
			ISNULL(SIGN(AS_DAY2+1),0)+
			ISNULL(SIGN(AS_DAY3+1),0)+
			ISNULL(SIGN(AS_DAY4+1),0)+
			ISNULL(SIGN(AS_DAY5+1),0)+
			ISNULL(SIGN(AS_DAY6+1),0)+
			ISNULL(SIGN(AS_DAY7+1),0)+
			ISNULL(SIGN(AS_DAY8+1),0)+
			ISNULL(SIGN(AS_DAY9+1),0)+
			ISNULL(SIGN(AS_DAY10+1),0)+
			ISNULL(SIGN(AS_DAY11+1),0)+
			ISNULL(SIGN(AS_DAY12+1),0)+
			ISNULL(SIGN(AS_DAY13+1),0)+
			ISNULL(SIGN(AS_DAY14+1),0)+
			ISNULL(SIGN(AS_DAY15+1),0)+
			ISNULL(SIGN(AS_DAY16+1),0)+
			ISNULL(SIGN(AS_DAY17+1),0)+
			ISNULL(SIGN(AS_DAY18+1),0)+
			ISNULL(SIGN(AS_DAY19+1),0)+
			ISNULL(SIGN(AS_DAY20+1),0)+
			ISNULL(SIGN(AS_DAY21+1),0)+
			ISNULL(SIGN(AS_DAY22+1),0)+
			ISNULL(SIGN(AS_DAY23+1),0)+
			ISNULL(SIGN(AS_DAY24+1),0)+
			ISNULL(SIGN(AS_DAY25+1),0)+
			ISNULL(SIGN(AS_DAY26+1),0)+
			ISNULL(SIGN(AS_DAY27+1),0)+
			ISNULL(SIGN(AS_DAY28+1),0)+
			ISNULL(SIGN(AS_DAY29+1),0)+
			ISNULL(SIGN(AS_DAY30+1),0)+
			ISNULL(SIGN(AS_DAY31+1),0)
			) END
	FROM
	(
		SELECT 
			MAX(CASE WHEN NUM = 1 THEN  SHOP_NAME ELSE '합계' END) AS SHOP_NAME,
			SUM(AS_DAY1) AS AS_DAY1, SUM(AS_DAY2) AS AS_DAY2, SUM(AS_DAY3) AS AS_DAY3, SUM(AS_DAY4) AS AS_DAY4, SUM(AS_DAY5) AS AS_DAY5, 
			SUM(AS_DAY6) AS AS_DAY6, SUM(AS_DAY7) AS AS_DAY7, SUM(AS_DAY8) AS AS_DAY8, SUM(AS_DAY9) AS AS_DAY9, SUM(AS_DAY10) AS AS_DAY10, 
			SUM(AS_DAY11) AS AS_DAY11, SUM(AS_DAY12) AS AS_DAY12, SUM(AS_DAY13) AS AS_DAY13, SUM(AS_DAY14) AS AS_DAY14, SUM(AS_DAY15) AS AS_DAY15, 
			SUM(AS_DAY16) AS AS_DAY16, SUM(AS_DAY17) AS AS_DAY17, SUM(AS_DAY18) AS AS_DAY18, SUM(AS_DAY19) AS AS_DAY19, SUM(AS_DAY20) AS AS_DAY20, 
			SUM(AS_DAY21) AS AS_DAY21, SUM(AS_DAY22) AS AS_DAY22, SUM(AS_DAY23) AS AS_DAY23, SUM(AS_DAY24) AS AS_DAY24, SUM(AS_DAY25) AS AS_DAY25, 
			SUM(AS_DAY26) AS AS_DAY26, SUM(AS_DAY27) AS AS_DAY27, SUM(AS_DAY28) AS AS_DAY28, SUM(AS_DAY29) AS AS_DAY29, SUM(AS_DAY30) AS AS_DAY30, 
			SUM(AS_DAY31) AS AS_DAY31, SUM(AS_DAY_SUM) AS AS_DAY_SUM
		FROM
			(
			SELECT	SHOP_NAME,
					AS_DAY1,AS_DAY2,AS_DAY3,AS_DAY4,AS_DAY5,
					AS_DAY6,AS_DAY7,AS_DAY8,AS_DAY9,AS_DAY10,
					AS_DAY11,AS_DAY12,AS_DAY13,AS_DAY14,AS_DAY15,
					AS_DAY16,AS_DAY17,AS_DAY18,AS_DAY19,AS_DAY20,
					AS_DAY21,AS_DAY22,AS_DAY23,AS_DAY24,AS_DAY25,
					AS_DAY26,AS_DAY27,AS_DAY28,AS_DAY29,AS_DAY30,AS_DAY31, 
					AS_DAY_SUM
			FROM	TBL_AP_SHOP_HANAFOS
						INNER JOIN 
					SHOPLIST
						ON AS_SHOP = SHOP_VCODE
			WHERE	AS_DATE_YEAR = @YEAR AND AS_DATE_MONTH = @MONTH
			) TBL_TMP
				CROSS JOIN
			(SELECT 1 NUM UNION ALL SELECT 2) COPY_T
		GROUP BY (CASE WHEN NUM = 1 THEN SHOP_NAME ELSE '합계' END)
	) TBL_TMP2
	ORDER BY (CASE WHEN SHOP_NAME = '합계' THEN -1 ELSE ISNULL(AS_DAY_SUM,0) END) DESC, TBL_TMP2.SHOP_NAME ASC




