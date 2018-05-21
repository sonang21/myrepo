/* *************************************************************************
 * NAME : DBENURI.UDF_BBS_NUM_SUM
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_BBS_NUM_SUM" (v_modelno_group NUMBER)
RETURN NUMBER AS

    v_bbs_num_sum     NUMBER := 0;
    
BEGIN
    
     SELECT NVL(COUNT(*),0) INTO v_bbs_num_sum
       FROM tbl_goods_bbs
      WHERE (modelno_group = v_modelno_group OR modelno = v_modelno_group) 
      AND delflag='N';
    
    RETURN v_bbs_num_sum;
    
END;