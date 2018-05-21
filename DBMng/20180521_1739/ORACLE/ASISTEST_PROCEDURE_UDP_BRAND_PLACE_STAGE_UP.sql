/* *************************************************************************
 * NAME : ASISTEST.UDP_BRAND_PLACE_STAGE_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:16
 *        Modify: 2018-05-04 18:53:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_BRAND_PLACE_STAGE_UP" AS
BEGIN
  DELETE TBL_BRAND_REPLACEMENT_BOARD@ORADB_253;
  INSERT INTO TBL_BRAND_REPLACEMENT_BOARD@ORADB_253   
  SELECT BOARDNO, BOARDSORT, TITLE, CONTENTS, WRITERID, WRITERIMG, DELWRITERIMGID, ADMINIMG, DELADMINIMGID, ANSWERYN, HITS, REGDT, UPDDT, ADMINID FROM TBL_BRAND_REPLACEMENT_BOARD;
  
 -- DELETE TBL_BRAND_REPLACEMENT_USER@ORADB_253;
 -- INSERT INTO TBL_BRAND_REPLACEMENT_USER@ORADB_253   
 -- SELECT BRANDNO, USERID, PASSWD, COMPANYNM, COMPANYNO, MANAGERNM, MANAGERTEL, MANAGEREMAIL, USEYN, AUTHYN, REGDT, UPDDT FROM TBL_BRAND_REPLACEMENT_USER;
  
  commit;
  
EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UUDP_BRAND_PLACE_STAGE_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;