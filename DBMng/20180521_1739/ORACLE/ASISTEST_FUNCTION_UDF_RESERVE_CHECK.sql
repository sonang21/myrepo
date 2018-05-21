/* *************************************************************************
 * NAME : ASISTEST.UDF_RESERVE_CHECK
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RESERVE_CHECK" (v_modelno NUMBER) 
RETURN VARCHAR2 AS 
    v_result char(1) := '0';
BEGIN
    BEGIN
        SELECT '1'  INTO v_result FROM TBL_GOODS_CHANGE where is_reserve = '1' and modelno in (
          select modelno from tbl_goods where modelno in (select nvl(modelno_group,modelno) from tbl_goods where modelno = v_modelno)
          union all
          select modelno from tbl_goods where modelno_group in (select nvl(modelno_group,modelno) from tbl_goods where modelno = v_modelno)
        ) AND ROWNUM = 1;
        EXCEPTION WHEN OTHERS THEN
            v_result := '0';
    END;
    RETURN v_result;
END;