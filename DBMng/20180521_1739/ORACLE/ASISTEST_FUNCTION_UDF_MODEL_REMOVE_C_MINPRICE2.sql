/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_REMOVE_C_MINPRICE2
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:36
 *        Modify: 2018-05-04 18:33:36
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_REMOVE_C_MINPRICE2" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS

    v_minprice NUMBER(12) :=0;

BEGIN

    SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
     FROM tbl_goods 
     WHERE modelno = v_modelno_group
     AND cateflag='0'
     AND constrain='1'
     AND mallcnt>0
     /*
     AND NVL(condiname,' ') NOT LIKE '%��Ż%'
     AND NVL(condiname,' ') NOT LIKE '%�߰�%'
     AND NVL(condiname,' ') NOT LIKE '%�߰�ǰ%'
     AND NVL(condiname,' ') NOT LIKE '%����%'
     AND NVL(condiname,' ') NOT LIKE '%�⺻��ġ�� ������%'
     AND NVL(condiname,' ') NOT LIKE '%�߰����� �ʼ�%'
     AND NVL(condiname,' ') NOT LIKE '%�ɼ��ʼ�%'
     AND NVL(condiname,' ') NOT LIKE '%�Һ�%'
     AND NVL(condiname,' ') NOT LIKE '%���ͳݰ�������%'
     AND NVL(condiname,' ') NOT LIKE '%���������%'
     AND NVL(condiname,' ') NOT LIKE '%���ǰ%'
     AND NVL(condiname,' ') NOT LIKE '%�����%'
     AND NVL(condiname,' ') NOT LIKE '%������%'
     AND NVL(condiname,' ') NOT LIKE '%��ʹ�����%'
     AND NVL(condiname,' ') NOT LIKE '%��ũ������%'
     AND NVL(condiname,' ') NOT LIKE '%�̴Ͼ�ó%'
     AND NVL(condiname,' ') NOT LIKE '%�Ϻ�����%'
     AND NVL(condiname,' ') NOT LIKE '%����%'
     AND NVL(condiname,' ') NOT LIKE '%����%'
     AND (CA_LCODE IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND NVL(condiname,' ') NOT LIKE '%�ؿܼ���%') 
     */
     AND CA_LCODE = '04' AND CA_CODE LIKE '0401%'
     AND jobcode >'0';
     
     IF v_minprice = 0 THEN
        v_minprice := v_price;
     END IF;

    RETURN v_minprice;   
    
    
END;