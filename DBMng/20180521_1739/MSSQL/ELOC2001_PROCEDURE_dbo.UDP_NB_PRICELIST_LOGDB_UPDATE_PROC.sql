/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_LOGDB_UPDATE_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.23
 *        Modify: 2018-05-03 17:23:35.53
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE          PROC UDP_NB_PRICELIST_LOGDB_UPDATE_PROC
	@xstrVcode int,
	@xstrCate VARCHAR(8),
	@xstrPrice MONEY,	
	@xstrUrl VARCHAR(250),	
	@xstrStatus CHAR(1),
	@xstrGoodsnm NVARCHAR(400),
	@xstrRightnLeft CHAR(1),
	@xstrImgUrl VARCHAR(250),
	@xstrCoupon tinyint	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		UPDATE PRICELIST 
		SET pl_category = @xstrCate ,pl_price = @xstrPrice ,pl_url = @xstrUrl ,pl_status = @xstrStatus ,pl_date = getdate() ,pl_rightnleft=@xstrRightnLeft ,pl_imgurl=@xstrImgUrl, pl_coupon=@xstrCoupon
		WHERE pl_vcode = @xstrVcode and pl_goodsnm = @xstrGoodsnm
		
END
