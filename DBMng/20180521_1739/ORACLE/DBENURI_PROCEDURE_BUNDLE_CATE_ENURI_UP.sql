/* *************************************************************************
 * NAME : DBENURI.BUNDLE_CATE_ENURI_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."BUNDLE_CATE_ENURI_UP" AS 
BEGIN
  
  DELETE FROM TBL_BUNDLE_CATE;
  
  INSERT INTO TBL_BUNDLE_CATE
  SELECT BUNDLE_CATE_NO, CA_CODE, PARENT_NO, ORDER_CATE, BUNDLE_NAME, UDP_DATE, UDP_USER, REG_DATE FROM TBL_BUNDLE_CATE_MAN;
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('BUNDLE_CATE_ENURI_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END BUNDLE_CATE_ENURI_UP;