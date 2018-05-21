/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_ES_PRICE_CATE_C00
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-13 17:01:04
 *        Modify: 2018-04-20 14:25:58
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_ES_PRICE_CATE_C00" 
IS

BEGIN
     
     EXECUTE IMMEDIATE 'TRUNCATE TABLE ES_APP.TMP_ES_PRICE_CATE_01';
     EXECUTE IMMEDIATE 'TRUNCATE TABLE ES_APP.TMP_PRICE_DATA_01';

     
     INSERT /*+ PARALLEL(3) APPEND */ INTO ES_APP.TMP_ES_PRICE_CATE_01
     SELECT   CATEGORY_TMP
            , UDF_CATEGORY_ALL(CATEGORY_TMP)   AS CATALL 
            , UDF_CATEGORY_SUB(CATEGORY_TMP,2) AS CAT1  
            , UDF_CATEGORY_SUB(CATEGORY_TMP,4) AS CAT2  
            , UDF_CATEGORY_SUB(CATEGORY_TMP,6) AS CAT3  
            , UDF_CATEGORY_SUB(CATEGORY_TMP,8) AS CAT4  
     FROM (
            SELECT DISTINCT 
                   CASE WHEN SERVICE_GUBUN='2' AND STORE_FLAG='1' AND CA_DEPT_CODE IS NOT NULL THEN 
                             RTRIM(CATEGORY || ' ' || CA_DEPT_CODE)
                        ELSE CATEGORY 
                        END  AS CATEGORY_TMP 
              FROM ES_APP.TMP_ES_PRICE_DATA_01 -- 2.5¾ï°Ç 
           )
     ;
     
     COMMIT;

/*EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;*/

END;
