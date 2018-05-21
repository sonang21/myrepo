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
 NGIT 수정 반영 - 김영원 20180417
*/
    v_minprice number(12) :=0;

BEGIN

    select nvl(min(b.minprice),0) minprice into v_minprice
      from tbl_goods a, tbl_goods_sum b
     where a.modelno = b.modelno 
       and (a.modelno_group = v_modelno_group or a.modelno = v_modelno_group)
       and a.constrain='1'
       and b.mallcnt>0
       and nvl(a.condiname,' ') not like '%렌탈%'
       and nvl(a.condiname,' ') not like '%중고%'
       and nvl(a.condiname,' ') not like '%중고품%'
       and nvl(a.condiname,' ') not like '%리퍼%'
       and nvl(a.condiname,' ') not like '%기본설치비 미포함%'
       and nvl(a.condiname,' ') not like '%추가구매 필수%'
       and nvl(a.condiname,' ') not like '%옵션필수%'
       and nvl(a.condiname,' ') not like '%할부%'
       and nvl(a.condiname,' ') not like '%인터넷가입조건%'
       and nvl(a.condiname,' ') not like '%사업자전용%'
       and nvl(a.condiname,' ') not like '%등외품%'
       and nvl(a.condiname,' ') not like '%요금제%'
       and nvl(a.condiname,' ') not like '%데이터%'
       and nvl(a.condiname,' ') not like '%토너미포함%'
       and nvl(a.condiname,' ') not like '%잉크미포함%'
       and nvl(a.condiname,' ') not like '%미니어처%'
       and nvl(a.condiname,' ') not like '%일부지방%'
       and nvl(a.condiname,' ') not like '%샘플%'
       and nvl(a.condiname,' ') not like '%리필%'
       and ((  a.ca_code like  '02%'
             or a.ca_code like  '03%' 
             or a.ca_code like  '04%' 
             or a.ca_code like  '05%' 
             or a.ca_code like  '06%' 
             or a.ca_code like  '07%' 
             or a.ca_code like  '22%' 
             or a.ca_code like  '24%')
            and nvl(a.condiname,' ') not like '%해외쇼핑%')
       and a.jobcode >'0';
     
     if v_minprice = 0 then
        v_minprice := v_price;
     end if;

    RETURN v_minprice;   
    
END;
