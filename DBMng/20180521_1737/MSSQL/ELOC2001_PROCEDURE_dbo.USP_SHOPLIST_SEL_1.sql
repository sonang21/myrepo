/* *************************************************************************
 * NAME : dbo.USP_SHOPLIST_SEL_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:01:59.06
 *        Modify: 2018-05-03 17:23:35.957
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_SHOPLIST_SEL_1
	@SHOP_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT SHOP_NAME, SHOP_URL, SHOP_GRADE, SHOP_DATASOURCE, SHOP_SEARCHURL 
	FROM SHOPLIST 
	WHERE SHOP_VCODE = @SHOP_VCODE
END



