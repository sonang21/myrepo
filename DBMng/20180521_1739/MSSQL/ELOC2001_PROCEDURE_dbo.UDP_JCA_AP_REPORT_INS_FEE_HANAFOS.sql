/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_INS_FEE_HANAFOS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-18 11:05:37.55
 *        Modify: 2018-05-03 17:23:35.253
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_INS_FEE_HANAFOS]
	@SHOPCODE	INT,
	@YEAR		INT,
	@MONTH		INT,
	@DAY		INT,
	@MONEY		MONEY
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.03.18
	-- 설  명 : AP 업체 수수료 데이터 입력
	-- 실  행 : UDP_JCA_AP_REPORT_INS_FEE_HANAFOS 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	IF NOT EXISTS(SELECT TOP 1 * FROM TBL_AP_SHOP_HANAFOS WHERE AS_SHOP=@SHOPCODE AND AS_DATE_YEAR=@YEAR AND AS_DATE_MONTH=@MONTH)
	BEGIN
		INSERT INTO TBL_AP_SHOP_HANAFOS (AS_SHOP, AS_DATE_YEAR, AS_DATE_MONTH)
		VALUES (@SHOPCODE, @YEAR, @MONTH)		
	END

	-- 수수료 데이터 업데이트
	UPDATE	TBL_AP_SHOP_HANAFOS
	SET		AS_MONTH = @MONEY
	WHERE	AS_SHOP = @SHOPCODE AND
			AS_DATE_YEAR = @YEAR AND
			AS_DATE_MONTH = @MONTH
