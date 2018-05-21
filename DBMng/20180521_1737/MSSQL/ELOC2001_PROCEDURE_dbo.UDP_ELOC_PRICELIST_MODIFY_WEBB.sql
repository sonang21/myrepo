/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_MODIFY_WEBB
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-08-26 16:05:18.797
 *        Modify: 2018-05-03 17:23:34.517
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE                                  PROC [dbo].[UDP_ELOC_PRICELIST_MODIFY_WEBB]

	@CHKFLAG		CHAR(1),

	@MODELNO_BE		CHAR(1),
	@MODELNO		INT,
	@PL_GOODSNM		NVARCHAR(400),
	@PRICE			MONEY,
	@URL			VARCHAR(255),
	@STATUS		CHAR(1),
	@RIGHTNLEFT		CHAR(1),
	@DELIVERY		VARCHAR(100),
	@IMGURL		VARCHAR(255),
	@COUPON		INT,
	@ACCOUNT_YN		CHAR(1),
	@GOODSFACTORY	VARCHAR(50),
	@VCODE			INT,
	@GOODSCODE		VARCHAR(50),
	@FREEINTEREST		VARCHAR(50),
	@APPLY_BASIS		CHAR(1),
	@CATEGORY		VARCHAR(8),
	@PL_NO			bigINT,

	@iRETURN	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	IF @CHKFLAG = '2'
	BEGIN
		UPDATE PRICELIST SET pl_status = @STATUS WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
	END
	ELSE IF @CHKFLAG = '6'
	BEGIN
		UPDATE PRICELIST SET pl_category = @CATEGORY WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
	END
	ELSE
	BEGIN
		IF  @APPLY_BASIS = '1'  or  ( @MODELNO > 0 and  @MODELNO_BE = '0' )
		--IF  @MODELNO > 0 and @APPLY_BASIS = '1'
		BEGIN
			--IF @RIGHTNLEFT = '1'
			--BEGIN
			--	UPDATE PRICELIST
			--	SET pl_modelno = @MODELNO,pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='0', pl_delprice=0, pl_deliveryflag='1', pl_delfeedesc ='', pl_delareadesc='', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END

			--ELSE IF @RIGHTNLEFT = '2'
			--BEGIN
			--	UPDATE PRICELIST
			--	SET  pl_modelno = @MODELNO,pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='1', pl_delprice=0, pl_deliveryflag='1', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END

			--ELSE
			--BEGIN
			--	UPDATE PRICELIST
			--	SET  pl_modelno = @MODELNO,pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='', pl_delprice=0, pl_deliveryflag='0', pl_delfeedesc ='', pl_delareadesc='', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END

			UPDATE PRICELIST
			SET  pl_modelno = @MODELNO,pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_deliveryinfo = @DELIVERY, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN,  pl_goodsfactory = @GOODSFACTORY , pl_freeinterest = @FREEINTEREST
			WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
		END

		ELSE
		BEGIN
			--IF @RIGHTNLEFT = '1'
			--BEGIN
			--	UPDATE PRICELIST
			--	SET pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL,	pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='0', pl_delprice=0, pl_deliveryflag='1', pl_delfeedesc ='', pl_delareadesc='', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END

			--ELSE IF @RIGHTNLEFT = '2'
			--BEGIN
			--	UPDATE PRICELIST
			--	SET pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='1', pl_delprice=0, pl_deliveryflag='1', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END
			--ELSE
			--BEGIN
			--	UPDATE PRICELIST
			--	SET pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_delfeetype='', pl_delprice=0, pl_deliveryflag='0', pl_delfeedesc ='', pl_delareadesc='', pl_goodsfactory = @GOODSFACTORY
			--	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE
			--END

			UPDATE PRICELIST
			SET pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_srvflag = '0', pl_status = @STATUS, pl_date = getdate(), pl_rightnleft = @RIGHTNLEFT, pl_deliveryinfo = @DELIVERY, pl_imgurl= @IMGURL, pl_coupon = @COUPON, pl_account_yn = @ACCOUNT_YN, pl_goodsfactory = @GOODSFACTORY, pl_freeinterest = @FREEINTEREST
			WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
		END
 	END
 	IF @@ERROR<>0
 	BEGIN
 		SET @iRETURN = 99
 	END
 	ELSE
 	BEGIN
 		SET @iRETURN = 0
 	END

END
