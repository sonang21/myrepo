/* *************************************************************************
 * NAME : ES_APP.UDF_MODEL_GROUP_MINPRICE_ETC
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:45:28
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODEL_GROUP_MINPRICE_ETC" (v_modelno_group NUMBER,gubun NUMBER)
RETURN NUMBER AS

     v_minprice NUMBER(12) :=0;

BEGIN

    IF gubun=3 THEN
    
         SELECT NVL(MIN(minprice3),0) minprice INTO v_minprice
         FROM tbl_goods
         --WHERE modelno_group = v_modelno_group
         WHERE (modelno_group = v_modelno_group  OR modelno = v_modelno_group)
         AND cateflag='0'
         AND constrain IN ('1','5')
         AND mallcnt>0
         AND NVL(minprice3,0) > 0
         AND jobcode >'0';
    
    ELSIF gubun = 4 THEN
         SELECT NVL(MIN(minprice4),0) minprice INTO v_minprice
         FROM tbl_goods
         WHERE (modelno_group = v_modelno_group  OR modelno = v_modelno_group)
         AND cateflag='0'
         AND constrain IN ('1','5')
         AND mallcnt>0
         AND NVL(minprice4,0) > 0
         AND jobcode >'0';
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    ELSIF gubun = 2 THEN
         SELECT NVL(MIN(minprice2),0) minprice INTO v_minprice
         FROM tbl_goods
         WHERE (modelno_group = v_modelno_group  OR modelno = v_modelno_group)
         AND cateflag='0'
         AND constrain IN ('1','5')
         AND mallcnt>0
         AND NVL(minprice2,0) > 0
         AND jobcode >'0';     
    /*중고/렌탈 제외 nova23 2016.12.13*/     
    ELSIF gubun = 5 THEN
         SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
         FROM tbl_goods
         WHERE (modelno_group = v_modelno_group  OR modelno = v_modelno_group)
         AND cateflag='0'
         AND constrain IN ('1','5')
         AND mallcnt>0
         AND NVL(minprice2,0) > 0
         AND jobcode >'0'      
         AND EXT_CONDI_FLAG = '0';    
    END IF;

    RETURN v_minprice;   
    
END;