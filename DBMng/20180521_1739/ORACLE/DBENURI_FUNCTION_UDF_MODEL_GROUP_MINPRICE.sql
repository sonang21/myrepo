/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_GROUP_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:03:19
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_GROUP_MINPRICE" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180417
*/
    v_minprice VARCHAR2(50):='';
    v_minprice_arr VARCHAR2(1000):='';
    i_count     NUMBER := 0;

    CURSOR cur_group_minprice IS
     select b.minprice
       from tbl_goods a, tbl_goods_sum b
      where a.modelno = b.modelno
        and a.modelno_group = v_modelno_group
        and a.constrain='1'
        and b.mallcnt>0
        and a.jobcode >'0';

BEGIN

    IF v_modelno_group > 0 THEN    
        OPEN cur_group_minprice;
        LOOP

        FETCH cur_group_minprice INTO v_minprice;
        EXIT WHEN cur_group_minprice%NOTFOUND;

         IF i_count <= 0 THEN
          v_minprice_arr := v_minprice;
         ELSE
          v_minprice_arr := v_minprice_arr || ' ' || v_minprice;
         END IF;

         i_count := i_count +1;
         IF i_count > 50 THEN
            EXIT;
         END IF;

        END LOOP;
        CLOSE cur_group_minprice;
   END IF;
    RETURN v_minprice_arr;
END;
 
