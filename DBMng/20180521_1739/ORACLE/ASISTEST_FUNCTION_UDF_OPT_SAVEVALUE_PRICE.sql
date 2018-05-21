/* *************************************************************************
 * NAME : ASISTEST.UDF_OPT_SAVEVALUE_PRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_OPT_SAVEVALUE_PRICE" (v_shop_code NUMBER, v_price NUMBER, v_pl_no NUMBER)
RETURN NUMBER
IS
    i_price       NUMBER := 0;
    v_opt_savevalue NUMBER := 0;
BEGIN

  SELECT NVL(o.opt_savevalue, 0) opt_savevalue
    INTO v_opt_savevalue
    FROM TBL_OPTIONTITLE t, TBL_OPTION o
   WHERE t.shop_code = v_shop_code
     AND t.pl_no = v_pl_no
     AND t.opt_title like '즉시할인%'
     AND t.shop_code = o.shop_code
     AND t.pl_no = o.pl_no
     AND o.opt_savevalue > 0
     AND rownum = 1;

 IF  v_opt_savevalue > 0 THEN
    i_price := v_opt_savevalue;
 ELSE
    i_price := v_price;
 END IF;

 RETURN i_price;

EXCEPTION
 WHEN OTHERS THEN
  i_price := v_price;
  RETURN i_price;
END;