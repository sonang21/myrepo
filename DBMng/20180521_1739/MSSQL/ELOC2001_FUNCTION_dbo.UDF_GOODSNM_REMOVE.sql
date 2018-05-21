/* *************************************************************************
 * NAME : dbo.UDF_GOODSNM_REMOVE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-06-01 20:35:28.953
 *        Modify: 2018-05-03 17:23:36.01
 *        Backup: 20180521_1739
 ************************************************************************* */

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UDF_GOODSNM_REMOVE] (@goodsnm nvarchar(200))
RETURNS nvarchar(200)
AS
BEGIN
	
	DECLARE @strgoodsnm nvarchar(200)
	DECLARE @v_goodsnm_temp nvarchar(200)

	SET @strgoodsnm = @goodsnm

    IF dbo.INSTR(1,@strgoodsnm,'[') > 0 
        IF dbo.INSTR(1,@strgoodsnm,']') > 0                  
            SET @v_goodsnm_temp = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,'['),dbo.INSTR(1,@strgoodsnm,']'))
            IF (dbo.INSTR(1,@v_goodsnm_temp,'%') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'�������') > 0))
				SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm))

        
    IF dbo.INSTR(1,@strgoodsnm,'[') > 0  
        IF dbo.INSTR(1,@strgoodsnm,']') > 0                  
            SET @v_goodsnm_temp = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,'['),dbo.INSTR(1,@strgoodsnm,']'));
            IF (dbo.INSTR(1,@v_goodsnm_temp,'������') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'����') > 0 OR dbo.INSTR(1,@v_goodsnm_temp,'����') > 0))
                SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm));

        
    IF dbo.INSTR(1,@strgoodsnm,'[') > 0  
        IF dbo.INSTR(1,@strgoodsnm,']') > 0                  
            SET @v_goodsnm_temp = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,'['),dbo.INSTR(1,@strgoodsnm,']'));
            
            IF dbo.INSTR(1,@v_goodsnm_temp,'ī��') > 0 AND dbo.INSTR(1,@v_goodsnm_temp,'%') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'����') > 0 OR dbo.INSTR(1,@v_goodsnm_temp,'û��') > 0  OR dbo.INSTR(1,@v_goodsnm_temp,'����') > 0)
                SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm));
    
   
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 2%�߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 3%�߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 5%�߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 7%�߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 10%�߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 2% �߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 3% �߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 5% �߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 7% �߰�����','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������ 10% �߰�����','')
    
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������2%������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������3%������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������5%������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������7%������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������10%������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������2% ������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������3% ������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������5% ������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������7% ������������','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'������10% ������������','')
    
    SET @strgoodsnm = REPLACE(@strgoodsnm,'+',' ')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'_',' ') --������_20141211 (FAN_Wi)
    SET @strgoodsnm = REPLACE(@strgoodsnm,'/',' ') --������_20150406 (FAN_Wi)
    SET @strgoodsnm = LTRIM(RTRIM(@strgoodsnm))
    
    RETURN @strgoodsnm;          

END
