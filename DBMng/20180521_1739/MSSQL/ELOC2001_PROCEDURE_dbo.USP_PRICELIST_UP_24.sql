/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_24
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-27 18:16:07.477
 *        Modify: 2018-05-03 17:23:34.223
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_UP_24]
	@PL_VCODE INT, 
	@PL_GOODSCODE VARCHAR(50),

	@PL_CATEGORY VARCHAR(8),
	@PL_GOODSNM NVARCHAR(200),
	@PL_PRICE MONEY,
	@PL_URL VARCHAR(500),
	@PL_STATUS CHAR(1),
	@PL_RIGHTNLEFT CHAR(1),
	@PL_DELIVERYINFO NVARCHAR(100),
	@PL_IMGURL VARCHAR(250),
	@PL_COUPON TINYINT,
	@PL_ACCOUNT_YN CHAR(1),
	@PL_GOODSFACTORY NVARCHAR(50),
	@PL_AIRCONFEETYPE CHAR(1),
	@PL_FREEINTEREST NVARCHAR(50)	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	UPDATE PRICELIST
	SET PL_CATEGORY = @PL_CATEGORY,
		PL_GOODSNM = @PL_GOODSNM,
		PL_PRICE = @PL_PRICE,
		PL_URL = @PL_URL,
		PL_STATUS = (CASE WHEN @PL_STATUS='0' AND PL_STATUS='1' THEN PL_STATUS ELSE @PL_STATUS END),
		PL_DATE = GETDATE(),
		PL_RIGHTNLEFT = @PL_RIGHTNLEFT,
		PL_DELIVERYINFO = @PL_DELIVERYINFO,
		PL_IMGURL = @PL_IMGURL,
		PL_COUPON = @PL_COUPON,
		PL_ACCOUNT_YN = @PL_ACCOUNT_YN,
		PL_GOODSFACTORY = @PL_GOODSFACTORY,
		PL_AIRCONFEETYPE = @PL_AIRCONFEETYPE,
		PL_FREEINTEREST = @PL_FREEINTEREST,
		PL_IMGURLFLAG = (CASE WHEN PL_IMGURL<>@PL_IMGURL THEN '0' ELSE PL_IMGURLFLAG END)
	WHERE PL_VCODE = @PL_VCODE
		AND PL_GOODSCODE = @PL_GOODSCODE
		AND PL_GOODSCODE_CS = CHECKSUM(@PL_GOODSCODE) 
		
END
