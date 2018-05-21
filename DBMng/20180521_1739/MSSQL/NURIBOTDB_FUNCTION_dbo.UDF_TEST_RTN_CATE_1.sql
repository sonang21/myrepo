/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_CATE_1
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2012-11-09 13:15:28.673
 *        Modify: 2015-05-15 00:52:26.017
 *        Backup: 20180521_1739
 ************************************************************************* */





CREATE      FUNCTION [dbo].[UDF_TEST_RTN_CATE_1] (@VCODE INT, @CATE nvarchar(100))

RETURNS varchar(8)

AS
BEGIN

	DECLARE @return Char (8)
	set @return = ''

	DECLARE @GroupChk Char (8)
	set @GroupChk = ''
	
    SELECT @GroupChk = replace(GROUPINFO,' ','') FROM TBL_NB_SHOPLIST WITH(READUNCOMMITTED) WHERE VCODE = @VCODE
	
	If (charindex(replace(@GroupChk,' ',''),'E1,E2,E3') > 0)
		BEGIN
			set @return = @CATE
		END
	Else
		BEGIN
			SELECT @return = replace(isnull(CATEGORY,''),'-','')
			FROM TBL_NB_SHOPCATE WITH(READUNCOMMITTED) 
			WHERE VCODE = @VCODE and CATENAME = @CATE
		END
	
	RETURN @return 
	
END


