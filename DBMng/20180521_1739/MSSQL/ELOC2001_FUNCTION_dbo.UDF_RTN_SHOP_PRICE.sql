/* *************************************************************************
 * NAME : dbo.UDF_RTN_SHOP_PRICE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2005-07-20 16:37:52.967
 *        Modify: 2018-05-03 17:23:35.25
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE    FUNCTION UDF_RTN_SHOP_PRICE  (@MODELNO INT,@VCODE INT)
RETURNS INT
AS
BEGIN
	DECLARE  @return INT
		SELECT @return =  min(pl_price) FROM DBO.PRICELIST WITH (READUNCOMMITTED)
		WHERE
			pl_modelno = @MODELNO
			and pl_vcode = @VCODE
			and pl_status < '3'
			and pl_srvflag = '0'
	RETURN @return 
END

