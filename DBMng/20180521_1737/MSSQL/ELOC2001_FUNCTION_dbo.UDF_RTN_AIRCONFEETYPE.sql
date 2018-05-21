/* *************************************************************************
 * NAME : dbo.UDF_RTN_AIRCONFEETYPE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-05-29 13:40:43.593
 *        Modify: 2018-05-03 17:23:34.777
 *        Backup: 20180521_1737
 ************************************************************************* */



--  �ؿܻ�ǰ  

CREATE     FUNCTION [dbo].[UDF_RTN_AIRCONFEETYPE] (@n_goodsnm nvarchar(200))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)
	
	If (charindex('[�ؿ�]',@n_goodsnm) > 0 or charindex('�ؿܻ���Ʈ',@n_goodsnm) > 0 or charindex('�ؿܼ���',@n_goodsnm) > 0 or charindex('�ؿܹ��',@n_goodsnm) > 0 or charindex('�ؿܹ߼�',@n_goodsnm) > 0 or charindex('�ؿ� �����',@n_goodsnm) > 0 or charindex('�ؿܱ��Ŵ���',@n_goodsnm) > 0 or charindex('�ؿ�����',@n_goodsnm) > 0 or charindex('�ؿܹ�����',@n_goodsnm) > 0)
		Begin
			set @return = '6'	
		End
	else If (charindex('�۷ι�����',@n_goodsnm) > 0 or charindex('�۷ι�����',@n_goodsnm) > 0 or charindex('�̱�����۱�',@n_goodsnm) > 0 or charindex('���Ŵ���',@n_goodsnm) > 0 or charindex('���ΰ���',@n_goodsnm) > 0 or charindex('���ΰ���',@n_goodsnm) > 0 or charindex('�Ƹ���',@n_goodsnm) > 0)
		Begin
			set @return = '6'	
		End
	else
		Begin
			set @return = '0'
		End

	RETURN @return 

END


























