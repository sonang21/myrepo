/* *************************************************************************
 * NAME : ASISTEST.UDF_GET_GOODSNM_GPMATCH
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-07 13:11:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_GET_GOODSNM_GPMATCH" (v_pl_no NUMBER) 
RETURN VARCHAR2 AS 
 
    v_goodsnm     VARCHAR2(4000):=''; 
     
BEGIN     
    IF v_pl_no > 0 THEN 
        
        select goodsnm INTO v_goodsnm  from(
        select pl_no_group,shop_code,goodsnm from tbl_goods_search_list  where pl_no_group = v_pl_no 
        ORDER  BY (case when nvl(shop_code,0) = 75 then 1 else case when nvl(shop_code,0) = 663 then 2 else case when nvl(shop_code,0) = 47 then 3 else case when nvl(shop_code,0) = 6665 then 4 else 5 end end end end) , price
        ) where rownum = 1;
         
    END IF; 
     
    RETURN v_goodsnm;             
END;