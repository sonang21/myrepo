/* *************************************************************************
 * NAME : ES_APP.UDF_MODEL_GROUP_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:45:27
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODEL_GROUP_MINPRICE" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS
    v_minprice VARCHAR2(50):='';
    v_minprice_arr VARCHAR2(1000):='';
    i_count     NUMBER := 0;

    CURSOR cur_group_minprice IS
     select minprice
       from tbl_goods
      where modelno_group = v_modelno_group
      and cateflag='0'
      and constrain='1'
      and mallcnt>0
      and jobcode >'0';

BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');
    IF v_modelno_group > 0 THEN    
        OPEN cur_group_minprice;
        LOOP

        FETCH cur_group_minprice INTO v_minprice;
        EXIT WHEN cur_group_minprice%NOTFOUND;

         IF i_count <= 0 THEN
          v_minprice_arr := v_minprice;
         ELSE
          v_minprice_arr := v_minprice_arr || ' ' || v_minprice;
         END IF;

         i_count := i_count +1;
         IF i_count > 50 THEN
            EXIT;
         END IF;
            

        END LOOP;
        CLOSE cur_group_minprice;
   END IF;
    RETURN v_minprice_arr;
END;