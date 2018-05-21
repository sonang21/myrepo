/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_5
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:49:17.087
 *        Modify: 2018-05-03 17:23:35.667
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_UP_5
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
		AND PL_DATE < DATEADD(D, -29,GETDATE())
END
