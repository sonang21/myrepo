/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_MODELNO
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2007-03-09 17:10:25.593
 *        Modify: 2018-05-03 17:23:35.42
 *        Backup: 20180521_1739
 ************************************************************************* */



create      FUNCTION [dbo].[UDF_TEST_RTN_MODELNO] (@VCODE INT, @GOODSNM nvarchar(200), @GOODSCODE varchar(50))

RETURNS INT

AS
BEGIN

	DECLARE @return INT
	
	set @return = 0

	SELECT TOP 1 @return = pl_modelno 
	FROM PRICELIST WITH(READUNCOMMITTED) 
	WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and pl_goodscode_cs = checksum(@GOODSCODE) and pl_modelno > 0 
		

	IF @return = 0
		BEGIN
			SELECT TOP 1 @return = pl_modelno 
			FROM PRICELIST WITH(READUNCOMMITTED) 
			WHERE pl_vcode = @VCODE and pl_goodsnm = @GOODSNM and pl_goodsnm_cs = checksum(@GOODSNM) and pl_modelno > 0 
		END
	
	RETURN @return 
	
END



