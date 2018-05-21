/* *************************************************************************
 * NAME : dbo.UDF_ZUM_CHECK
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-06-03 13:57:43.73
 *        Modify: 2018-05-03 17:23:35.913
 *        Backup: 20180521_1737
 ************************************************************************* */

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].UDF_ZUM_CHECK (@v_shop_code INT)
	RETURNS char(1)
AS
BEGIN
	DECLARE @RET CHAR(1)
	SET @RET='1'
	BEGIN
		SELECT @RET = '0' FROM SHOPLIST WHERE shop_vcode =  @v_shop_code  AND (shop_type='4' or shop_vcode  = 7861);
	END
	RETURN @RET
END
