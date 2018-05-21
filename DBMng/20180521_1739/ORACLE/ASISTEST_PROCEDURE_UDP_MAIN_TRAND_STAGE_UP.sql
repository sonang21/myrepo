/* *************************************************************************
 * NAME : ASISTEST.UDP_MAIN_TRAND_STAGE_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:27
 *        Modify: 2018-05-04 18:53:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_MAIN_TRAND_STAGE_UP" AS 
BEGIN

  DELETE TBL_TRAND_SUBJECT@ORADB_253;
  INSERT INTO TBL_TRAND_SUBJECT@ORADB_253 
  SELECT SUBJECT_IDX, CA_CODE, SUBJECT, VIEW_YN, MAIN_VIEW_YN, SUBJECT_ORDER, REG_DATE, URL, REC_YN, KEYWORD , MOBILE_SUBJECT, MOBILE_VIEW_YN, MOBILE_SUBJECT_SUB,E_CA_CODE1,E_CA_CODE2 FROM TBL_TRAND_SUBJECT_MAN;
  commit;
  
  DELETE TBL_TRAND_REF_GOODS@ORADB_253;
  INSERT INTO TBL_TRAND_REF_GOODS@ORADB_253 
  SELECT REF_GOODS_IDX, SUBJECT_IDX, REF_MODEL_NO, REF_MODELNM, REF_MODEL_IMG, REG_DATE , GOODS_ORDER, REF_MODEL_IMG_MOBILE, PC_URL, MOBILE_URL FROM TBL_TRAND_REF_GOODS_MAN;
  commit;
  
  DELETE TBL_TRAND_KEYWORD@ORADB_253;
  INSERT INTO TBL_TRAND_KEYWORD@ORADB_253 
  SELECT KEYWORD_IDX, SUBJECT_IDX, KEYWORD, URL , KEYWORD_ORDER FROM TBL_TRAND_KEYWORD_MAN;
  commit;
  
  DELETE TBL_TRAND_TIP@ORADB_253;
  INSERT INTO TBL_TRAND_TIP@ORADB_253 
  SELECT TIP_IDX, SUBJECT_IDX, TIP_TYPE, TITLE, URL, CONTENTS FROM TBL_TRAND_TIP_MAN;
  commit; 

  DELETE TBL_TRAND_BANNER@ORADB_253;
  INSERT INTO TBL_TRAND_BANNER@ORADB_253 
  SELECT BANNER_IDX, SUBJECT_IDX, IMG_NM, BG_COLOR, LINK, START_DT, END_DT, MOBILE_YN, REG_DT, UPD_DT FROM TBL_TRAND_BANNER_MAN;
  commit; 
  
 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_MAIN_TRAND_STAGE_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;