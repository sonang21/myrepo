/* *************************************************************************
 * NAME : DBENURI.PROCEDURE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-20 13:55:05
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."PROCEDURE" UDP_EDU_MEMBER_REUP(
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
   iSelectNo IN  TBL_NSHOP_DETAIL.NS_NO%TYPE, 
   szOrderId IN  TBL_NSHOP_TICKET.PAY_OID%TYPE, 
   szIdDisplayFlag IN tbl_shoplist.auth%TYPE,  -- 아이디/상호명 출력여부 by hsw 2005.03.29 

   iRETURN IN OUT INTEGER)
IS
  SHOP_PHONE VARCHAR2(15) := '';
  maxid TBL_SHOP_DELIVERY.id%TYPE;

BEGIN
   --DBMS_OUTPUT.ENABLE;
   DBMS_OUTPUT.PUT_LINE('UDP_EDU_MEMBER_REUP starting ......');

   iRETURN := 0;

   IF szPhone2No1 = '' THEN
    SHOP_PHONE := '';
   ELSE
    SHOP_PHONE := szPhone2No1 || '-' || szPhone2No2 || '-' || szPhone2No3;
   END IF;

   BEGIN
       --  SHOPLIST 에UPDATE
       UPDATE TBL_SHOPLIST SET shop_name=szShopName, email = szEmail, emailflag = szEmailFlag, tel = SHOP_PHONE,
                        ganada =  szGanada, es_president = szPresident,  es_regno1= szPreRegNo1, es_regno2 = szPreRegNo2,
                               opt = '1', service = '0', es_use = '9'
        WHERE shop_code = szShopVcode;

       --  TBL_NSHOP_DETAIL 에 UPDATE
       UPDATE TBL_NSHOP_DETAIL
              SET NS_TYPE = szNuriType, NS_COMPANYTYPE = szCompType, NS_NO = iSelectNo, NS_SHOPNAME = szShopName, NS_COMPANYNO = szCompanyNo, NS_CORPNO = szCorpNo1 || szCorpNo2,
                  NS_CONDITION = szCondition , NS_ITEM = szItem, NS_PRESIDENT = szPresident, NS_PREREGNO = szPreRegNo1 || szPreRegNo2, NS_BANKCODE = szBankCode,
                  NS_ACCOUNT = szAccount, NS_DEPOSITOR = szDepositor, NS_PHONE1_NO1 = szPhone1No1, NS_PHONE1_NO2 = szPhone1No2, NS_PHONE1_NO3 = szPhone1No3,
                  NS_PHONE2_NO1 = szPhone2No1, NS_PHONE2_NO2= szPhone2No2, NS_PHONE2_NO3 = szPhone2No3,
                  NS_FAX_NO1 = szFaxNo1, NS_FAX_NO2 = szFaxNo2, NS_FAX_NO3 = szFaxNo3, NS_MOBILE_NO1 = szMobileNo1, NS_MOBILE_NO2 = szMobileNo2, NS_MOBILE_NO3 = szMobileNo3 ,
                  NS_ZIP1 = szZip1, NS_ZIP2 = szZip2 , NS_ADDR1 = szAddr1, NS_ADDR2 = szAddr2, NS_COMPZIP1 = szCompZip1, NS_COMPZIP2 = szCompZip2 ,
                  NS_COMPADDR1 = szCompAddr1, NS_COMPADDR2 = szCompAddr2,
                  NS_EMAIL = szEmail, NS_EMAIL2 = szEmail2, NS_INTRO = szIntro, NS_LOGO = szLogo, NS_DELINFO = szDelInfo, NS_REFUNDINFO = szRefundInfo, NS_MEMO = szMemo, 
                  NS_NAME_DISPLAY_FLAG = szIdDisplayFlag 
       WHERE SHOP_CODE = szShopVcode;

       EXCEPTION WHEN OTHERS THEN
        iRETURN := 1;
        ROLLBACK;
   END;

   IF iRETURN = 0 THEN
      BEGIN
          --' 쇼핑몰 배송료 조건
         UPDATE TBL_SHOP_DELIVERY SET SD_FEETYPE = NULL WHERE SHOP_CODE = szShopVcode AND SD_CODE = '0' AND SD_TYPE = '0';

         --' 쇼핑몰 배송지역 조건
         UPDATE TBL_SHOP_DELIVERY SET SD_AREATYPE = NULL WHERE SHOP_CODE = szShopVcode AND SD_CODE = '0' AND SD_TYPE = '1';
 
  		 --' 쇼핑몰 호수 선택   
         UPDATE TBL_NSHOP_NO SET SHOP_CODE = szShopVcode, SHOP_NO_USE='1' WHERE SHOP_NO=iSelectNo;   
   
         -- '쇼핑몰 호수 사용 히스토리   
         INSERT INTO TBL_NSHOPNO_HISTORY (ID,SHOP_NO, SHOP_CODE, SHOP_STARTDATE ) VALUES ((SELECT max(id)+1 FROM TBL_NSHOPNO_HISTORY), iSelectNo, szShopVcode, sysdate);   
   
         -- ' 쇼핑몰 구매 등록권 정보   
         UPDATE TBL_NSHOP_TICKET SET SHOP_CODE = szShopVcode, SHOP_NO = iSelectNo  WHERE PAY_OID = szOrderId;   
    
   
            EXCEPTION WHEN OTHERS THEN
             iRETURN := 2;
             ROLLBACK;
       END;
   END IF;

   IF iRETURN = 0 THEN
     iRETURN := 0;
     COMMIT;
    END IF;

   EXCEPTION
       WHEN OTHERS THEN
        iRETURN := 2;
        ROLLBACK;

END UDP_EDU_MEMBER_REUP;
 