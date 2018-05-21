/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_CATEGORY3
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 19:23:21
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_CATEGORY3" (v_modelno NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180418
*/  
    re_category VARCHAR2(3000); 
    tmpCa_code VARCHAR2(12); 
 
    CURSOR cur_goods_ca_code IS 
     SELECT c.ca_code
       FROM TBL_GOODS a, TBL_CATE_GOODS c
      WHERE a.modelno = c.modelno
        AND (a.modelno_group = v_modelno  OR a.modelno = v_modelno)
        AND a.jobcode > '0'
        AND a.constrain IN ('1','5')
      GROUP BY c.ca_code;
      
    i_count     NUMBER := 0; 
 
BEGIN 
 
  OPEN cur_goods_ca_code; 
  LOOP 
 
    FETCH cur_goods_ca_code INTO tmpCa_code; 
    EXIT WHEN cur_goods_ca_code%NOTFOUND; 
        
     IF i_count <= 0 THEN 
         re_category := tmpCa_code; 
     ELSE 
       IF i_count <= 20 THEN
           re_category := re_category || ' ' || tmpCa_code; 
       END IF;            
     END IF; 

     i_count := i_count +1; 
 
  END LOOP; 
  CLOSE cur_goods_ca_code; 
 
  RETURN re_category; 
 
END;
