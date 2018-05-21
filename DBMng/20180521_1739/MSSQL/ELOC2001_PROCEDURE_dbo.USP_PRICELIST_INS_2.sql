/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_INS_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-28 09:28:53.633
 *        Modify: 2018-05-03 17:23:34.257
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [dbo].[USP_PRICELIST_INS_2]
	@PL_VCODE INT, 
	@PL_MODELNO INT,
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
	@PL_ESSTOCKFLAG CHAR(1),	
	@PL_GOODSFACTORY NVARCHAR(50),
	@PL_GOODSCODE VARCHAR(50)	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	INSERT INTO PRICELIST(
		PL_VCODE, PL_MODELNO, PL_CATEGORY, PL_GOODSNM, PL_PRICE,
		PL_URL, PL_STATUS, PL_RIGHTNLEFT, PL_DELIVERYINFO, PL_IMGURL,
		PL_COUPON, PL_ACCOUNT_YN, PL_ESSTOCKFLAG, PL_GOODSFACTORY, PL_GOODSCODE
	) VALUES(
		@PL_VCODE, @PL_MODELNO, @PL_CATEGORY, @PL_GOODSNM, @PL_PRICE,
		@PL_URL, @PL_STATUS, @PL_RIGHTNLEFT, @PL_DELIVERYINFO, @PL_IMGURL,
		@PL_COUPON, @PL_ACCOUNT_YN, @PL_ESSTOCKFLAG, @PL_GOODSFACTORY,@PL_GOODSCODE
	)

END 