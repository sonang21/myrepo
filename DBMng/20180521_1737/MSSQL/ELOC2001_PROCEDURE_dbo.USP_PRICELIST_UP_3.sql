/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:42:17.273
 *        Modify: 2018-05-03 17:23:35.603
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC USP_PRICELIST_UP_3
	@PL_VCODE INT,
	@PL_GOODSNM NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '3', 
		PL_DATE = getdate() 
	WHERE PL_VCODE = @PL_VCODE 
		AND PL_GOODSNM_CS = CHECKSUM(@PL_GOODSNM) 
		AND PL_GOODSNM = @PL_GOODSNM
END