/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_REMOVE_C_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:35
 *        Modify: 2018-05-04 18:33:35
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_REMOVE_C_MINPRICE" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS

    v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
     FROM tbl_goods
     WHERE (modelno_group = v_modelno_group OR modelno = v_modelno_group)
     --WHERE modelno_group = v_modelno_group
     AND cateflag='0'
     AND constrain='1'
     AND mallcnt>0
     AND NVL(condiname,' ') NOT LIKE '%렌탈%'
     AND NVL(condiname,' ') NOT LIKE '%중고%'
     AND NVL(condiname,' ') NOT LIKE '%중고품%'
     AND NVL(condiname,' ') NOT LIKE '%리퍼%'
     AND NVL(condiname,' ') NOT LIKE '%기본설치비 미포함%'
     AND NVL(condiname,' ') NOT LIKE '%추가구매 필수%'
     AND NVL(condiname,' ') NOT LIKE '%옵션필수%'
     AND NVL(condiname,' ') NOT LIKE '%할부%'
     AND NVL(condiname,' ') NOT LIKE '%인터넷가입조건%'
     AND NVL(condiname,' ') NOT LIKE '%사업자전용%'
     AND NVL(condiname,' ') NOT LIKE '%등외품%'
     AND NVL(condiname,' ') NOT LIKE '%요금제%'
     AND NVL(condiname,' ') NOT LIKE '%데이터%'
     AND NVL(condiname,' ') NOT LIKE '%토너미포함%'
     AND NVL(condiname,' ') NOT LIKE '%잉크미포함%'
     AND NVL(condiname,' ') NOT LIKE '%미니어처%'
     AND NVL(condiname,' ') NOT LIKE '%일부지방%'
     AND NVL(condiname,' ') NOT LIKE '%샘플%'
     AND NVL(condiname,' ') NOT LIKE '%리필%'
     AND (CA_LCODE IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND NVL(condiname,' ') NOT LIKE '%해외쇼핑%') 
     AND jobcode >'0';
     
     IF v_minprice = 0 THEN

        v_minprice := v_price;

     END IF;

    RETURN v_minprice;   
    
    
END;