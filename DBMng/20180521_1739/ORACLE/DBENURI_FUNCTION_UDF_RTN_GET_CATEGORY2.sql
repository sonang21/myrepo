/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_CATEGORY2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:27:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_CATEGORY2" (v_modelno NUMBER)
RETURN VARCHAR2 AS 
/*
 NGIT 수정 반영 - 김영원 20180418
*/
    re_category VARCHAR2(3000); 
    tmpCa_code VARCHAR2(12); 
    tmpCateflag VARCHAR2(1); 
  
    CURSOR cur_goods_ca_code IS 
     select c.ca_code, c.cateflag
       from tbl_goods a,
            tbl_cate_goods c
      where a.modelno = v_modelno 
        and a.modelno = c.modelno
      order by cateflag desc; 

    i_count     NUMBER := 0; 
    
BEGIN 
 
  OPEN cur_goods_ca_code; 
  LOOP 
 
    FETCH cur_goods_ca_code INTO tmpCa_code,tmpCateflag; 
    EXIT WHEN cur_goods_ca_code%NOTFOUND; 
 
     IF i_count <= 0 THEN 
        re_category := tmpCa_code; 
     ELSE 
        re_category := re_category || ' ' || tmpCa_code; 
     END IF; 
     
     IF tmpCateflag = '0' THEN
        FOR tmp_loop in (SELECT distinct ca_code FROM TBL_GOODS_COPYCATE WHERE ca_sub_code = tmpCa_code) LOOP 
          re_category := re_category || ' ' || tmp_loop.ca_code; 
          i_count := i_count +1; 
        END LOOP; 
     END IF;
 
     i_count := i_count +1; 
 
    END LOOP; 
    CLOSE cur_goods_ca_code; 
 
  RETURN re_category; 
 
END;
 
