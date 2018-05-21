/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_GROUP_MINPRICE_ETC
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:04:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_GROUP_MINPRICE_ETC" (v_modelno_group NUMBER,gubun NUMBER)
RETURN NUMBER AS
/*
 NGIT 수정 반영 - 김영원 20180417
*/
     v_minprice NUMBER(12) :=0;

BEGIN

    IF gubun=3 THEN
    
         SELECT NVL(MIN(b.minprice3),0) minprice INTO v_minprice
         FROM tbl_goods a, tbl_goods_sum b
         WHERE a.modelno = b.modelno 
         AND (a.modelno_group = v_modelno_group  OR a.modelno = v_modelno_group)
         AND a.constrain IN ('1','5')
         AND b.mallcnt>0
         AND NVL(b.minprice3,0) > 0
         AND a.jobcode >'0';
    
    ELSIF gubun = 4 THEN
         SELECT NVL(MIN(b.minprice4),0) minprice INTO v_minprice
         FROM tbl_goods a, tbl_goods_sum b
         WHERE a.modelno = b.modelno 
         AND (a.modelno_group = v_modelno_group  OR a.modelno = v_modelno_group)
         AND a.constrain IN ('1','5')
         AND b.mallcnt>0
         AND NVL(b.minprice4,0) > 0
         AND a.jobcode >'0';
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    ELSIF gubun = 2 THEN
         SELECT NVL(MIN(b.minprice2),0) minprice INTO v_minprice
         FROM tbl_goods a, tbl_goods_sum b
         WHERE a.modelno = b.modelno 
         AND (a.modelno_group = v_modelno_group  OR a.modelno = v_modelno_group)
         AND a.constrain IN ('1','5')
         AND b.mallcnt>0
         AND NVL(b.minprice2,0) > 0
         AND a.jobcode >'0';
    /*중고/렌탈 제외 nova23 2016.12.13*/     
    ELSIF gubun = 5 THEN
         SELECT NVL(MIN(b.minprice),0) minprice INTO v_minprice
         FROM tbl_goods a, tbl_goods_sum b
         WHERE a.modelno = b.modelno 
         AND (a.modelno_group = v_modelno_group  OR a.modelno = v_modelno_group)
         AND a.constrain IN ('1','5')
         AND b.mallcnt>0
         AND NVL(b.minprice2,0) > 0
         AND a.jobcode >'0'
         AND a.EXT_CONDI_FLAG = '0';    
    END IF;

    RETURN v_minprice;   
    
END;
