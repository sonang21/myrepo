/* *************************************************************************
 * NAME : DBENURI.UDP_EDU_MEMBER_INS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_EDU_MEMBER_INS" ( 
     szNuriType IN  TBL_NSHOP_DETAIL.ns_type%TYPE, 
     szCompType IN  TBL_NSHOP_DETAIL.NS_COMPANYTYPE%TYPE, 
     szShopName IN  tbl_shoplist.shop_name%TYPE, 
     szID IN   tbl_shoplist.id%TYPE, 
     szPass IN  tbl_shoplist.pwd%TYPE, 
     szRegNo1 IN  TBL_NSHOP_DETAIL.NS_REGNO%TYPE, 
     szRegNo2 IN  TBL_NSHOP_DETAIL.NS_REGNO%TYPE, 
     szCompanyNo IN  TBL_NSHOP_DETAIL.NS_COMPANYNO%TYPE, 
     szCondition IN  TBL_NSHOP_DETAIL.NS_CONDITION%TYPE, 
     szItem IN  TBL_NSHOP_DETAIL.NS_ITEM%TYPE, 
     szPresident IN  tbl_shoplist.es_president%TYPE, 
     szBankCode IN  TBL_NSHOP_DETAIL.NS_BANKCODE%TYPE, 
     szAccount IN  TBL_NSHOP_DETAIL.NS_ACCOUNT%TYPE, 
     szDepositor IN  TBL_NSHOP_DETAIL.NS_DEPOSITOR%TYPE, 
     szIntro IN  TBL_NSHOP_DETAIL.NS_INTRO%TYPE, 
     szLogo IN  TBL_NSHOP_DETAIL.NS_LOGO%TYPE, 
     szPhone1No1 IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO1%TYPE, 
     szPhone1No2 IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO2%TYPE, 
     szPhone1No3 IN  TBL_NSHOP_DETAIL.NS_PHONE1_NO3%TYPE, 
     szPhone2No1 IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO1%TYPE, 
     szPhone2No2 IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO2%TYPE, 
     szPhone2No3 IN  TBL_NSHOP_DETAIL.NS_PHONE2_NO3%TYPE, 
     szMobileNo1 IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO1%TYPE, 
     szMobileNo2 IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO2%TYPE, 
     szMobileNo3 IN  TBL_NSHOP_DETAIL.NS_MOBILE_NO3%TYPE, 
     szFaxNo1 IN  TBL_NSHOP_DETAIL.NS_FAX_NO1%TYPE, 
     szFaxNo2 IN  TBL_NSHOP_DETAIL.NS_FAX_NO2%TYPE, 
     szFaxNo3 IN  TBL_NSHOP_DETAIL.NS_FAX_NO3%TYPE, 
     szZip1 IN  TBL_NSHOP_DETAIL.NS_ZIP1%TYPE, 
     szZip2 IN  TBL_NSHOP_DETAIL.NS_ZIP2%TYPE, 
     szAddr1 IN  TBL_NSHOP_DETAIL.NS_ADDR1%TYPE, 
     szAddr2 IN  TBL_NSHOP_DETAIL.NS_ADDR2%TYPE, 
     szCompZip1 IN  TBL_NSHOP_DETAIL.NS_COMPZIP1%TYPE, 
     szCompZip2 IN  TBL_NSHOP_DETAIL.NS_COMPZIP2%TYPE, 
     szCompAddr1 IN  TBL_NSHOP_DETAIL.NS_COMPADDR1%TYPE, 
     szCompAddr2 IN  TBL_NSHOP_DETAIL.NS_COMPADDR2%TYPE, 
     szEmail IN  TBL_NSHOP_DETAIL.NS_EMAIL%TYPE, 
     szEmail2 IN  TBL_NSHOP_DETAIL.NS_EMAIL2%TYPE, 
     szEmailFlag IN  tbl_shoplist.emailflag%TYPE, 
     szDelInfo IN  TBL_NSHOP_DETAIL.NS_DELINFO%TYPE, 
     szRefundInfo IN  TBL_NSHOP_DETAIL.NS_REFUNDINFO%TYPE, 
     szMemo IN  TBL_NSHOP_DETAIL.NS_MEMO%TYPE, 
     szGanada IN  TBL_SHOPLIST.ganada%TYPE, 
     szDelFee IN  TBL_SHOP_DELIVERY.SD_FEETYPE%TYPE, 
     szDelArea IN  TBL_SHOP_DELIVERY.SD_AREATYPE%TYPE, 
     szCorpNo1 IN  TBL_NSHOP_DETAIL.NS_CORPNO%TYPE, 
     szCorpNo2 IN  TBL_NSHOP_DETAIL.NS_CORPNO%TYPE, 
     szPreRegNo1 IN  TBL_SHOPLIST.es_regno1%TYPE, 
     szPreRegNo2 IN  TBL_SHOPLIST.es_regno2%TYPE, 
     iSelectNo IN  TBL_NSHOP_DETAIL.NS_NO%TYPE, 
      -- iRegTotal IN  int, 
      -- iRegCount IN  int, 
      -- iTicketPrice IN  int, 
      -- szRegEndDate IN varchar2(10), 
     szOrderId IN  TBL_NSHOP_TICKET.PAY_OID%TYPE, 
     szIdDisplayFlag IN tbl_shoplist.auth%TYPE,  -- 아이디/상호명 출력여부 by hsw 2005.03.29  
     szForms IN TBL_NSHOP_DETAIL.NS_FORMS%TYPE,  			-- 서류 제출 여부  claudy 2005.06.15 
     szPayReserve IN TBL_NSHOP_DETAIL.NS_PAYRESERVE%TYPE,   -- 송금 보류 여부  claudy 2005.06.15
     iRETURN IN OUT INTEGER) 
IS 
  SHOP_PHONE VARCHAR2(15) := ''; 
  VCODE_TEMP  tbl_shoplist.shop_code%TYPE; 
 
BEGIN 
   --DBMS_OUTPUT.ENABLE; 
   DBMS_OUTPUT.PUT_LINE('UDP_EDU_MEMBER_INS starting ......'); 
 
   iRETURN :=0; 
 
   SELECT NVL(MAX(shop_code),0)+1 
     INTO VCODE_TEMP 
     FROM TBL_SHOPLIST; 
 
   IF szPhone2No1 = '' THEN 
    SHOP_PHONE := ''; 
   ELSE 
    SHOP_PHONE := szPhone2No1 || '-' || szPhone2No2 || '-' || szPhone2No3; 
   END IF; 
 
    BEGIN 
     -- SHOPLIST 에 INSERT 
     INSERT INTO TBL_SHOPLIST 
     (shop_no,shop_code, shop_name, id, pwd, email, emailflag, tel, scale, ganada, flag, apflag, datasource, sduclass, updatetools, opt, auth, 
      es_use, es_mid, es_delterm, trans_code, es_reqdate, es_usedate, es_president, es_regno1, es_regno2, es_use_sort) 
     VALUES 
     ((select max(shop_no)+1 from TBL_SHOPLIST), VCODE_TEMP, szShopName, szID, szPass, szEmail, szEmailFlag, SHOP_PHONE, '3', szGanada, '1', '4', '3', '1', '1', '1', '5', 
      '9', 'enuricom01', 5,'0', sysdate, sysdate, szPresident, szPreRegNo1, szPreRegNo2 ,'9'); 
 
  
     DELETE TBL_SDU_IDCHANGED WHERE shop_code = VCODE_TEMP;   
     INSERT INTO TBL_SDU_IDCHANGED(shop_code, oldid, oldpwd) values (VCODE_TEMP, szID, szPass);   
   
      
  --TBL_NSHOP_DETAIL 에 INSERT   
   
     INSERT INTO TBL_NSHOP_DETAIL   
     (SHOP_CODE, SHOP_ID, NS_TYPE, NS_NO, NS_COMPANYTYPE, NS_REGNO, NS_SHOPNAME, NS_COMPANYNO, NS_CORPNO,  NS_CONDITION, NS_ITEM, NS_PRESIDENT,   
     NS_PREREGNO, NS_BANKCODE, NS_ACCOUNT, NS_DEPOSITOR, NS_INTRO, NS_LOGO, NS_PHONE1_NO1, NS_PHONE1_NO2, NS_PHONE1_NO3,   
     NS_PHONE2_NO1, NS_PHONE2_NO2, NS_PHONE2_NO3, NS_FAX_NO1, NS_FAX_NO2, NS_FAX_NO3, NS_MOBILE_NO1, NS_MOBILE_NO2, NS_MOBILE_NO3,   
     NS_ZIP1, NS_ZIP2, NS_ADDR1, NS_ADDR2, NS_COMPZIP1, NS_COMPZIP2, NS_COMPADDR1, NS_COMPADDR2,   
     NS_EMAIL, NS_EMAIL2,  NS_DELINFO, NS_REFUNDINFO, NS_MEMO,NS_PAYRESERVE,NS_FORMS,NS_NAME_DISPLAY_FLAG)   
     VALUES   
     (VCODE_TEMP,szID, szNuriType, iSelectNo, szCompType, szRegNo1 || szRegNo2, szShopName, szCompanyNo, szCorpNo1 || szCorpNo2, szCondition, szItem, szPresident,   
     szPreRegNo1+szPreRegNo2, szBankCode, szAccount, szDepositor, szIntro, szLogo, szPhone1No1, szPhone1No2, szPhone1No3,   
     szPhone2No1, szPhone2No2, szPhone2No3, szFaxNo1, szFaxNo2, szFaxNo3, szMobileNo1, szMobileNo2, szMobileNo3,   
     szZip1, szZip2, szAddr1, szAddr2, szCompZip1, szCompZip2, szCompAddr1, szCompAddr2,   
     szEmail, szEmail2, szDelInfo, szRefundInfo, szMemo,szPayReserve,szForms,szIdDisplayFlag);   
   
     EXCEPTION WHEN OTHERS THEN   
       iRETURN := 1;   
       ROLLBACK;   
   
    END;   
   
   IF iRETURN = 0 THEN   
      BEGIN   
         --' 쇼핑몰 배송료 조건   
         INSERT INTO TBL_SHOP_DELIVERY (ID, SHOP_CODE, SD_CODE, SD_TYPE, SD_FEETYPE) VALUES ((SELECT NVL(MAX(id),0)+1 from TBL_SHOP_DELIVERY), VCODE_TEMP, '0', '0', szDelFee);   
   
   
         --' 쇼핑몰 배송지역 조건   
         INSERT INTO TBL_SHOP_DELIVERY (ID,SHOP_CODE, SD_CODE, SD_TYPE,  SD_AREATYPE) VALUES ((SELECT NVL(MAX(id),0)+1 from TBL_SHOP_DELIVERY), VCODE_TEMP, '0', '1',  szDelArea );   
   
         --' 쇼핑몰 호수 선택   
         UPDATE TBL_NSHOP_NO SET SHOP_CODE = VCODE_TEMP, SHOP_NO_USE='1' WHERE SHOP_NO=iSelectNo;   
   
         -- '쇼핑몰 호수 사용 히스토리   
         INSERT INTO TBL_NSHOPNO_HISTORY (ID,SHOP_NO, SHOP_CODE, SHOP_STARTDATE ) VALUES ((SELECT max(id)+1 FROM TBL_NSHOPNO_HISTORY), iSelectNo, VCODE_TEMP, sysdate);   
   
         -- ' 쇼핑몰 구매 등록권 정보   
         UPDATE TBL_NSHOP_TICKET SET SHOP_CODE = VCODE_TEMP, SHOP_NO = iSelectNo  WHERE PAY_OID = szOrderId;   
   
         --   INSERT INTO DBO.TBL_NSHOP_TICKET   
            --   (SHOP_VCODE, NT_REGDATE, NT_ENDDATE, NT_REGTOTAL, NT_REGCOUNT, NT_REGFEE )   
            --   VALUES ( @SHOP_VCODE, GetDate(), @szRegEndDate, @iRegTotal, @iRegCount, @iTicketPrice )   
   
            EXCEPTION WHEN OTHERS THEN   
           iRETURN := 2;   
           ROLLBACK;   
        END;   
  END IF;  
  
   iRETURN := 0;  
   COMMIT;  
  
  EXCEPTION WHEN OTHERS THEN  
       iRETURN := 2;  
       ROLLBACK; 
END UDP_EDU_MEMBER_INS;
 