/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_STATUS
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2007-03-09 15:11:59.763
 *        Modify: 2018-05-03 17:23:35.403
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE     FUNCTION [dbo].[UDF_TEST_RTN_STATUS] (@modelno int, @cate varchar(8), @p_price money, @n_price money, @vcode int)

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)

	set @return = '1'

		--��ȣ�۾��Ȱ͸� üũ
		IF @modelno > 0 
			Begin
				--���ܾ�ü üũ
				IF ((@vcode = 5843 or @vcode = 5899 or @vcode = 6115 or @vcode = 5889) and left(@cate ,2) = '03')
					Begin
						set @return = '1'
					End 
				Else
					Begin
						--�������� 100% �̻� Ŭ�� 
						--If @n_price > @p_price * 2
						--	Begin
						--		SET @return = '9'
						--	End
						--Else
						--	Begin
								If ((left(@cate ,2) = '08' or left(@cate ,2) = '10') and left(@cate ,4) != '0802' and left(@cate ,4) != '0804' and left(@cate ,4) != '0809' and left(@cate ,4) !='1001' and left(@cate ,4) != '1015')
								--8 �ű�ó��(9 -> 8)
									Begin
										--�������� 30% �̻� ������
										If @n_price < @p_price * 0.7
											Begin
												SET @return = '9'	
											End
									End
						--	End
						
						--8 ������ 
						--		--TV(0201)�з���
						--		If (left(@cate ,4) = '0201')
						--			Begin
						--				--�������� 20% �̻� ������
						--				If @n_price < @p_price * 0.8	
						--					Begin
						--						SET @return = '8'
						--					End
						--				--�������� 100% �̻� Ŭ�� 
						--				Else If @n_price > @p_price * 2
						--					Begin
						--						SET @return = '9'
						--					End
						--			End	
						--		--����/��Ų�����(0909)�з���
						--		Else If (left(@cate ,4) = '0909')
						--			Begin
						--				--�������� 100% �̻� Ŭ�� 
						--				If @n_price > @p_price * 2
						--					Begin
						--						SET @return = '9'
						--					End
						--			End			
						--		--ȭ��ǰ(08)�з���
						--		--Else If (left(@cate ,2) = '08')
						--		--	Begin
						--		--		--�������� 25% �̻� ������
						--		--		If @n_price < @p_price * 0.75	
						--		--			Begin
						--		--				SET @return = '8'
						--		--			End
						--		--		--�������� 100% �̻� Ŭ�� 
						--		--		Else If @n_price > @p_price * 2
						--		--			Begin
						--		--				SET @return = '9'
						--		--			End
						--		--	End			
						--		Else
						--			Begin
						--				--�������� 30% �̻� ������
						--				If @n_price < @p_price * 0.7
						--					Begin
						--						If (left(@cate ,2) = '14' or left(@cate ,2) = '15')
						--							Begin
						--								--�������� 50% �̻� ������
						--								If @n_price < @p_price * 0.5  
						--									Begin
						--										SET @return = '8'	
						--									End					
						--							End
						--						Else
						--							Begin
						--								SET @return = '8'	
						--							End				
						--					End
						--				--�������� 100% �̻� Ŭ�� 
						--				Else If @n_price > @p_price * 2
						--					Begin
						--						SET @return = '9'
						--					End
						--			End
						
					End
			End
		

	RETURN @return 

END


















