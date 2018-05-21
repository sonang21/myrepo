/* *************************************************************************
 * NAME : DBENURI.DEAL_GOODS_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."DEAL_GOODS_COUNT" AS 
BEGIN
  update TBL_DEAL_GOODS_COUNT set deal_goods_count = (SELECT COUNT(*) AS CNT FROM DEAL_GOODS WHERE END_AT > SYSDATE AND DIVISION IS NOT NULL);
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('DEAL_GOODS_COUNT error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END DEAL_GOODS_COUNT;