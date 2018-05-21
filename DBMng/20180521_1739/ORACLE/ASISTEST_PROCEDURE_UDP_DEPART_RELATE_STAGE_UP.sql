/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPART_RELATE_STAGE_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPART_RELATE_STAGE_UP" AS 
BEGIN
  DELETE TBL_DEPT_RELATE_CATE@ORADB_253;

  INSERT INTO TBL_DEPT_RELATE_CATE@ORADB_253   
  (SELECT CA_CODE, REL_CATE, DISPLAY_ORD, INS_DATE FROM TBL_DEPT_RELATE_CATE);
  commit;

 EXCEPTION
     WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('UDP_DEPART_RELATE_STAGE_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
        
END UDP_DEPART_RELATE_STAGE_UP;