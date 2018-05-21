/* *************************************************************************
 * NAME : DBENURI.UDF_DEAL_CATE_MAPPING2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_DEAL_CATE_MAPPING2" (v_shop_code varchar2,v_ep_cate_name varchar2)
RETURN VARCHAR2 AS
    re_mapping_cate  VARCHAR2(255) := '';
BEGIN
    SELECT
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE SUBSTR(A.DA_PCODE,0,3) = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.DA_PCODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.DA_CODE = TBL_DAONEDAY_CATE.CODE and rownum = 1)  into re_mapping_cate
    FROM TBL_DAONEDAY_CATE_MAPPING A WHERE MAPPING_FROM  = v_shop_code AND INSTR ( EP_CATE_NAME , v_ep_cate_name) > 0;
RETURN re_mapping_cate;   
    
END;