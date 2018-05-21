/* *************************************************************************
 * NAME : ASISTEST.UDP_MAIN_HOTDEAL_ENURI_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:26
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_MAIN_HOTDEAL_ENURI_UP" AS 
BEGIN

  DELETE TBL_TODAY_HOTDEAL;
  INSERT INTO TBL_TODAY_HOTDEAL 
  SELECT HOTDEAL_IDX, GOODSCODE, SHOP_CODE, GOODSNM, ORG_PRICE, SALE_PRICE, SALE_RATE, DEAL_IMAGE, URL, VIEW_YN, REG_DATE FROM TBL_TODAY_HOTDEAL_MAN;
  commit;

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_MAIN_HOTDEAL_ENURI_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;