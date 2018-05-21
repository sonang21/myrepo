/* *************************************************************************
 * NAME : DBENURI.UDF_GOODSNM_REMOVE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-19 18:32:48
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_GOODSNM_REMOVE" (v_goodsnm VARCHAR2) 
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
                IF (INSTR(v_goodsnm_temp,'%') > 0 AND (INSTR(v_goodsnm_temp,'�������') > 0))
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                END IF;
            END IF;
        END IF; 
        
        IF INSTR(strgoodsnm,'[') > 0 THEN 
            IF INSTR(strgoodsnm,']') > 0 THEN                 
                v_goodsnm_temp := SUBSTR(strgoodsnm,INSTR(strgoodsnm,'['),INSTR(strgoodsnm,']'));
                IF (INSTR(v_goodsnm_temp,'������') > 0 AND (INSTR(v_goodsnm_temp,'����') > 0 OR INSTR(v_goodsnm_temp,'����') > 0))
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                END IF;
            END IF;
        END IF; 
        
        IF INSTR(strgoodsnm,'[') > 0 THEN 
            IF INSTR(strgoodsnm,']') > 0 THEN                 
                v_goodsnm_temp := SUBSTR(strgoodsnm,INSTR(strgoodsnm,'['),INSTR(strgoodsnm,']'));
                --DBMS_OUTPUT.PUT_LINE('v_goodsnm_temp=' || v_goodsnm_temp);                
                IF INSTR(v_goodsnm_temp,'ī��') > 0 AND INSTR(v_goodsnm_temp,'%') > 0 AND (INSTR(v_goodsnm_temp,'����') > 0 OR INSTR(v_goodsnm_temp,'û��') > 0  OR INSTR(v_goodsnm_temp,'����') > 0)
                THEN 
                    strgoodsnm := SUBSTR(strgoodsnm,INSTR(strgoodsnm,']')+1,LENGTH(strgoodsnm));
                    --DBMS_OUTPUT.PUT_LINE('strgoodsnm=' || strgoodsnm);
                END IF;                
            END IF;
        END IF; 
    --END LOOP;
    
   
    strgoodsnm := REPLACE(strgoodsnm,'������ 2%�߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 3%�߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 5%�߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 7%�߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 10%�߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 2% �߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 3% �߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 5% �߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 7% �߰�����','');
    strgoodsnm := REPLACE(strgoodsnm,'������ 10% �߰�����','');
    
    strgoodsnm := REPLACE(strgoodsnm,'������2%������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������3%������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������5%������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������7%������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������10%������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������2% ������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������3% ������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������5% ������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������7% ������������','');
    strgoodsnm := REPLACE(strgoodsnm,'������10% ������������','');
    
    
    strgoodsnm := REPLACE(strgoodsnm,'+',' ');
    strgoodsnm := REPLACE(strgoodsnm,'_',' '); --������_20141211 (FAN_Wi)
    strgoodsnm := REPLACE(strgoodsnm,'/',' '); --������_20150406 (FAN_Wi)
    strgoodsnm := LTRIM(RTRIM(strgoodsnm));
    
    RETURN strgoodsnm;             
END;