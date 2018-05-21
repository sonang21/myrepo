/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_INSERT_PROC_Account_yn
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-05-25 09:32:23.59
 *        Modify: 2015-05-15 03:31:33.957
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE             PROC UDP_NB_PRICELIST_INSERT_PROC_Account_yn
	@xintAutoModelNo INT,
	@xstrVcode INT,
	@xstrCate CHAR(8),
	@xstrGoodsNm NVARCHAR(200),
	@xstrPrice MONEY,
	@xstrUrl VARCHAR(250),
	@xstrSTATUS CHAR(1),
	@xstrRightnLeft CHAR(1),
	@xstrImgUrl VARCHAR(250),
	@xstrCoupon tinyint,
	
	@xstrDelFeeType CHAR(1),
	@xstrDelPrice MONEY,
	@xstrDeliveryFlag CHAR(1),
	@xstrAccount_yn CHAR(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
   
	IF (@xintAutoModelNo > 0)
	BEGIN
		INSERT INTO PRICELIST(pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_status,pl_Rightnleft,pl_imgurl,pl_coupon,pl_delfeetype,pl_delprice,pl_deliveryflag,pl_Account_yn)
		VALUES(@xintAutoModelNo,@xstrVcode ,@xstrCate , @xstrGoodsNm , @xstrPrice ,@xstrUrl ,@xstrSTATUS,@xstrRightnLeft,@xstrImgUrl,@xstrCoupon,@xstrDelFeeType,@xstrDelPrice,@xstrDeliveryFlag,@xstrAccount_yn)
	END
	Else
	BEGIN
		INSERT INTO PRICELIST(pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_status,pl_Rightnleft,pl_imgurl,pl_coupon,pl_delfeetype,pl_delprice,pl_deliveryflag,pl_Account_yn)
		VALUES(@xstrVcode ,@xstrCate , @xstrGoodsNm , @xstrPrice ,@xstrUrl ,@xstrSTATUS,@xstrRightnLeft,@xstrImgUrl,@xstrCoupon,@xstrDelFeeType,@xstrDelPrice,@xstrDeliveryFlag,@xstrAccount_yn)
	END 
END
