/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_INSERT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.06
 *        Modify: 2018-05-03 17:23:35.48
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE          PROC UDP_NB_PRICELIST_INSERT_PROC
	@xintAutoModelNo INT,
	@xstrVcode INT,
	@xstrCate CHAR(8),
	@xstrGoodsNm NVARCHAR(200),
	@xintPrice MONEY,
	@xstrUrl VARCHAR(250),
	@xstrSTATUS CHAR(1),
	@xstrRightnLeft CHAR(1),
	@xstrImgUrl VARCHAR(250),
	@xstrCoupon tinyint
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
   
	IF (@xintAutoModelNo > 0)
	BEGIN
		INSERT INTO PRICELIST(pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_status,pl_Rightnleft,pl_imgurl,pl_coupon)
		VALUES(@xintAutoModelNo,@xstrVcode ,@xstrCate , @xstrGoodsNm , @xintPrice ,@xstrUrl ,@xstrSTATUS,@xstrRightnLeft,@xstrImgUrl,@xstrCoupon)
	END
	Else
	BEGIN
		INSERT INTO PRICELIST(pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_status,pl_Rightnleft,pl_imgurl,pl_coupon)
		VALUES(@xstrVcode ,@xstrCate , @xstrGoodsNm , @xintPrice ,@xstrUrl ,@xstrSTATUS,@xstrRightnLeft,@xstrImgUrl,@xstrCoupon)
	END 
END 
