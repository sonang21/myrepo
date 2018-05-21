/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_6
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:51:40.443
 *        Modify: 2018-05-03 17:23:35.69
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_UP_6
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '3' 
	WHERE PL_VCODE = @PL_VCODE
		AND PL_MODELNO > 0 
		AND PL_GOODSNM = '' 
		AND PL_GOODSNM_CS = CHECKSUM('') 
		AND PL_STATUS < '3' 
		AND PL_DATE < DATEADD(D, -2,GETDATE())
END