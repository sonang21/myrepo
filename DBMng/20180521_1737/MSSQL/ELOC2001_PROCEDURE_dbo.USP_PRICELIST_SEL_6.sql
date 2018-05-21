/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_6
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 17:41:50.207
 *        Modify: 2018-05-03 17:23:35.793
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_SEL_6
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT PL_NO FROM PRICELIST
	WHERE PL_STATUS IN ('1','2','3','8','9') 
		AND PL_VCODE = @PL_VCODE
	ORDER BY PL_MODELNO DESC
END

