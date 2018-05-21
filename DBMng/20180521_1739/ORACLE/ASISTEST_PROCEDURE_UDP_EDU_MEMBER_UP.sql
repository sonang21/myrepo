/* *************************************************************************
 * NAME : ASISTEST.UDP_EDU_MEMBER_UP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:21
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_EDU_MEMBER_UP" (
   szNuriType  IN TBL_NSHOP_DETAIL.ns_type%TYPE,
   szShopVcode  IN tbl_shoplist.shop_code%TYPE,
   szCompType  TBL_NSHOP_DETAIL.NS_COMPANYTYPE%TYPE,
   szShopName  tbl_shoplist.shop_name%TYPE,
   szCompanyNo  TBL_NSHOP_DETAIL.NS_COMPANYNO%TYPE,
   szCondition  IN  TBL_NSHOP_DETAIL.NS_CONDITION%TYPE,
   szItem  IN  TBL_NSHOP_DETAIL.NS_ITEM%TYPE,
   szPresident   IN  tbl_shoplist.es_president%TYPE,
   szBankCode  IN  TBL_NSHOP_DETAIL.NS_BANKCODE%TYPE,
   szAccount  IN  TBL_NSHOP_DETAIL.NS_ACCOUNT%TYPE,
   szDepositor  IN  TBL_NSHOP_DETAIL.NS_DEPOSITOR%TYPE,
   szIntro  IN  TBL_NSHOP_DETAIL.NS_INTRO%TYPE,
   szLogo  IN  TBL_NSHOP_DETAIL.NS_LOGO%TYPE,
   szPhone1No1  IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO1%TYPE,
   szPhone1No2  IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO2%TYPE,
   szPhone1No3  IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO3%TYPE,
   szPhone2No1  IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO1%TYPE,
   szPhone2No2  IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO2%TYPE,
   szPhone2No3  IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO3%TYPE,
   szMobileNo1  IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO1%TYPE,
   szMobileNo2  IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO2%TYPE,
   szMobileNo3  IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO3%TYPE,
   szFaxNo1  IN  TBL_NSHOP_DETAIL.NS_FAX_NO1%TYPE,
   szFaxNo2  IN  TBL_NSHOP_DETAIL.NS_FAX_NO2%TYPE,
   szFaxNo3  IN  TBL_NSHOP_DETAIL.NS_FAX_NO3%TYPE,
   szZip1  IN  TBL_NSHOP_DETAIL.NS_ZIP1%TYPE,
   szZip2  IN  TBL_NSHOP_DETAIL.NS_ZIP2%TYPE,
   szAddr1   IN  TBL_NSHOP_DETAIL.NS_ADDR1%TYPE,
   szAddr2   IN  TBL_NSHOP_DETAIL.NS_ADDR2%TYPE,
   szCompZip1  IN  TBL_NSHOP_DETAIL.NS_COMPZIP1%TYPE,
   szCompZip2  IN  TBL_NSHOP_DETAIL.NS_COMPZIP2%TYPE,
   szCompAddr1  IN  TBL_NSHOP_DETAIL.NS_COMPADDR1%TYPE,
   szCompAddr2  IN  TBL_NSHOP_DETAIL.NS_COMPADDR2%TYPE,
   szEmail  IN  TBL_NSHOP_DETAIL.NS_EMAIL%TYPE,
   szEmail2  IN  TBL_NSHOP_DETAIL.NS_EMAIL2%TYPE,
   szEmailFlag  IN  tbl_shoplist.emailflag%TYPE,
   szDelInfo  IN  TBL_NSHOP_DETAIL.NS_DELINFO%TYPE,
   szRefundInfo  IN  TBL_NSHOP_DETAIL.NS_REFUNDINFO%TYPE,
   szMemo  IN  TBL_NSHOP_DETAIL.NS_MEMO%TYPE,
   szGanada  IN  TBL_SHOPLIST.ganada%TYPE,
   szDelFee  IN  TBL_SHOP_DELIVERY.SD_FEETYPE%TYPE,
   szDelArea  IN  TBL_SHOP_DELIVERY.SD_AREATYPE%TYPE,
   szCorpNo1  IN  TBL_NSHOP_DETAIL.NS_CORPNO%TYPE,
   szCorpNo2  IN  TBL_NSHOP_DETAIL.NS_CORPNO%TYPE,
   szPreRegNo1  IN  TBL_SHOPLIST.es_regno1%TYPE,
   szPreRegNo2  IN  TBL_SHOPLIST.es_regno2%TYPE,
   szIdDisplayFlag IN tbl_shoplist.auth%TYPE,  -- 아이디/상호명 출력여부 by hsw 2005.03.29  
   
   iRETURN IN OUT INTEGER)
IS
  SHOP_PHONE VARCHAR2(15) := '';

BEGIN
  --DBMS_OUTPUT.ENABLE;
 -- DBMS_OUTPUT.PUT_LINE('UDP_EDU_MEMBER_UP starting ......');

  iRETURN := 0;

   IF szPhone2No1 = '' THEN
    SHOP_PHONE := '';
   ELSE
    SHOP_PHONE := szPhone2No1 || '-' || szPhone2No2 || '-' || szPhone2No3;
   END IF;

   BEGIN
       --  SHOPLIST 에UPDATE
       UPDATE TBL_SHOPLIST SET shop_name=szShopName, email = szEmail, emailflag = szEmailFlag, tel = SHOP_PHONE,
                               ganada =  szGanada, es_president = szPresident,  es_regno1= szPreRegNo1, es_regno2 = szPreRegNo2
         WHERE shop_code = szShopVcode;

       --  TBL_NSHOP_DETAIL 에 UPDATE
       UPDATE TBL_NSHOP_DETAIL
              SET NS_TYPE = szNuriType, NS_COMPANYTYPE = szCompType, NS_SHOPNAME = szShopName, NS_COMPANYNO = szCompanyNo, NS_CORPNO = szCorpNo1 || szCorpNo2,
                  NS_CONDITION = szCondition , NS_ITEM = szItem, NS_PRESIDENT = szPresident, NS_PREREGNO = szPreRegNo1 || szPreRegNo2, NS_BANKCODE = szBankCode,
                  NS_ACCOUNT = szAccount, NS_DEPOSITOR = szDepositor,
                  NS_PHONE1_NO1 = szPhone1No1, NS_PHONE1_NO2 = szPhone1No2, NS_PHONE1_NO3 = szPhone1No3, NS_PHONE2_NO1 = szPhone2No1, NS_PHONE2_NO2= szPhone2No2,
                  NS_PHONE2_NO3 = szPhone2No3, NS_FAX_NO1 = szFaxNo1, NS_FAX_NO2 = szFaxNo2, NS_FAX_NO3 = szFaxNo3, NS_MOBILE_NO1 = szMobileNo1, NS_MOBILE_NO2 = szMobileNo2,
                  NS_MOBILE_NO3 = szMobileNo3, NS_ZIP1 = szZip1, NS_ZIP2 = szZip2 , NS_ADDR1 = szAddr1, NS_ADDR2 = szAddr2, NS_COMPZIP1 = szCompZip1, NS_COMPZIP2 = szCompZip2 ,
                  NS_COMPADDR1 = szCompAddr1, NS_COMPADDR2 = szCompAddr2, NS_EMAIL = szEmail, NS_EMAIL2 = szEmail2, NS_INTRO = szIntro, NS_LOGO = szLogo, NS_DELINFO = szDelInfo,
                  NS_REFUNDINFO = szRefundInfo, NS_MEMO = szMemo, NS_NAME_DISPLAY_FLAG = szIdDisplayFlag , NS_CHANGEDATE = SYSDATE, NS_FORMS ='0', NS_PAYRESERVE = '1',
                  NS_ADMIN_MEMO = NS_ADMIN_MEMO || chr(13) || chr(10) || '사업자전환 : (' ||  sysdate || ')'
         WHERE SHOP_CODE = szShopVcode;

       EXCEPTION WHEN OTHERS THEN
        iRETURN := 1;
        ROLLBACK;
   END;

  -- IF iRETURN = 0 THEN
  --   BEGIN
        --' 쇼핑몰 배송료 조건
  --      UPDATE TBL_SHOP_DELIVERY SET SD_FEETYPE = szDelFee WHERE SHOP_CODE = szShopVcode AND SD_CODE = '0' AND SD_TYPE = '0';

        --' 쇼핑몰 배송지역 조건
  --      UPDATE TBL_SHOP_DELIVERY SET SD_AREATYPE = szDelArea WHERE SHOP_CODE = szShopVcode AND SD_CODE = '0' AND SD_TYPE = '1';

  --       EXCEPTION WHEN OTHERS THEN
  --        iRETURN := 2;
  --        ROLLBACK;
  --     END;
  -- END IF;

   IF iRETURN = 0 THEN
     iRETURN := 0;
     COMMIT;
    END IF;

   EXCEPTION
       WHEN OTHERS THEN
        iRETURN := 2;
        ROLLBACK;

END UDP_EDU_MEMBER_UP;