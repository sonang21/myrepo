/* *************************************************************************
 * NAME : ASISTEST.DEAL_GOODS_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:14
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."DEAL_GOODS_COUNT" AS 
BEGIN
  update TBL_DEAL_GOODS_COUNT set deal_goods_count = (SELECT COUNT(*) AS CNT FROM DEAL_GOODS WHERE END_AT > SYSDATE AND DIVISION IS NOT NULL);
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('DEAL_GOODS_COUNT error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END DEAL_GOODS_COUNT;
