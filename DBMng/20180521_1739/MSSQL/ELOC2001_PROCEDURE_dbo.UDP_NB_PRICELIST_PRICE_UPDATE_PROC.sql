/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_PRICE_UPDATE_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.467
 *        Modify: 2018-05-03 17:23:35.59
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE     PROC UDP_NB_PRICELIST_PRICE_UPDATE_PROC
	@xstrVcode INT,
	@xstrCate VARCHAR(8),
	@xintPrice MONEY,
	@xstrUrl VARCHAR(250),
	@rtnStrStatus CHAR(1),
	@xstrGoodsNm NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		UPDATE PRICELIST SET pl_category = @xstrCate ,pl_price = @xintPrice ,pl_url = @xstrUrl ,pl_status = @rtnStrStatus ,pl_date = getdate()
		WHERE pl_vcode = @xstrVcode and pl_goodsnm = @xstrGoodsNm
END
