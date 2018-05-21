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
 NGIT ���� �ݿ� - �迵�� 20180417
*/
    v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(b.minprice),0) minprice INTO v_minprice
      FROM tbl_goods a, tbl_goods_sum b
     WHERE (a.modelno_group = v_modelno_group OR a.modelno = v_modelno_group)
       AND a.modelno = b.modelno 
       AND a.constrain='1'
       AND b.mallcnt>0
       AND INSTR(NVL(a.condiname,' '),'��Ż') = 0 
       AND INSTR(NVL(a.condiname,' '),'�߰�') = 0
       AND INSTR(NVL(a.condiname,' '),'�߰�ǰ') = 0
       AND INSTR(NVL(a.condiname,' '),'����') = 0
       AND INSTR(NVL(a.condiname,' '),'�⺻��ġ�� ������') = 0
       AND INSTR(NVL(a.condiname,' '),'�߰����� �ʼ�') = 0
       AND INSTR(NVL(a.condiname,' '),'�ɼ��ʼ�') = 0
       AND INSTR(NVL(a.condiname,' '),'�Һ�') = 0
       AND INSTR(NVL(a.condiname,' '),'���ͳݰ�������') = 0
       AND INSTR(NVL(a.condiname,' '),'���������') = 0
       AND INSTR(NVL(a.condiname,' '),'���ǰ') = 0
       AND INSTR(NVL(a.condiname,' '),'�����') = 0
       AND INSTR(NVL(a.condiname,' '),'������') = 0
       AND INSTR(NVL(a.condiname,' '),'��ʹ�����') = 0
       AND INSTR(NVL(a.condiname,' '),'��ũ������') = 0
       AND INSTR(NVL(a.condiname,' '),'�̴Ͼ�ó') = 0 
       AND INSTR(NVL(a.condiname,' '),'�Ϻ�����') = 0 
       AND INSTR(NVL(a.condiname,' '),'����') = 0 
       AND INSTR(NVL(a.condiname,' '),'����') = 0 
       AND ((   a.ca_code like '02%' 
             or a.ca_code like '03%'
             or a.ca_code like '04%'
             or a.ca_code like '05%'
             or a.ca_code like '06%'
             or a.ca_code like '07%'
             or a.ca_code like '22%'
             or a.ca_code like '24%')
            AND instr(nvl(a.condiname,' '),'�ؿܼ���') = 0 )
       AND a.jobcode >'0';
     
     IF v_minprice = 0 THEN

        v_minprice := v_price;

     END IF;

    RETURN v_minprice;   
    
END;
