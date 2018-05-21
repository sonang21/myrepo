/* *************************************************************************
 * NAME : dbo.UDP_POPULAR_WEIGHT_SPONSOR_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:09:53.463
 *        Modify: 2018-05-15 15:09:53.463
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_POPULAR_WEIGHT_SPONSOR_SEL
AS
	SET NOCOUNT ON	
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.03.26
	-- 설  명 : 인기도 스폰서 상품 가중치 리스트
	-- 실  행 : EXEC UDP_POPULAR_WEIGHT_SPONSOR_SEL
	-- ----------------------------------------------------------------------------------
	SELECT 	A.G_MODELNO,
			G_MODELNM,
			P_WEIGHT,
			USE_FLAG,
			MOD_DATE,
			LEFT(G_CATEGORY,4) AS MCATE,
			SDATE,
			EDATE
	FROM	GOODS_POPULAR_WEIGHT_SPONSOR A
				LEFT OUTER JOIN
			analstore.DBO.GOODS B
				ON A.G_MODELNO = B.G_MODELNO
	ORDER BY B.G_CATEGORY, A.G_MODELNO


