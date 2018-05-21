/* *************************************************************************
 * NAME : DBENURI.UDF_DEAL_CATE_MAPPING3
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_DEAL_CATE_MAPPING3" (code1 varchar2,pcode1 varchar2)
RETURN VARCHAR2 AS
    re_mapping_cate  VARCHAR2(255) := '';
BEGIN
    BEGIN
        SELECT
        (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE SUBSTR(A.PCODE,0,3) = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
        (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.PCODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
        (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.CODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) into re_mapping_cate
        FROM TBL_DAONEDAY_CATE A WHERE A.CODE  = pcode1 AND A.PCODE = code1;
        EXCEPTION WHEN OTHERS THEN
        re_mapping_cate := '';
    END;    
    
    IF re_mapping_cate = '' OR re_mapping_cate is null  THEN
        BEGIN
            SELECT
            (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE SUBSTR(A.PCODE,0,3) = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
            (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.PCODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
            (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.CODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) into re_mapping_cate
            FROM TBL_DAONEDAY_CATE A WHERE A.CODE  = code1 AND A.PCODE = pcode1;    
        END;
    END IF;
RETURN re_mapping_cate;   
    
END;