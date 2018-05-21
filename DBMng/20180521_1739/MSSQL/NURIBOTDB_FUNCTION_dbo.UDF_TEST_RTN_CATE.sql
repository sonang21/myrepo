/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_CATE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2007-04-04 10:14:30.33
 *        Modify: 2015-05-15 00:52:26.02
 *        Backup: 20180521_1739
 ************************************************************************* */







CREATE      FUNCTION [dbo].[UDF_TEST_RTN_CATE] (@VCODE INT, @CATE nvarchar(100))

RETURNS varchar(8)

AS
BEGIN

	DECLARE @return Char (8)
	
	set @return = ''
	
	SELECT @return = replace(isnull(CATEGORY,''),'-','')
	FROM TBL_NB_SHOPCATE WITH(READUNCOMMITTED) 
	WHERE VCODE = @VCODE and CATENAME = @CATE
	
	RETURN @return 
	
END


