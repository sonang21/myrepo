/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_GROUP_EXT_CONDI_FLAG
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:01:01
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_GROUP_EXT_CONDI_FLAG" (v_modelno NUMBER)
RETURN CHAR AS
/*
 NGIT 수정 반영 - 김영원 20180416
*/

    v_ext_condi_flag     char(1):='';
    
BEGIN
    select nvl(a.ext_condi_flag,'') ext_condi_flag
      into v_ext_condi_flag
      from tbl_goods a, tbl_goods_sum b
     where a.modelno = v_modelno
       and a.modelno = b.modelno
       and a.constrain in ('1' , '5')
       and b.mallcnt>0
       and a.jobcode >'0';

    RETURN v_ext_condi_flag;   
    
END;
