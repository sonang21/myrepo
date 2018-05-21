/* *************************************************************************
 * NAME : ASISTEST.BUNDLE_CATE_STAGE_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:13
 *        Modify: 2018-05-04 18:53:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."BUNDLE_CATE_STAGE_UP" AS 
BEGIN
  
  DELETE FROM TBL_BUNDLE_CATE@ORADB_253;
  
  INSERT INTO TBL_BUNDLE_CATE@ORADB_253
  SELECT BUNDLE_CATE_NO, CA_CODE, PARENT_NO, ORDER_CATE, BUNDLE_NAME, UDP_DATE, UDP_USER, REG_DATE FROM TBL_BUNDLE_CATE_MAN;
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('BUNDLE_CATE_STAGE_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END BUNDLE_CATE_STAGE_UP;