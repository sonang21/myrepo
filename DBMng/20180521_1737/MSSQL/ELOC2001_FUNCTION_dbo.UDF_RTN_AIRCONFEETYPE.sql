/* *************************************************************************
 * NAME : dbo.UDF_RTN_AIRCONFEETYPE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-05-29 13:40:43.593
 *        Modify: 2018-05-03 17:23:34.777
 *        Backup: 20180521_1737
 ************************************************************************* */



--  해외상품  

CREATE     FUNCTION [dbo].[UDF_RTN_AIRCONFEETYPE] (@n_goodsnm nvarchar(200))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)
	
	If (charindex('[해외]',@n_goodsnm) > 0 or charindex('해외사이트',@n_goodsnm) > 0 or charindex('해외쇼핑',@n_goodsnm) > 0 or charindex('해외배송',@n_goodsnm) > 0 or charindex('해외발송',@n_goodsnm) > 0 or charindex('해외 직배송',@n_goodsnm) > 0 or charindex('해외구매대행',@n_goodsnm) > 0 or charindex('해외직구',@n_goodsnm) > 0 or charindex('해외무료배송',@n_goodsnm) > 0)
		Begin
			set @return = '6'	
		End
	else If (charindex('글로벌셀러',@n_goodsnm) > 0 or charindex('글로벌쇼핑',@n_goodsnm) > 0 or charindex('미국직배송구',@n_goodsnm) > 0 or charindex('구매대행',@n_goodsnm) > 0 or charindex('관부가세',@n_goodsnm) > 0 or charindex('관부과세',@n_goodsnm) > 0 or charindex('아마존',@n_goodsnm) > 0)
		Begin
			set @return = '6'	
		End
	else
		Begin
			set @return = '0'
		End

	RETURN @return 

END


























