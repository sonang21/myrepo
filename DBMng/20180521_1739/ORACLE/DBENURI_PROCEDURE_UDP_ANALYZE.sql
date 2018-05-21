/* *************************************************************************
 * NAME : DBENURI.UDP_ANALYZE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ANALYZE" 
IS
  v_str     VARCHAR2(4000) := '';
BEGIN

  DBMS_OUTPUT.ENABLE;
  DBMS_OUTPUT.PUT_LINE('UDP_ANALYZE start ......');

  v_str := '';
  v_str := 'analyze table TBL_CATEGORY compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IDX_CATEGORY_CA_CODE_LEVEL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_COPYCATE compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_GOODS_COPYCATE compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_GOODS_COPYCATE compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_SUPPLY compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_GOODS_PRTSUPPLY compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SHOPLIST compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_SHOPLIST compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_SHOPLIST compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_SHOPLIST compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_SHOPLIST_1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ENURI_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_CA_CODE compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_ENURI_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_2 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_3 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_4 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_5 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ENURI_BOARD_6 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SHOP_DELIVERY compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_SHOP_DELIVERY compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_GOODS_BRAND1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_GOODS_BRAND1_1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND2 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_GOODS_BRAND2 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_GOODS_BRAND2 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND_DETAIL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_GOODS_BRAND_DETAIL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_GOODS_BRAND_DETAIL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ERROR_PROPOSAL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_ERROR_PROPOSAL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_ERROR_PROPOSAL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ERROR_PROPOSAL_2 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ERROR_PROPOSAL compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ERROR_PROPOSAL_1 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ERROR_PROPOSAL_3 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_ERROR_PROPOSAL_4 compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ENURI_INTERGRATION_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_ENURI_INTERGRATION_BOA compute statistics ';
  EXECUTE IMMEDIATE v_str;
  
  v_str := '';
  v_str := 'analyze index IDX_INTERGRATION_BOARD_COUNT compute statistics ';
  EXECUTE IMMEDIATE v_str;
  
  v_str := '';
  v_str := 'analyze index IDX_INT_BOARD_SHOP_CODE compute statistics ';
  EXECUTE IMMEDIATE v_str;
  
  v_str := '';
  v_str := 'analyze index IDX_INT_WRITER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SDU_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_SDU_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IX_SDU_BOARD compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_PRICELIST_STATIC compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XPKTBL_PRICELIST_STATIC compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_MYEVER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index PK_TBL_MYEVER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF1TBL_MYEVER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF2TBL_MYEVER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF3TBL_MYEVER compute statistics ';
  EXECUTE IMMEDIATE v_str;

  DBMS_OUTPUT.PUT_LINE('UDP_ANALYZE end ......');

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_ANALYZE error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);

END;
 