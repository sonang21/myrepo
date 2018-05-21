/* *************************************************************************
 * NAME : ASISTEST.UDF_CATEGORY_KEYWORD_POPULAR2
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-07 13:11:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_CATEGORY_KEYWORD_POPULAR2" (v_modelno NUMBER) 
RETURN VARCHAR2 AS 
    
    re_keyword2 VARCHAR2(2600); 
    tmpCa_mcode VARCHAR2(4); 
    tmpCa_scode VARCHAR2(6); 
    tmpCa_dcode VARCHAR2(8); 
    
    tmpCateflag VARCHAR2(1); 
    
    CURSOR cur_goods_ca_code IS 
     
     SELECT SUBSTR(ca_code,0,4),SUBSTR(ca_code,0,6),SUBSTR(ca_code,0,8)
       FROM TBL_GOODS 
      WHERE (modelno_group = v_modelno  OR modelno = v_modelno)
        AND jobcode > '0'
        AND constrain IN ('1','5')
        --AND mallcnt > 0
    GROUP BY SUBSTR(ca_code,0,4),SUBSTR(ca_code,0,6),SUBSTR(ca_code,0,8);

      
    i_count     NUMBER := 0; 
 
BEGIN 
 
   --DBMS_OUTPUT.ENABLE; 
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_CATEGORY start ......'); 
 
   OPEN cur_goods_ca_code; 
   LOOP 
 
        --FETCH cur_goods_ca_code INTO tmpCa_code,tmp_socialprice; 
        FETCH cur_goods_ca_code INTO tmpCa_mcode,tmpCa_scode,tmpCa_dcode; 
        EXIT WHEN cur_goods_ca_code%NOTFOUND;
            
        BEGIN

            FOR tmp_loop in (SELECT DISTINCT K_NAME from TBL_CATEGORY_KEYWORD_POPULAR 
                WHERE (CA_CODE=tmpCa_mcode OR CA_CODE=tmpCa_scode OR CA_CODE=tmpCa_dcode)
            ) LOOP


                IF i_count = 0 THEN 
                   re_keyword2 := tmp_loop.k_name; 
                ELSE 
                    --IF INSTR(re_keyword2,tmp_loop.k_name)=0 THEN
                        re_keyword2 := REPLACE(re_keyword2,tmp_loop.k_name,'');
                        re_keyword2 := re_keyword2 || ' ' || tmp_loop.k_name; 
                        --DBMS_OUTPUT.PUT_LINE('==' || re_keyword2 || '==tmp_loop.k_name1..' || tmp_loop.k_name || '==' || INSTR(re_keyword2,tmp_loop.k_name));
                    --END IF;
                END IF; 
                
                --DBMS_OUTPUT.PUT_LINE('tmp_loop.k_name2..' || tmp_loop.k_name);
                                
                IF LENGTH(re_keyword2) > 1200 THEN
                    EXIT;
                END IF;
                i_count := i_count +1; 

            END LOOP;

        END;
        
    
    END LOOP;    

    CLOSE cur_goods_ca_code; 
 
    RETURN re_keyword2; 
 
END;