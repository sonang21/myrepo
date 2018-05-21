/* *************************************************************************
 * NAME : dbo.UDF_RTN_SHOP_SERVICE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.42
 *        Modify: 2018-05-03 17:23:35.81
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE  FUNCTION UDF_RTN_SHOP_SERVICE  (@vcode INT)
RETURNS char(1)
AS
BEGIN
	DECLARE  @return varchar(1)
		SELECT @return =  shop_service FROM DBO.SHOPLIST WITH (READUNCOMMITTED)
		WHERE shop_vcode = @vcode
	RETURN @return 
END

