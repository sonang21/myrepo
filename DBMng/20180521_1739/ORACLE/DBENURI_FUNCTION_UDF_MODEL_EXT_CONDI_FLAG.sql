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
-- 파라미터에 따른 기준(추후반영_20161209)
    v_ca_code, v_condiname, v_modelno
        o          o          ?      - 파라미터의 condiname 을 기준(구현)
        o          x          o      - TBL_GOODS의 condiname 을 기준(미구현)
        o          x          x      - 오류(미구현)
        x          ?          ?      - 오류(미구현)
*/

select 
    case when  INSTR(v_condiname,'중고') >0 then '1'
        when INSTR(v_condiname,'중고품') >0 then '1'
        when INSTR(v_condiname,'리퍼') >0 then '1'
        when INSTR(v_condiname,'기본설치비 미포함') >0 then '1'
        when INSTR(v_condiname,'추가구매 필수') >0 then '1'
        when INSTR(v_condiname,'옵션필수') >0 then '1'
        when INSTR(v_condiname,'렌탈') >0 then '1'
        when INSTR(v_condiname,'할부') >0 then '1'
        when INSTR(v_condiname,'인터넷가입조건') >0 then '1'
        when INSTR(v_condiname,'사업자전용') >0 then '1'
        when INSTR(v_condiname,'등외품') >0 then '1'
        when INSTR(v_condiname,'요금제') >0 then '1'
        when INSTR(v_condiname,'데이터') >0 then '1'
        when INSTR(v_condiname,'토너미포함') >0 then '1'
        when INSTR(v_condiname,'잉크미포함') >0 then '1'
        when INSTR(v_condiname,'미니어처') >0 then '1'
        when INSTR(v_condiname,'일부지방') >0 then '1'
        when INSTR(v_condiname,'샘플') >0 then '1'
        when INSTR(v_condiname,'리필') >0 and INSTR(v_condiname,'리필모') = 0 and INSTR(v_condiname,'+리필') = 0 then '1'
        --when substr(v_ca_code,1,2) IN ( '02' , '03' , '04' , '05' , '06' , '07' , '22' , '24') AND INSTR(v_condiname,'해외쇼핑') > 0 then '1' 
        -- 17/12/12 SR 26089 처리
        else '0' end as flag 
         into v_EXT_CONDI_FLAG
from dual;

    RETURN v_EXT_CONDI_FLAG;   
    
END;