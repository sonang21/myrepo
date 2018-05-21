/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_REMOVE_C_MINPRICE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:11:00
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_REMOVE_C_MINPRICE" (v_modelno_group NUMBER,v_price NUMBER)
RETURN NUMBER AS
/*
 NGIT ���� �ݿ� - �迵�� 20180417
*/
    v_minprice number(12) :=0;

BEGIN

    select nvl(min(b.minprice),0) minprice into v_minprice
      from tbl_goods a, tbl_goods_sum b
     where a.modelno = b.modelno 
       and (a.modelno_group = v_modelno_group or a.modelno = v_modelno_group)
       and a.constrain='1'
       and b.mallcnt>0
       and nvl(a.condiname,' ') not like '%��Ż%'
       and nvl(a.condiname,' ') not like '%�߰�%'
       and nvl(a.condiname,' ') not like '%�߰�ǰ%'
       and nvl(a.condiname,' ') not like '%����%'
       and nvl(a.condiname,' ') not like '%�⺻��ġ�� ������%'
       and nvl(a.condiname,' ') not like '%�߰����� �ʼ�%'
       and nvl(a.condiname,' ') not like '%�ɼ��ʼ�%'
       and nvl(a.condiname,' ') not like '%�Һ�%'
       and nvl(a.condiname,' ') not like '%���ͳݰ�������%'
       and nvl(a.condiname,' ') not like '%���������%'
       and nvl(a.condiname,' ') not like '%���ǰ%'
       and nvl(a.condiname,' ') not like '%�����%'
       and nvl(a.condiname,' ') not like '%������%'
       and nvl(a.condiname,' ') not like '%��ʹ�����%'
       and nvl(a.condiname,' ') not like '%��ũ������%'
       and nvl(a.condiname,' ') not like '%�̴Ͼ�ó%'
       and nvl(a.condiname,' ') not like '%�Ϻ�����%'
       and nvl(a.condiname,' ') not like '%����%'
       and nvl(a.condiname,' ') not like '%����%'
       and ((  a.ca_code like  '02%'
             or a.ca_code like  '03%' 
             or a.ca_code like  '04%' 
             or a.ca_code like  '05%' 
             or a.ca_code like  '06%' 
             or a.ca_code like  '07%' 
             or a.ca_code like  '22%' 
             or a.ca_code like  '24%')
            and nvl(a.condiname,' ') not like '%�ؿܼ���%')
       and a.jobcode >'0';
     
     if v_minprice = 0 then
        v_minprice := v_price;
     end if;

    RETURN v_minprice;   
    
END;
