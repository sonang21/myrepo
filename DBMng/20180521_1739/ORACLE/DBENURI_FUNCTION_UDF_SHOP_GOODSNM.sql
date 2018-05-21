/* *************************************************************************
 * NAME : DBENURI.UDF_SHOP_GOODSNM
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-19 18:33:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_SHOP_GOODSNM" (v_modelno NUMBER) 
RETURN VARCHAR2 AS 
 
    v_goodsnm     VARCHAR2(4000):=''; 
     
BEGIN     
    IF v_modelno > 0 THEN 
        SELECT goodsnm INTO v_goodsnm 
        FROM TBL_GOODS_GROUP_GOODSNM
        WHERE modelno=v_modelno ; 
    END IF; 
     
    --v_goodsnm := ''; 
    RETURN v_goodsnm;             
END;