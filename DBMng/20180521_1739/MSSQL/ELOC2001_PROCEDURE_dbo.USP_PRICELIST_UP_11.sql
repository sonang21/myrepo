/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_11
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:09:14.95
 *        Modify: 2018-05-03 17:23:36.027
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC USP_PRICELIST_UP_11
	@PL_VCODE INT,
	@PL_NO bigINT,
	@PL_GOODSNM NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '5', 
		PL_DATE = GETDATE() 
	WHERE PL_VCODE = @PL_VCODE
		AND PL_NO = @PL_NO 
		AND PL_GOODSNM_CS = CHECKSUM(@PL_GOODSNM) 
		AND PL_GOODSNM = @PL_GOODSNM 
END

