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
     AND INSTR(NVL(condiname,' '),'��Ż') = 0 
     AND INSTR(NVL(condiname,' '),'�߰�') = 0
     AND INSTR(NVL(condiname,' '),'�߰�ǰ') = 0
     AND INSTR(NVL(condiname,' '),'����') = 0
     AND INSTR(NVL(condiname,' '),'�⺻��ġ�� ������') = 0
     AND INSTR(NVL(condiname,' '),'�߰����� �ʼ�') = 0
     AND INSTR(NVL(condiname,' '),'�ɼ��ʼ�') = 0
     AND INSTR(NVL(condiname,' '),'�Һ�') = 0
     AND INSTR(NVL(condiname,' '),'���ͳݰ�������') = 0
     AND INSTR(NVL(condiname,' '),'���������') = 0
     AND INSTR(NVL(condiname,' '),'���ǰ') = 0
     AND INSTR(NVL(condiname,' '),'�����') = 0
     AND INSTR(NVL(condiname,' '),'������') = 0
     AND INSTR(NVL(condiname,' '),'��ʹ�����') = 0
     AND INSTR(NVL(condiname,' '),'��ũ������') = 0
     AND INSTR(NVL(condiname,' '),'�̴Ͼ�ó') = 0 
     AND INSTR(NVL(condiname,' '),'�Ϻ�����') = 0 
     AND INSTR(NVL(condiname,' '),'����') = 0 
     AND INSTR(NVL(condiname,' '),'����') = 0 
     AND (CA_LCODE IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND INSTR(NVL(condiname,' '),'�ؿܼ���') = 0 )
     AND jobcode >'0';
     
     IF v_minprice = 0 THEN

        v_minprice := v_price;

     END IF;

    RETURN v_minprice;   
    
END;