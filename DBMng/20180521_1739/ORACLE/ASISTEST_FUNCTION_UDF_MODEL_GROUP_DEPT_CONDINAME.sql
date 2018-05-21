/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_GROUP_DEPT_CONDINAME
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:35
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_GROUP_DEPT_CONDINAME" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS

    v_condiname     VARCHAR2(50):='';
    v_condiname_arr VARCHAR2(2000):='';
    i_count         NUMBER := 0;    
   
    CURSOR cur_group_dept_condiname IS
        select condiname
        from tbl_goods
        where modelno_group = v_modelno_group
        and ca_lcode='86'
        --and cateflag='1'
        and constrain='1'
        and mallcnt>0
        and NVL(minprice4,0) > 0
        and jobcode >'0';

    

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');
    BEGIN
    IF v_modelno_group > 0 THEN    
        OPEN cur_group_dept_condiname;
        LOOP

            FETCH cur_group_dept_condiname INTO v_condiname;
            EXIT WHEN cur_group_dept_condiname%NOTFOUND;

            IF i_count <= 0 THEN
                v_condiname_arr := v_condiname;
            ELSE
                v_condiname_arr := v_condiname_arr || ' ' || v_condiname;
            END IF;
            
            i_count := i_count +1;
            IF i_count > 10 THEN
                EXIT;
            END IF;
            

        END LOOP;
        CLOSE cur_group_dept_condiname;
        
    END IF;
    RETURN v_condiname_arr;            
    END;