/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_CATEGORY
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:27:32
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_CATEGORY" (v_modelno NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180418
*/
  re_category VARCHAR2(3000);
  tmpCa_code VARCHAR2(3000);

  CURSOR cur_goods_ca_code IS
    SELECT c.ca_code
      FROM tbl_goods a,
           tbl_cate_goods c
     WHERE a.modelno = v_modelno
       AND a.modelno = c.modelno
     ORDER BY cateflag DESC;

   i_count     NUMBER := 0;

BEGIN

  OPEN cur_goods_ca_code;
  LOOP

    FETCH cur_goods_ca_code INTO tmpCa_code;
    EXIT WHEN cur_goods_ca_code%NOTFOUND;

     IF i_count <= 0 THEN
      re_category := tmpCa_code;
     ELSE
      re_category := re_category || ' ' || tmpCa_code;
     END IF;

     i_count := i_count +1;

    END LOOP;
    CLOSE cur_goods_ca_code;

  RETURN re_category;

END;
 
