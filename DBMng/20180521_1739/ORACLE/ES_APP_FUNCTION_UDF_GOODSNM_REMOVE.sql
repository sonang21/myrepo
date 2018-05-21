/* *************************************************************************
 * NAME : ES_APP.UDF_GOODSNM_REMOVE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:43:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_GOODSNM_REMOVE" (v_goodsnm VARCHAR2) 
RETURN VARCHAR2 AS 
     
     v_goodsnm_temp     VARCHAR2(400):=''; 
     strgoodsnm         VARCHAR2(400):=''; 
     i                  NUMBER(2);
     
BEGIN     

    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_SUM_POPULAR start ......');
    
    strgoodsnm := v_goodsnm;
    --FOR i IN 1..2 LOOP
        IF INSTR(strgoodsnm,'[') > 0 THEN 
            IF INSTR(strgoodsnm,']') > 0 THEN                 
                v_goodsnm_temp := SUBSTR(strgoodsnm,INSTR(strgoodsnm,'['),INSTR(strgoodsnm,']'));
                IF (INSTR(v_goodsnm_temp,'%') > 0 AND (INSTR(v_goodsnm_temp,'즉시할인') > 0))
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                END IF;
            END IF;
        END IF; 
        
        IF INSTR(strgoodsnm,'[') > 0 THEN 
            IF INSTR(strgoodsnm,']') > 0 THEN                 
                v_goodsnm_temp := SUBSTR(strgoodsnm,INSTR(strgoodsnm,'['),INSTR(strgoodsnm,']'));
                IF (INSTR(v_goodsnm_temp,'에누리') > 0 AND (INSTR(v_goodsnm_temp,'할인') > 0 OR INSTR(v_goodsnm_temp,'쿠폰') > 0))
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                END IF;
            END IF;
        END IF; 
        
        IF INSTR(strgoodsnm,'[') > 0 THEN 
            IF INSTR(strgoodsnm,']') > 0 THEN                 
                v_goodsnm_temp := SUBSTR(strgoodsnm,INSTR(strgoodsnm,'['),INSTR(strgoodsnm,']'));
                --DBMS_OUTPUT.PUT_LINE('v_goodsnm_temp=' || v_goodsnm_temp);                
                IF INSTR(v_goodsnm_temp,'카드') > 0 AND INSTR(v_goodsnm_temp,'%') > 0 AND (INSTR(v_goodsnm_temp,'할인') > 0 OR INSTR(v_goodsnm_temp,'청구') > 0  OR INSTR(v_goodsnm_temp,'적립') > 0)
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                    --DBMS_OUTPUT.PUT_LINE('strgoodsnm=' || strgoodsnm);
                END IF;                
            END IF;
        END IF; 
    --END LOOP;
    
   
    strgoodsnm := REPLACE(strgoodsnm,'에누리 2%추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 3%추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 5%추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 7%추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 10%추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 2% 추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 3% 추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 5% 추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 7% 추가할인','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리 10% 추가할인','');
    
    strgoodsnm := REPLACE(strgoodsnm,'에누리2%할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리3%할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리5%할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리7%할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리10%할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리2% 할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리3% 할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리5% 할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리7% 할인쿠폰적용','');
    strgoodsnm := REPLACE(strgoodsnm,'에누리10% 할인쿠폰적용','');
    
    
    strgoodsnm := REPLACE(strgoodsnm,'+',' ');
    strgoodsnm := REPLACE(strgoodsnm,'_',' '); --조은정_20141211 (FAN_Wi)
    strgoodsnm := REPLACE(strgoodsnm,'/',' '); --조은정_20150406 (FAN_Wi)
    strgoodsnm := LTRIM(RTRIM(strgoodsnm));
    
    RETURN strgoodsnm;             
END;