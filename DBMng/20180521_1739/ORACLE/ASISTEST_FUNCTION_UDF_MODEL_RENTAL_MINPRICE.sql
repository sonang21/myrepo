/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_RENTAL_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-04 18:33:36
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_RENTAL_MINPRICE" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS

    v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
     FROM tbl_goods
     WHERE (modelno_group = v_modelno_group OR modelno = v_modelno_group)
     AND cateflag='0'
     AND constrain='1'
     AND mallcnt>0
     AND INSTR(NVL(condiname,' '),'렌탈') = 0 
     AND INSTR(NVL(condiname,' '),'중고') = 0
     AND INSTR(NVL(condiname,' '),'중고품') = 0
     AND INSTR(NVL(condiname,' '),'리퍼') = 0
     AND INSTR(NVL(condiname,' '),'기본설치비 미포함') = 0
     AND INSTR(NVL(condiname,' '),'추가구매 필수') = 0
     AND INSTR(NVL(condiname,' '),'옵션필수') = 0
     AND INSTR(NVL(condiname,' '),'할부') = 0
     AND INSTR(NVL(condiname,' '),'인터넷가입조건') = 0
     AND INSTR(NVL(condiname,' '),'사업자전용') = 0
     AND INSTR(NVL(condiname,' '),'등외품') = 0
     AND INSTR(NVL(condiname,' '),'요금제') = 0
     AND INSTR(NVL(condiname,' '),'데이터') = 0
     AND INSTR(NVL(condiname,' '),'토너미포함') = 0
     AND INSTR(NVL(condiname,' '),'잉크미포함') = 0
     AND INSTR(NVL(condiname,' '),'미니어처') = 0 
     AND INSTR(NVL(condiname,' '),'일부지방') = 0 
     AND INSTR(NVL(condiname,' '),'샘플') = 0 
     AND INSTR(NVL(condiname,' '),'리필') = 0 
     AND (CA_LCODE IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND INSTR(NVL(condiname,' '),'해외쇼핑') = 0 )
     AND jobcode >'0';
     
     IF v_minprice = 0 THEN

        v_minprice := v_price;

     END IF;

    RETURN v_minprice;   
    
END;