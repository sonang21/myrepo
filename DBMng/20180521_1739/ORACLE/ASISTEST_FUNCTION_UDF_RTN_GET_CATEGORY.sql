/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_CATEGORY
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-04 18:33:36
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_CATEGORY" (v_modelno NUMBER)
RETURN VARCHAR2 AS
  re_category VARCHAR2(3000);
    tmpCa_code VARCHAR2(3000);

    CURSOR cur_goods_ca_code IS
     SELECT CA_CODE
       FROM TBL_GOODS
      WHERE modelno = v_modelno
    ORDER BY cateflag DESC;

   i_count     NUMBER := 0;

BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_CATEGORY start ......');

   OPEN cur_goods_ca_code;
   LOOP

    FETCH cur_goods_ca_code INTO tmpCa_code;
    EXIT WHEN cur_goods_ca_code%NOTFOUND;

     IF i_count <= 0 THEN
      re_category := tmpCa_code;
     ELSE
      re_category := re_category || ' ' || tmpCa_code;
     END IF;

     i_count := i_count +1;

    END LOOP;
    CLOSE cur_goods_ca_code;

    RETURN re_category;

END;