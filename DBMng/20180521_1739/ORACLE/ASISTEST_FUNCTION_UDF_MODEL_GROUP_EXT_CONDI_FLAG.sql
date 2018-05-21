/* *************************************************************************
 * NAME : ASISTEST.UDF_MODEL_GROUP_EXT_CONDI_FLAG
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:35
 *        Modify: 2018-05-04 18:33:35
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_MODEL_GROUP_EXT_CONDI_FLAG" (v_modelno NUMBER)
RETURN CHAR AS

    v_ext_condi_flag     CHAR(1):='';
    
BEGIN
    SELECT NVL(ext_condi_flag,'') ext_condi_flag INTO v_ext_condi_flag
     FROM tbl_goods
     WHERE modelno = v_modelno
     AND cateflag='0'
     AND constrain in ('1' , '5')
     AND mallcnt>0
     AND jobcode >'0';

    RETURN v_ext_condi_flag;   
    
END;