/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_BRAND2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:26:58
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_BRAND2" (v_modelno NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180418
*/
    v_gb_no tbl_goods_brand_detail.gb2_no%TYPE := 0;
    tmpGb_No_List VARCHAR2(4000):= ' ';

    CURSOR cur_goods_brand IS
     select gb2_no
       from tbl_goods_brand_detail
      where modelno in (select a.modelno
                          from tbl_goods a, tbl_goods_sum b
                         where (a.modelno_group = v_modelno or a.modelno = v_modelno)
                           and a.modelno = b.modelno 
                           and a.jobcode > '0'
                           and a.constrain in ('1','5')
                           and b.mallcnt > 0)
      group by gb2_no;

   i_count     NUMBER := 0;

BEGIN

   OPEN cur_goods_brand;
   LOOP

    FETCH cur_goods_brand INTO v_gb_no;
    EXIT WHEN cur_goods_brand%NOTFOUND;

     IF i_count <= 0 THEN
      tmpGb_No_List := v_gb_no;
     ELSE
      tmpGb_No_List := tmpGb_No_List || ' ' || v_gb_no;
     END IF;
     
     i_count := i_count +1;

   END LOOP;
   CLOSE cur_goods_brand;

  RETURN tmpGb_No_List;

END;
