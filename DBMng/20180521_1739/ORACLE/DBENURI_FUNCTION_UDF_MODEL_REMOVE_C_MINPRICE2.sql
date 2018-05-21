/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_REMOVE_C_MINPRICE2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:16:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_REMOVE_C_MINPRICE2" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS
/*
 NGIT 수정 반영 - 김영원 20180417
*/
 v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
      FROM tbl_goods a, tbl_goods_sum b
     WHERE a.modelno = v_modelno_group
       AND a.modelno = b.modelno 
       AND a.constrain='1'
       AND b.mallcnt>0
       AND a.ca_code LIKE '0401%'
       AND a.jobcode >'0';
     
     IF v_minprice = 0 THEN
        v_minprice := v_price;
     END IF;

    RETURN v_minprice;
    
END;
