/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_DEPT_CA_CODE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-11 17:18:07
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_DEPT_CA_CODE" (v_modelno NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180418
*/ 
    re_category VARCHAR2(10); 

BEGIN

  BEGIN 
    re_category := '';
    
     SELECT c.ca_code INTO re_category
       FROM TBL_GOODS a, TBL_GOODS_SUM b, TBL_CATE_GOODS c 
      WHERE a.modelno = b.modelno
        AND a.modelno = c.modelno
        AND (a.modelno_group=v_modelno OR a.modelno=v_modelno)
        and c.ca_lcode='86'
        AND a.jobcode > '0'
        AND a.constrain IN ('1','5')
        AND b.mallcnt > 0
        AND NVL(b.minprice4,0) > 0
        AND rownum=1;
 
  EXCEPTION WHEN OTHERS THEN
      re_category := '';
        
  END;
    
  RETURN re_category; 
    
END;
