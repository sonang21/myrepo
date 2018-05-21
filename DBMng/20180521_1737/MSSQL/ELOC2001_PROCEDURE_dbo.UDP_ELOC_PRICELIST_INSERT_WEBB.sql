/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_INSERT_WEBB
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-08-26 15:17:08.17
 *        Modify: 2018-05-03 17:23:34.513
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE                   PROC [dbo].[UDP_ELOC_PRICELIST_INSERT_WEBB]

	@MODELNO		INT,
	@VCODE			INT,
	@CATEGORY		VARCHAR(8),
	@PL_GOODSNM		NVARCHAR(400),
	@PRICE			MONEY,
	@URL			VARCHAR(255),
	@SRVFLAG		CHAR(1),
	@RIGHTNLEFT		CHAR(1),
	@DELIVERY		VARCHAR(100),
	@IMGURL		VARCHAR(255),
	@COUPON		INT,
	@ACCOUNT_YN		CHAR(1),
	@ESSTOCKFLAG		CHAR(1),
	@GOODSFACTORY	VARCHAR(50),
	@GOODSCODE		VARCHAR(50),
	@FREEINTEREST		VARCHAR(50),

	@PLNO		bigINT	OUTPUT,
	@iRETURN	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		IF @MODELNO > 0
		BEGIN
			--IF @RIGHTNLEFT = '1'
			--BEGIN
			--	INSERT INTO PRICELIST (pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_delfeedesc, pl_delareadesc, pl_goodsfactory, pl_goodscode)
			--	VALUES(@MODELNO, @VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '0', 0, '1', '', '',@GOODSFACTORY, @GOODSCODE)
			--END
			--ELSE IF @RIGHTNLEFT = '2'
			--BEGIN
			--	INSERT INTO PRICELIST (pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_goodsfactory, pl_goodscode)
			--	VALUES(@MODELNO, @VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '1', 0, '1',@GOODSFACTORY, @GOODSCODE)
			--END
			--ELSE
			--BEGIN
			--	INSERT INTO PRICELIST (pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_delfeedesc, pl_delareadesc, pl_goodsfactory, pl_goodscode)
			--	VALUES(@MODELNO, @VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '', 0, '0', '', '',@GOODSFACTORY, @GOODSCODE)
			--END

			INSERT INTO PRICELIST (pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_deliveryinfo, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag,  pl_goodsfactory, pl_goodscode, pl_freeinterest)
			VALUES(@MODELNO, @VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @DELIVERY, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, @GOODSFACTORY, @GOODSCODE, @FREEINTEREST)

		END
		ELSE
		BEGIN
			--IF @RIGHTNLEFT = '1'
			--BEGIN
			--	INSERT INTO PRICELIST ( pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_delfeedesc, pl_delareadesc, pl_goodsfactory, pl_goodscode)
			--	VALUES(@VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '0', 0, '1', '', '',@GOODSFACTORY, @GOODSCODE)
			--END
			--ELSE IF @RIGHTNLEFT = '2'
			--BEGIN
			--	INSERT INTO PRICELIST (pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_goodsfactory, pl_goodscode)
			--	VALUES(@VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '1', 0, '1',@GOODSFACTORY, @GOODSCODE)
			--END
			--ELSE
			--BEGIN
			--	INSERT INTO PRICELIST ( pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_delfeetype, pl_delprice, pl_deliveryflag, pl_delfeedesc, pl_delareadesc, pl_goodsfactory, pl_goodscode)
			--	VALUES(@VCODE, @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, '', 0, '0', '', '',@GOODSFACTORY, @GOODSCODE)
			--END

			INSERT INTO PRICELIST ( pl_vcode, pl_modelno,  pl_category, pl_goodsnm, pl_price, pl_url, pl_srvflag, pl_status, pl_rightnleft, pl_deliveryinfo, pl_imgurl, pl_coupon,  pl_account_yn, pl_esstockflag, pl_goodsfactory, pl_goodscode, pl_freeinterest)
			VALUES(@VCODE, 0,  @CATEGORY, @PL_GOODSNM, @PRICE, @URL, @SRVFLAG, '0', @RIGHTNLEFT, @DELIVERY, @IMGURL, @COUPON, @ACCOUNT_YN, @ESSTOCKFLAG, @GOODSFACTORY, @GOODSCODE, @FREEINTEREST)
		END

		SET @PLNO=SCOPE_IDENTITY()

	IF @@ERROR<>0
	BEGIN
		SET @iRETURN = 99
	END
	ELSE
	BEGIN
		SET @iRETURN = 0
	END

END
