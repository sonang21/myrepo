/* *************************************************************************
 * NAME : ASISTEST.UDF_CATEGORY_KEYWORD_POPULAR
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:33
 *        Modify: 2018-05-07 13:11:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_CATEGORY_KEYWORD_POPULAR" (v_ca_code varchar2)
RETURN VARCHAR2 AS

    k_name      TBL_CATEGORY_KEYWORD_POPULAR.k_name%TYPE := '';
    k_name_list VARCHAR2(2000):=' ';
    
    v_ca_mcode VARCHAR2(4):=SUBSTR(v_ca_code,0,4);
    v_ca_scode VARCHAR2(6):=SUBSTR(v_ca_code,0,6);
   
    CURSOR cur_category_keyword_popular IS
    SELECT K_NAME from TBL_CATEGORY_KEYWORD_POPULAR 
    WHERE (CA_CODE = v_ca_mcode OR CA_CODE = v_ca_scode OR CA_CODE = v_ca_code);

    i_count     NUMBER := 0;

BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');

    OPEN cur_category_keyword_popular;
    
        LOOP

            FETCH cur_category_keyword_popular INTO k_name;
            EXIT WHEN cur_category_keyword_popular%NOTFOUND;

            IF i_count = 0 THEN
                k_name_list := k_name;
            ELSE
                k_name_list := k_name_list || ' ' || k_name;
            END IF;

            i_count := i_count +1;

        END LOOP;
        
    CLOSE cur_category_keyword_popular;

    RETURN k_name_list;

END;