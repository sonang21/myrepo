/* *************************************************************************
 * NAME : DBENURI.UDP_MAIN_TOUR_ENURI_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MAIN_TOUR_ENURI_UP" 
IS

BEGIN

  DELETE TBL_MAIN_TOUR_GOODS;

  INSERT INTO TBL_MAIN_TOUR_GOODS 
  SELECT GOODS_IDX,MODEL_SUBNO,SHOP_CODE,GOODS_TITLE,SUM_PRICE,START_DATE,END_DATE,IMG_URL,URL,VIEW_YN,REG_DATE,SPECIAL_PRICE_YN
  FROM TBL_MAIN_TOUR_GOODS_MAN
  commit;

 EXCEPTION
     WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('UDP_MAIN_TOUR_ENURI_UP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;