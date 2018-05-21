/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_14
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-27 14:45:31.94
 *        Modify: 2018-05-03 17:23:34.017
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_UP_14
	@PL_VCODE INT,
	@PL_GOODSCODE VARCHAR(50),
	@PL_GOODSNM NVARCHAR(200),
	@PL_PRICE MONEY,
	@PL_STATUS CHAR(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	UPDATE PRICELIST
	SET PL_GOODSNM= @PL_GOODSNM,
		PL_PRICE = @PL_PRICE,
		PL_STATUS = @PL_STATUS,
		PL_DATE = GETDATE()
	WHERE PL_VCODE = @PL_VCODE
		AND PL_GOODSCODE = @PL_GOODSCODE
		AND PL_GOODSCODE_CS = CHECKSUM(@PL_GOODSCODE)
		AND PL_GOODSNM<>''
END