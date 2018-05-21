/* *************************************************************************
 * NAME : ES_APP.UDF_RTN_GET_DEPT_CA_CODE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:53
 *        Modify: 2018-03-30 16:45:28
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_RTN_GET_DEPT_CA_CODE" (v_modelno NUMBER) 
RETURN VARCHAR2 AS 
    re_category VARCHAR2(10); 

BEGIN

    BEGIN 
 
   --DBMS_OUTPUT.ENABLE; 
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_CATEGORY start ......'); 
    re_category := '';
    
    --SELECT SUBSTR(ca_code,0,6) INTO re_category
    SELECT ca_code INTO re_category
       FROM TBL_GOODS 
      WHERE (modelno_group=v_modelno OR modelno=v_modelno)
        and ca_lcode='86'
        AND jobcode > '0'
        AND constrain IN ('1','5')
        AND mallcnt > 0
        AND NVL(minprice4,0) > 0
        AND rownum=1;
 
    EXCEPTION WHEN OTHERS THEN
        re_category := '';
        
    END;
    
    RETURN re_category; 
    
END;