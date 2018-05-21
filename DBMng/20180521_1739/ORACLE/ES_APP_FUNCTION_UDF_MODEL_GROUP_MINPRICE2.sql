/* *************************************************************************
 * NAME : ES_APP.UDF_MODEL_GROUP_MINPRICE2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:45:27
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODEL_GROUP_MINPRICE2" (v_modelno_group NUMBER)
RETURN NUMBER AS

     v_minprice NUMBER(12) :=0;

BEGIN
    SELECT NVL(MIN(minprice),0) minprice INTO v_minprice
     FROM tbl_goods
     WHERE modelno_group = v_modelno_group
     AND cateflag='0'
     AND constrain='1'
     AND mallcnt>0
     AND jobcode >'0';

    RETURN v_minprice;   
    
END;