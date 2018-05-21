/* *************************************************************************
 * NAME : ASISTEST.UDF_ZUM_CHECK
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_ZUM_CHECK" (v_shop_code NUMBER) 
RETURN VARCHAR2 AS 
    v_reault char(1) := '1';
BEGIN
    BEGIN
        SELECT '0'  INTO v_reault FROM TBL_SHOPLIST
        WHERE SHOP_CODE =  v_shop_code
        AND (shop_type='4' or shop_code = 7861);
        EXCEPTION WHEN OTHERS THEN
            v_reault := '1';
    END;                
    RETURN v_reault;
END;