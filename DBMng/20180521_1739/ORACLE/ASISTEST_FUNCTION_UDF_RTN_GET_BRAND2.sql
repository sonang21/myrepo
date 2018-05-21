/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_BRAND2
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_BRAND2" (v_modelno NUMBER)
RETURN VARCHAR2 AS
    v_gb_no tbl_goods_brand_detail.gb2_no%TYPE := 0;
    tmpGb_No_List VARCHAR2(4000):= ' ';

    CURSOR cur_goods_brand IS
     select gb2_no
       from tbl_goods_brand_detail
      where modelno in (select modelno from tbl_goods WHERE (modelno_group = v_modelno  OR modelno = v_modelno) AND jobcode > '0' AND constrain IN ('1','5') AND mallcnt > 0 AND cateflag='0')
      group by  gb2_no;

   i_count     NUMBER := 0;

BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND2 start ......');

   OPEN cur_goods_brand;
   LOOP

    FETCH cur_goods_brand INTO v_gb_no;
    EXIT WHEN cur_goods_brand%NOTFOUND;

     IF i_count <= 0 THEN
      tmpGb_No_List := v_gb_no;
     ELSE
      tmpGb_No_List := tmpGb_No_List || ' ' || v_gb_no;
     END IF;
     
     --IF length(tmpGb_No_List) > 3800 THEN
     --   EXIT;
     --END IF
     
     i_count := i_count +1;

    END LOOP;
    CLOSE cur_goods_brand;

    RETURN tmpGb_No_List;

END;