/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_EXT_CONDI_FLAG
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-19 18:32:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_EXT_CONDI_FLAG" (v_ca_code varchar2, v_condiname varchar2, v_modelno NUMBER)
RETURN NUMBER AS

    v_EXT_CONDI_FLAG CHAR(1) := '0';

BEGIN

/* 
-- �Ķ���Ϳ� ���� ����(���Ĺݿ�_20161209)
    v_ca_code, v_condiname, v_modelno
        o          o          ?      - �Ķ������ condiname �� ����(����)
        o          x          o      - TBL_GOODS�� condiname �� ����(�̱���)
        o          x          x      - ����(�̱���)
        x          ?          ?      - ����(�̱���)
*/

select 
    case when  INSTR(v_condiname,'�߰�') >0 then '1'
        when INSTR(v_condiname,'�߰�ǰ') >0 then '1'
        when INSTR(v_condiname,'����') >0 then '1'
        when INSTR(v_condiname,'�⺻��ġ�� ������') >0 then '1'
        when INSTR(v_condiname,'�߰����� �ʼ�') >0 then '1'
        when INSTR(v_condiname,'�ɼ��ʼ�') >0 then '1'
        when INSTR(v_condiname,'��Ż') >0 then '1'
        when INSTR(v_condiname,'�Һ�') >0 then '1'
        when INSTR(v_condiname,'���ͳݰ�������') >0 then '1'
        when INSTR(v_condiname,'���������') >0 then '1'
        when INSTR(v_condiname,'���ǰ') >0 then '1'
        when INSTR(v_condiname,'�����') >0 then '1'
        when INSTR(v_condiname,'������') >0 then '1'
        when INSTR(v_condiname,'��ʹ�����') >0 then '1'
        when INSTR(v_condiname,'��ũ������') >0 then '1'
        when INSTR(v_condiname,'�̴Ͼ�ó') >0 then '1'
        when INSTR(v_condiname,'�Ϻ�����') >0 then '1'
        when INSTR(v_condiname,'����') >0 then '1'
        when INSTR(v_condiname,'����') >0 and INSTR(v_condiname,'���ʸ�') = 0 and INSTR(v_condiname,'+����') = 0 then '1'
        --when substr(v_ca_code,1,2) IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND INSTR(v_condiname,'�ؿܼ���') > 0 then '1' 
        -- 17/12/12 SR 26089 ó��
        else '0' end as flag 
         into v_EXT_CONDI_FLAG
from dual;

    RETURN v_EXT_CONDI_FLAG;   
    
END;