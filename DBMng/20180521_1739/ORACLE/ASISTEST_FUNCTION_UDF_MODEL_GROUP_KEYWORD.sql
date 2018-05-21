/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_GROUP_KEYWORD
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:35
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_GROUP_KEYWORD" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS

    v_keyword     VARCHAR2(2600):='';
    v_keyword_arr VARCHAR2(2600):='';
    i_count         NUMBER := 0;    
   
    CURSOR cur_group_keyword IS
        select distinct keyword
        from tbl_goods
        where modelno_group = v_modelno_group
        and cateflag='0'
        and constrain='1'
        and mallcnt>0
        and jobcode >'0';

    BEGIN
    
   --DBMS_OUTPUT.ENABLE(1000000);
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');    
    IF v_modelno_group > 0 THEN    
        OPEN cur_group_keyword;
        LOOP

            FETCH cur_group_keyword INTO v_keyword;
            EXIT WHEN cur_group_keyword%NOTFOUND;

            IF i_count <= 0 THEN
                IF v_keyword is not null THEN
                    v_keyword_arr := v_keyword;
                END IF;
            ELSE
                IF v_keyword is not null THEN
                  v_keyword_arr := v_keyword_arr || ' ' || v_keyword;
                END IF;
            END IF;
            
            IF length(v_keyword_arr) >= 1000 THEN
                EXIT;
            END IF;
            
            i_count := i_count +1;
            IF i_count > 20 THEN
                EXIT;
            END IF;
            

        END LOOP;
        CLOSE cur_group_keyword;
        
    END IF;
    RETURN v_keyword_arr;            
    END;