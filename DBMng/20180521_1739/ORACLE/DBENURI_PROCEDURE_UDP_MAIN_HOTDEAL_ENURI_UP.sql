/* *************************************************************************
 * NAME : DBENURI.UDP_MAIN_HOTDEAL_ENURI_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MAIN_HOTDEAL_ENURI_UP" AS 
BEGIN

  DELETE TBL_TODAY_HOTDEAL;
  INSERT INTO TBL_TODAY_HOTDEAL 
  SELECT HOTDEAL_IDX, GOODSCODE, SHOP_CODE, GOODSNM, ORG_PRICE, SALE_PRICE, SALE_RATE, DEAL_IMAGE, URL, VIEW_YN, REG_DATE FROM TBL_TODAY_HOTDEAL_MAN;
  commit;

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_MAIN_HOTDEAL_ENURI_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;