/* *************************************************************************
 * NAME : DBENURI.UDF_MODELGROUP_EXTCONDIFLAG_DQ
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:23:00
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODELGROUP_EXTCONDIFLAG_DQ" (v_modelno NUMBER)
RETURN CHAR AS
/*
 NGIT 수정 반영 - 김영원 20180417
*/
    v_ext_condi_flag     CHAR(1):='';
    
BEGIN
    SELECT NVL(MIN(a.ext_condi_flag),'0') as ext_condi_flag  
      INTO v_ext_condi_flag
      FROM tbl_goods a, tbl_goods_sum b
     WHERE a.modelno = b.modelno
       AND (a.modelno = v_modelno or a.modelno_group = v_modelno)
       AND a.constrain in ('1' , '5')
       AND b.mallcnt>0
       AND a.jobcode >'0';

    RETURN v_ext_condi_flag;   
    
END;
