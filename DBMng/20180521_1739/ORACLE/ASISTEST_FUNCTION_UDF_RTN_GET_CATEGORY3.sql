/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_CATEGORY3
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_CATEGORY3" (v_modelno NUMBER) 
RETURN VARCHAR2 AS 
    re_category VARCHAR2(3000); 
    tmpCa_code VARCHAR2(12); 
    tmpCateflag VARCHAR2(1); 
    tmp_sub_ca_code VARCHAR2(12); 
    tmp_socialprice NUMBER(10);
 
    CURSOR cur_goods_ca_code IS 
     --SELECT ca_code, MIN(NVL(socialprice,0)) socialprice
     SELECT ca_code
       FROM TBL_GOODS 
      WHERE (modelno_group = v_modelno  OR modelno = v_modelno)
        AND jobcode > '0'
        AND constrain IN ('1','5')
        GROUP BY ca_code;
        --AND mallcnt > 0;
      
    i_count     NUMBER := 0; 
 
BEGIN 
 
   --DBMS_OUTPUT.ENABLE; 
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_CATEGORY start ......'); 
 
   OPEN cur_goods_ca_code; 
   LOOP 
 
    --FETCH cur_goods_ca_code INTO tmpCa_code,tmp_socialprice; 
    FETCH cur_goods_ca_code INTO tmpCa_code; 
    EXIT WHEN cur_goods_ca_code%NOTFOUND; 
        
        --IF SUBSTR(tmpCa_code,0,4) <> '8701' OR tmp_socialprice > 0 THEN
            IF i_count <= 0 THEN 
                re_category := tmpCa_code; 
            ELSE 
                IF i_count <= 20 THEN
                    re_category := re_category || ' ' || tmpCa_code; 
                END IF;            
            END IF; 
        --END IF;
     /*
     IF tmpCateflag = '0' THEN
        FOR tmp_loop in (SELECT distinct ca_code FROM TBL_GOODS_COPYCATE WHERE ca_sub_code = tmpCa_code) LOOP 
          re_category := re_category || ' ' || tmp_loop.ca_code; 
          i_count := i_count +1; 
        END LOOP; 
     END IF;
     */
     i_count := i_count +1; 
 
    END LOOP; 
    CLOSE cur_goods_ca_code; 
 
    RETURN re_category; 
 
END;