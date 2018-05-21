/* *************************************************************************
 * NAME : dbo.UDF_GOODSNM_REMOVE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-06-01 20:35:28.953
 *        Modify: 2018-05-03 17:23:36.01
 *        Backup: 20180521_1737
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
            IF (dbo.INSTR(1,@v_goodsnm_temp,'%') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'즉시할인') > 0))
				SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm))

        
    IF dbo.INSTR(1,@strgoodsnm,'[') > 0  
        IF dbo.INSTR(1,@strgoodsnm,']') > 0                  
            SET @v_goodsnm_temp = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,'['),dbo.INSTR(1,@strgoodsnm,']'));
            IF (dbo.INSTR(1,@v_goodsnm_temp,'에누리') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'할인') > 0 OR dbo.INSTR(1,@v_goodsnm_temp,'쿠폰') > 0))
                SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm));

        
    IF dbo.INSTR(1,@strgoodsnm,'[') > 0  
        IF dbo.INSTR(1,@strgoodsnm,']') > 0                  
            SET @v_goodsnm_temp = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,'['),dbo.INSTR(1,@strgoodsnm,']'));
            
            IF dbo.INSTR(1,@v_goodsnm_temp,'카드') > 0 AND dbo.INSTR(1,@v_goodsnm_temp,'%') > 0 AND (dbo.INSTR(1,@v_goodsnm_temp,'할인') > 0 OR dbo.INSTR(1,@v_goodsnm_temp,'청구') > 0  OR dbo.INSTR(1,@v_goodsnm_temp,'적립') > 0)
                SET @strgoodsnm = dbo.SUBSTRB(@strgoodsnm,dbo.INSTR(1,@strgoodsnm,']')+1,LEN(@strgoodsnm));
    
   
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 2%추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 3%추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 5%추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 7%추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 10%추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 2% 추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 3% 추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 5% 추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 7% 추가할인','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리 10% 추가할인','')
    
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리2%할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리3%할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리5%할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리7%할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리10%할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리2% 할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리3% 할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리5% 할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리7% 할인쿠폰적용','')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'에누리10% 할인쿠폰적용','')
    
    SET @strgoodsnm = REPLACE(@strgoodsnm,'+',' ')
    SET @strgoodsnm = REPLACE(@strgoodsnm,'_',' ') --조은정_20141211 (FAN_Wi)
    SET @strgoodsnm = REPLACE(@strgoodsnm,'/',' ') --조은정_20150406 (FAN_Wi)
    SET @strgoodsnm = LTRIM(RTRIM(@strgoodsnm))
    
    RETURN @strgoodsnm;          

END
