/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_CHK_SRVFLAG
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2008-11-25 09:54:00.293
 *        Modify: 2018-05-03 17:23:35.123
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE FUNCTION [dbo].[UDF_TEST_RTN_CHK_SRVFLAG] (@vcode int, @modelno int, @cate varchar(8), @p_goodsnm nvarchar(200), @n_goodsnm nvarchar(200), @srvflag char(1), @p_price money, @n_price money)

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)

	set @return = @srvflag
	
	--���ݼ���  
	--If (@modelno > 0 and @p_price * 0.5 > @n_price)
	--	Begin
	--		If (charindex('08',@cate) = 1 or charindex('14',@cate) = 1 )
	--			Begin
	--				If (@p_price * 0.3 > @n_price)
	--					Begin
	--						set @return = '3'
	--					End
	--			End
	--		Else
	--			Begin
	--				set @return = '3'
	--			End
	--	End
		
	-- �𵨸� ���� ����
	If (@srvflag = 'M')
		Begin
			set @return = '0'
		End 
	Else If (@srvflag <> 'S' and @srvflag <> 'L' and @n_goodsnm <> @p_goodsnm and @modelno < 1)
		Begin
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
			else If (charindex('������',@n_goodsnm) > 0 or charindex('����',@n_goodsnm) > 0 or charindex('�����',@n_goodsnm) > 0 or charindex('������',@n_goodsnm) > 0 or charindex('����������',@n_goodsnm) > 0 or charindex('�ڹ���ƽ',@n_goodsnm) > 0)
				Begin
					set @return = 'S'	
				End
			else if (charindex('SA��',@n_goodsnm) > 0)
				Begin
					set @return = '9'	
				End
			-- ��ǰ üũ
		End

	RETURN @return 

END




























