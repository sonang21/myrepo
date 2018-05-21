/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_MODEL_DETAIL_DLV
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 16:34:31.15
 *        Modify: 2018-05-14 16:34:31.15
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_ORDERDATA_MODEL_DETAIL_DLV
	@CATE	VARCHAR(8)
,	@SDATE	datetime
,	@EDATE	datetime
,	@SHOP_CODE INT = 0
,	@is_now_cate bit = 0
AS
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.01.25
	-- 설  명 : 해당 모델번호의 상세 주문내역-배송기준
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	2008.01.28		wookki25		페이징처리  취소
	*/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	--SELECT * FROM #TBL_ORDERDATA_MODELNO_IS_0 WHERE SEQ BETWEEN @ROWCNT-100+1 AND @ROWCNT
	if @is_now_cate=0 begin
		SELECT G_MODELNO, ISNULL(G_MODELNM,''), G_FACTORY,  ROW_SUM, OD_CNT, PRICE_SUM, OD_CATEGORY--, CM_NAME 
		FROM 
		(
			SELECT	SHOP_VCODE, PL_MODELNO, ISNULL(MAX(OD_CATEGORY),'0000') AS OD_CATEGORY, COUNT(*) AS ROW_SUM, SUM(OD_CNT) AS OD_CNT, SUM(OD_PRICE*OD_CNT) AS PRICE_SUM
			FROM	TBL_ORDERDATA
			WHERE	OD_DATE >= @SDATE AND OD_DATE < @EDATE+1
			AND		OD_CATEGORY LIKE @CATE+'%'
			AND		SHOP_VCODE BETWEEN @SHOP_CODE AND CASE WHEN @SHOP_CODE = 0 THEN 100000 ELSE  @SHOP_CODE END
			GROUP BY SHOP_VCODE, PL_MODELNO
		) A
			LEFT OUTER JOIN 
		analstore.DBO.GOODS B
			ON A.PL_MODELNO = B.G_MODELNO
		ORDER BY PRICE_SUM DESC
	end else begin
		SELECT G_MODELNO, ISNULL(G_MODELNM,''), G_FACTORY,  ROW_SUM, OD_CNT, PRICE_SUM, OD_CATEGORY--, CM_NAME 
		FROM 
		(
			SELECT	SHOP_VCODE, PL_MODELNO, ISNULL(OD_CATEGORY,'0000') AS OD_CATEGORY, COUNT(*) AS ROW_SUM, SUM(OD_CNT) AS OD_CNT, SUM(OD_PRICE*OD_CNT) AS PRICE_SUM
			FROM	TBL_ORDERDATA
			WHERE	OD_DATE >= @SDATE AND OD_DATE < @EDATE+1
			AND		SHOP_VCODE BETWEEN @SHOP_CODE AND CASE WHEN @SHOP_CODE = 0 THEN 100000 ELSE  @SHOP_CODE END
			GROUP BY SHOP_VCODE, PL_MODELNO, od_category
		) A
			LEFT OUTER JOIN 
		SIMPLEDB.DBO.GOODS B
			ON A.PL_MODELNO = B.G_MODELNO
		WHERE isnull(G_CATEGORY, od_category) LIKE @CATE+'%'
		ORDER BY PRICE_SUM DESC
	end
	



