/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_FEETYPE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2007-03-19 17:53:11.077
 *        Modify: 2018-05-03 17:23:35.52
 *        Backup: 20180521_1737
 ************************************************************************* */



-- ������ ��ġ�� ����

CREATE     FUNCTION [dbo].[UDF_TEST_RTN_FEETYPE] (@vcode int, @modelno int, @cate varchar(8), @p_goodsnm nvarchar(200), @n_goodsnm nvarchar(200), @airconfeetype char(1))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)

	set @return = @airconfeetype

	-- �𵨸� ���� ����
	If (@n_goodsnm <> @p_goodsnm and @modelno > 0)
		Begin 
			--����������ü  (47,49,57,75,90,241,374,663,806,974,1878)
			If (@vcode <> 47 and @vcode <> 49 and @vcode <> 57 and @vcode <> 75 and @vcode <> 90 and @vcode <> 241 and @vcode <> 374 and @vcode <> 663 and @vcode <> 806 and @vcode <> 974 and @vcode <> 1878)
				Begin
					--��ġ�� üũ
					If (left(@cate ,4) = '0501' and left(@cate ,6) <> '050101' and left(@cate ,6) <> '050110')
						Begin
							If (charindex('��ġ�񹫷�',@n_goodsnm) > 0 or charindex('��ġ�� ����',@n_goodsnm) > 0 or charindex('��ġ������',@n_goodsnm) > 0 or charindex('��ġ�� ����',@n_goodsnm) > 0 or charindex('��ġ����',@n_goodsnm) > 0 or charindex('���ἳġ',@n_goodsnm) > 0 or charindex('��ġ����',@n_goodsnm) > 0)
								Begin
									set @return = '1'	
								End
							else If (charindex('��ġ���ι���',@n_goodsnm) > 0 or charindex('��ġ���� ����',@n_goodsnm) > 0 or charindex('��ġ�� ��ι���',@n_goodsnm) > 0 or charindex('��ġ�� ��� ����',@n_goodsnm) > 0 )
								Begin
									set @return = '1'	
								End
							else If (charindex('��ġ��������',@n_goodsnm) > 0 or charindex('��ġ���� ����',@n_goodsnm) > 0 or charindex('��ġ�� �������',@n_goodsnm) > 0 or charindex('��ġ�� ��� ����',@n_goodsnm) > 0 )
								Begin
									set @return = '1'	
								End
							else If (charindex('��ġ��ι���',@n_goodsnm) > 0 or charindex('��ġ��� ����',@n_goodsnm) > 0 or charindex('��ġ ��ι���',@n_goodsnm) > 0 or charindex('��ġ ��� ����',@n_goodsnm) > 0 )
								Begin
									set @return = '1'	
								End
							else If (charindex('��ġ�������',@n_goodsnm) > 0 or charindex('��ġ��� ����',@n_goodsnm) > 0 or charindex('��ġ �������',@n_goodsnm) > 0 or charindex('��ġ ��� ����',@n_goodsnm) > 0 )
								Begin
									set @return = '1'	
								End
							else
								Begin
									set @return = '0'
								End
						End
				End
		End
	
	RETURN @return 

END















