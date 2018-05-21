/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPT_BEST_100_ENURI_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPT_BEST_100_ENURI_UP" AS 
BEGIN
  DELETE TBL_DEPT_BEST100;

  INSERT INTO TBL_DEPT_BEST100  
  (SELECT SHOP_CODE, GOODSCODE, DEPT_CODE, REG_DATE, GOODS_ORDER FROM TBL_DEPT_BEST100_MAN  WHERE DEL_YN='N');
  commit;

 EXCEPTION
     WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('UDP_DEPT_BEST_100_ENURI_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
        
END UDP_DEPT_BEST_100_ENURI_UP;