/* *************************************************************************
 * NAME : DBENURI.UDP_MAIN_PLANS_STAGE_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MAIN_PLANS_STAGE_UP" AS 
BEGIN

  DELETE TBL_MAIN_PLANS@ORADB_253;
  INSERT INTO TBL_MAIN_PLANS@ORADB_253 
  SELECT GOODS_IDX, SUBJECT_IDX, GOODS_TYPE, SHOP_NAME, GOODS_TITLE, GOODS_URL, USE_YN, START_DATE, END_DATE, REG_DATE, PLANS_IMAGE FROM TBL_MAIN_PLANS_MAN;
  commit;
  
  DELETE TBL_MAIN_PLAN_SUBJECT@ORADB_253;
  INSERT INTO TBL_MAIN_PLAN_SUBJECT@ORADB_253 
  SELECT SUBJECT_IDX, TITLE, SUBJECT_ORDER, USE_YN FROM TBL_MAIN_PLAN_SUBJECT_MAN;
  commit;

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_MAIN_PLANS_STAGE_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;