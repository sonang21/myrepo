/* *************************************************************************
 * NAME : dbo.UDF_RTN_DELIVERYINFO
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2011-01-05 15:23:17.02
 *        Modify: 2018-05-03 17:23:36.02
 *        Backup: 20180521_1737
 ************************************************************************* */





/***** [UDF_RTN_DELIVERYINFO] ������� ó�� *****/
CREATE FUNCTION [dbo].[UDF_RTN_DELIVERYINFO] (@delivery nvarchar(50))
RETURNS nvarchar(50)
AS
BEGIN

	DECLARE  @return varchar(50)
	SET @return = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@delivery,',',''), '����','0000'),'��',''),' ',''),'���űݾ׿�������ۺ�','')
	
	IF (ISNUMERIC(@return) = 1)
		BEGIN
			IF (@return = '0' OR @return = '-1')
				BEGIN
					SET @return = '������'
				END
			ELSE IF (@return = '99999' or @return = '99990' or @return = '99900' or @return = '999900' or @return = '999000')	
				BEGIN
					SET @return = '������'	
				END
		END
	ELSE
		BEGIN
			IF (@return = '����' or @return = '�����ںδ�(����)')	
				BEGIN
					SET @return = '����'	
				END
			ELSE IF (@return = '����')
				BEGIN
					SET @return = '����'	
				END
			ELSE IF (@return = '')
				BEGIN
					SET @return = '������'	
				END
			ELSE IF (CHARINDEX(@return,'����,������,��۹���,��۷ṫ��,��ۺ񹫷�,[�⺻��ġ�񹫷�/������],0�̻󹫷�') > 0)	
				BEGIN
					SET @return = '������'	
				END
			ELSE IF (CHARINDEX(@return,'����,������,�������,��ġ������') > 0)	
				BEGIN
					SET @return = '����'
				END
			ELSE IF (CHARINDEX(@return,'������,��������,���ž׺���۷�����,�������,��ۺ��ȯ') > 0)	
				BEGIN
					SET @return = '������'	
				END
			ELSE IF (ISNUMERIC(REPLACE(REPLACE(REPLACE(REPLACE(@return,'������',''),'����',''),'����/������',''),'���Ҽ�����','')) = 1)
				BEGIN
					SET @return = REPLACE(REPLACE(REPLACE(REPLACE(@return,'������',''),'����',''),'����/������',''),'���Ҽ�����','')
				END
			ELSE IF (CHARINDEX('����', @delivery) > 0 and CHARINDEX('��', @delivery) > 0 and CHARINDEX('�̻� ����', @delivery) > 0)	
				BEGIN
					SET @return = replace(replace(@delivery,left(replace(@delivery,'�̻� ����','�� �̸�'), charindex('��',replace(@delivery,'�̻� ����','�� �̸�'))),'') + left(replace(@delivery,'�̻� ����','�� �̸�'), charindex('��',replace(@delivery,'�̻� ����','�� �̸�'))),'�̻� ��������','�� �̸�')
				END		
			ELSE
				BEGIN
					SET @return = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@delivery,',',''),'����','0000��'),'õ��','000��'),'�̻� ����','�̻󹫷�'),'����������','����')
				END

			IF (CHARINDEX('�� �̸� ��',@delivery) > 0)	
				BEGIN
					SET @return = '������'
				END
		END

	RETURN @return 
	
END



























