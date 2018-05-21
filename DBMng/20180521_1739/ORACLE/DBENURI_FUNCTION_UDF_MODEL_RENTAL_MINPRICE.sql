/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_RENTAL_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:21:30
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_RENTAL_MINPRICE" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS
/*
 NGIT 수정 반영 - 김영원 20180417
*/
    v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(b.minprice),0) minprice INTO v_minprice
      FROM tbl_goods a, tbl_goods_sum b
     WHERE (a.modelno_group = v_modelno_group OR a.modelno = v_modelno_group)
       AND a.modelno = b.modelno 
       AND a.constrain='1'
       AND b.mallcnt>0
       AND INSTR(NVL(a.condiname,' '),'렌탈') = 0 
       AND INSTR(NVL(a.condiname,' '),'중고') = 0
       AND INSTR(NVL(a.condiname,' '),'중고품') = 0
       AND INSTR(NVL(a.condiname,' '),'리퍼') = 0
       AND INSTR(NVL(a.condiname,' '),'기본설치비 미포함') = 0
       AND INSTR(NVL(a.condiname,' '),'추가구매 필수') = 0
       AND INSTR(NVL(a.condiname,' '),'옵션필수') = 0
       AND INSTR(NVL(a.condiname,' '),'할부') = 0
       AND INSTR(NVL(a.condiname,' '),'인터넷가입조건') = 0
       AND INSTR(NVL(a.condiname,' '),'사업자전용') = 0
       AND INSTR(NVL(a.condiname,' '),'등외품') = 0
       AND INSTR(NVL(a.condiname,' '),'요금제') = 0
       AND INSTR(NVL(a.condiname,' '),'데이터') = 0
       AND INSTR(NVL(a.condiname,' '),'토너미포함') = 0
       AND INSTR(NVL(a.condiname,' '),'잉크미포함') = 0
       AND INSTR(NVL(a.condiname,' '),'미니어처') = 0 
       AND INSTR(NVL(a.condiname,' '),'일부지방') = 0 
       AND INSTR(NVL(a.condiname,' '),'샘플') = 0 
       AND INSTR(NVL(a.condiname,' '),'리필') = 0 
       AND ((   a.ca_code like '02%' 
             or a.ca_code like '03%'
             or a.ca_code like '04%'
             or a.ca_code like '05%'
             or a.ca_code like '06%'
             or a.ca_code like '07%'
             or a.ca_code like '22%'
             or a.ca_code like '24%')
            AND instr(nvl(a.condiname,' '),'해외쇼핑') = 0 )
       AND a.jobcode >'0';
     
     IF v_minprice = 0 THEN

        v_minprice := v_price;

     END IF;

    RETURN v_minprice;   
    
END;
