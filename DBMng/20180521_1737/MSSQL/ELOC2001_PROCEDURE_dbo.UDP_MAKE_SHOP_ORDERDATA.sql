/* *************************************************************************
 * NAME : dbo.UDP_MAKE_SHOP_ORDERDATA
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-09 12:32:16.173
 *        Modify: 2018-05-03 17:23:35.67
 *        Backup: 20180521_1737
 ************************************************************************* */

-- 188
CREATE PROC [DBO].[UDP_MAKE_SHOP_ORDERDATA]
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.04.25
	-- 설  명 : SSIS로 입력된 Raw 데이터를 가공한 후 196 db에 입력(196 프로시저 콜)
	-- 실  행 : UDP_MAKE_SHOP_ORDEREDATA
	-- ----------------------------------------------------------------------------------
	
	-- 데이터 삭제
	DELETE TBL_SHOP_ORDERDATA FROM TBL_SHOP_ORDERDATA WHERE OD_CNT = 0 OR OD_PRICE =0
	
	-- PRICELIST 데이터 입력
	DECLARE @SHOP_VCODE INT
	SELECT TOP 1 @SHOP_VCODE = SHOP_VCODE FROM TBL_SHOP_ORDERDATA
	
	IF @SHOP_VCODE IN (374, 49, 806)
	BEGIN
		UPDATE	TBL_SHOP_ORDERDATA
		SET		PL_NO = ISNULL(B.PL_NO,0)
		,		G_MODELNO = ISNULL(B.PL_MODELNO,0)
		,		G_CATEGORY = ISNULL(CASE WHEN ISNULL(LEN(PL_CATEGORY),0)>=2 THEN PL_CATEGORY ELSE '00' END,'00')
		,		OD_DATE = DATEADD(SS,-DATEPART(SS,OD_DATE),OD_DATE) -- 초 단위를 없애라!
		FROM	TBL_SHOP_ORDERDATA A
					INNER JOIN
				PRICELIST B
					ON CHECKSUM(OD_GOODSNM) = B.PL_GOODSNM_CS
					AND PL_GOODSNM = OD_GOODSNM
					AND PL_VCODE = @SHOP_VCODE
		OPTION (MAXDOP 1)
	END
	ELSE
	BEGIN
		UPDATE	TBL_SHOP_ORDERDATA
		SET		PL_NO = ISNULL(B.PL_NO,0)
		,		G_MODELNO = ISNULL(B.PL_MODELNO,0)
		,		G_CATEGORY = ISNULL(CASE WHEN ISNULL(LEN(PL_CATEGORY),0)>=2 THEN PL_CATEGORY ELSE '00' END,'00')
		,		OD_DATE = DATEADD(SS,-DATEPART(SS,OD_DATE),OD_DATE) -- 초 단위를 없애라!
		FROM	TBL_SHOP_ORDERDATA A
					INNER JOIN
				PRICELIST B
					ON CHECKSUM(OD_GOODSCODE) = B.PL_GOODSCODE_CS
					AND PL_GOODSCODE = OD_GOODSCODE
					AND PL_VCODE = @SHOP_VCODE
		OPTION (MAXDOP 1)
	END


	-- GOODS 데이터 입력
	UPDATE	TBL_SHOP_ORDERDATA
	SET		G_MODELNO = B.G_MODELNO
	,		G_CATEGORY =  B.G_CATEGORY
	--		수량계산 : 374- 이마트, 47-신세계
	,		OD_CNT = CASE WHEN SHOP_VCODE IN (374,47) AND ISNULL(G_MINPRICE,0) > 1001  AND OD_PRICE > 1000 THEN ROUND((OD_PRICE*1.0)/(G_MINPRICE*1.0),0) ELSE OD_CNT END
	--		단가계산 : 374- 이마트, 47-신세계
	,		OD_PRICE = CASE WHEN SHOP_VCODE IN (374,47) AND ISNULL(G_MINPRICE,0) > 1001 AND OD_PRICE > 1000  THEN G_MINPRICE ELSE OD_PRICE END
	FROM	TBL_SHOP_ORDERDATA A
				INNER JOIN
			ELOC2001.DBO.GOODS B
				ON A.G_MODELNO = B.G_MODELNO
				
	-- 196 PROC 호출 (주문데이터 데이터 입력)
	-- EXEC OLTPLOG_196.OLTPLOG.DBO.UDP_INS_SHOP_ORDERDATA
	-- SSIS PACKAGE에서 실행하도록 처리

