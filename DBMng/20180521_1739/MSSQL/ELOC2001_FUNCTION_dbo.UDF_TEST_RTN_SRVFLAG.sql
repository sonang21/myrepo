/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_SRVFLAG
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2008-04-03 16:45:12.65
 *        Modify: 2018-05-03 17:23:36.05
 *        Backup: 20180521_1739
 ************************************************************************* */








-- ���� Ű���� ����

CREATE     FUNCTION [dbo].[UDF_TEST_RTN_SRVFLAG] (@n_goodsnm nvarchar(200))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)
	
	-- ���ο�ǰ üũ
	If (charindex('���ο�ǰ',@n_goodsnm) > 0 or charindex('����',@n_goodsnm) > 0 or charindex('�ܵ�',@n_goodsnm) > 0 or charindex('���λ���Ʈ',@n_goodsnm) > 0 or charindex('��������',@n_goodsnm) > 0 or charindex('Ŭ���丮��',@n_goodsnm) > 0 or charindex('�ֹ�',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('���ڼ���',@n_goodsnm) > 0 or charindex('�����',@n_goodsnm) > 0 or charindex('����',@n_goodsnm) > 0 or charindex('�ֳ�',@n_goodsnm) > 0 or charindex('������',@n_goodsnm) > 0 or charindex('���ġ��',@n_goodsnm) > 0 or charindex('ĢĢ��',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('�����ͺ��̼�',@n_goodsnm) > 0 or charindex('��Ÿ����',@n_goodsnm) > 0 or charindex('Ŀ�Ҹ�����',@n_goodsnm) > 0 or charindex('���ⱸ',@n_goodsnm) > 0 or charindex('����Ȱ',@n_goodsnm) > 0 or charindex('�ƽ�Ʈ�α۶��̵�',@n_goodsnm) > 0 or charindex('SM��ǰ',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('��������',@n_goodsnm) > 0 or charindex('���Ƽ��',@n_goodsnm) > 0 or charindex('���긵',@n_goodsnm) > 0 or charindex('��Ÿ����',@n_goodsnm) > 0 or charindex('�������ⱸ',@n_goodsnm) > 0 or charindex('���λ�ǰ',@n_goodsnm) > 0 or charindex('���ο�����',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('������',@n_goodsnm) > 0 or charindex('����',@n_goodsnm) > 0 or charindex('�����',@n_goodsnm) > 0 or charindex('������',@n_goodsnm) > 0 or charindex('����������',@n_goodsnm) > 0  or charindex('�ڹ���ƽ',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else if (charindex('SA��',@n_goodsnm) > 0)
		Begin
			set @return = '9'	
		End
	else if (charindex('��Ʈ���ɾ�',@n_goodsnm) > 0 and (charindex('������',@n_goodsnm) > 0 or charindex('����',@n_goodsnm) > 0 or charindex('�������',@n_goodsnm) > 0))
		Begin
			set @return = '9'	
		End
	else
		Begin
			set @return = '0'
		End

	RETURN @return 

END
























