/* *************************************************************************
 * NAME : ES_APP.UDF_MODELGROUP_EXTCONDIFLAG_DQ
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:45:27
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODELGROUP_EXTCONDIFLAG_DQ" (v_modelno NUMBER)
RETURN CHAR AS

    v_ext_condi_flag     CHAR(1):='';
    
BEGIN
    SELECT NVL(MIN(EXT_CONDI_FLAG),'0') as ext_condi_flag  INTO v_ext_condi_flag
     FROM tbl_goods
     WHERE (modelno = v_modelno or modelno_group = v_modelno)
     AND cateflag='0'
     AND constrain in ('1' , '5')
     AND mallcnt>0
     AND jobcode >'0';

    RETURN v_ext_condi_flag;   
    
END;