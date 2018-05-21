/* *************************************************************************
 * NAME : DBENURI.UDP_DEAL_GOODS_INSERT_JCA
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 15:09:30
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEAL_GOODS_INSERT_JCA" (v_p IN VARCHAR,v_shopcode IN NUMBER,v_goodscode IN VARCHAR)
IS
/*
 NGIT 체크 - 변경없음 김영원 20180424
*/
BEGIN
    IF v_p = 'I' THEN
        IF v_shopcode = 806 THEN
          DELETE DEAL_GOODS  WHERE DEAL_SHOP_CODE = 6688 AND META_ID = v_goodscode;    
          COMMIT;         
          INSERT INTO DEAL_GOODS (DEAL_IDX,DEAL_SHOP_CODE,META_ID,START_AT,END_AT,TITLE,URL,MOBILE_URL,PRICE,DIVISION,FREE_SHIPPING,IMAGE_W,REG_DATE,FROM_JCA,INSTANT_DELIVER,TODAY_USE)
          (
              SELECT DEAL_SEQ.NEXTVAL DEAL_IDX ,6688 DEAL_SHOP_CODE,GOODSCODE META_ID,SYSDATE START_AT, TRUNC(SYSDATE,'yyyy-mm-dd')+1-1/24/3600 END_AT,GOODSNM TITLE,REPLACE(URL,'?infl_cd=I0647','?infl_cd=I0031') URL,REPLACE(URL,'?infl_cd=I0647','?infl_cd=I0871') MOBILE_URL,PRICE PRICE,UDF_DEAL_CATE_MAPPING(CA_CODE) DIVISION,
              (CASE WHEN DELIVERYINFO = '무료배송' THEN 'Y' 
              ELSE CASE WHEN INSTR(DELIVERYINFO,'미만') >= 0 THEN 'C' 
              ELSE CASE WHEN INSTR(DELIVERYINFO,'이하') >= 0 THEN 'C' ELSE 'N' END END END) FREE_SHIPPING,
              IMGURL IMAGE_W,SYSDATE REG_DATE,'Y' FROM_JCA,'N' INSTANT_DELIVER,'N' TODAY_USE              
              FROM TBL_PRICELIST WHERE SHOP_CODE = 806 AND GOODSCODE = v_goodscode
              AND STATUS in ('0','8','9') AND SRVFLAG in ('0','L','R') AND ROWNUM = 1
          );
          COMMIT;
          DELETE deal.d4_coupon  WHERE cp_company in (select mb_id  from deal.g4_member where mb_shop_code = 6688) AND cp_pid = v_goodscode;    
          COMMIT;
          deal.COUPON_CR_ONE(6688,trim(v_goodscode));
          COMMIT;
        ELSE
          DELETE DEAL_GOODS  WHERE DEAL_SHOP_CODE = v_shopcode AND META_ID = v_goodscode;    
          COMMIT;         
          INSERT INTO DEAL_GOODS (DEAL_IDX,DEAL_SHOP_CODE,META_ID,START_AT,END_AT,TITLE,URL,PRICE,DIVISION,FREE_SHIPPING,IMAGE_W,REG_DATE,FROM_JCA)
          (
              SELECT DEAL_SEQ.NEXTVAL DEAL_IDX ,SHOP_CODE DEAL_SHOP_CODE,GOODSCODE META_ID,SYSDATE START_AT, TRUNC(SYSDATE,'yyyy-mm-dd')+1-1/24/3600 END_AT,GOODSNM TITLE,URL URL,PRICE PRICE,UDF_DEAL_CATE_MAPPING(CA_CODE) DIVISION,
              (CASE WHEN DELIVERYINFO = '무료배송' THEN 'Y' 
              ELSE CASE WHEN INSTR(DELIVERYINFO,'미만') >= 0 THEN 'C' 
              ELSE CASE WHEN INSTR(DELIVERYINFO,'이하') >= 0 THEN 'C' ELSE 'N' END END END) FREE_SHIPPING,
              IMGURL IMAGE_W,SYSDATE REG_DATE,'Y' FROM_JCA
              FROM TBL_PRICELIST WHERE SHOP_CODE = v_shopcode AND GOODSCODE = v_goodscode
              AND STATUS in ('0','8','9') AND SRVFLAG in ('0','L','R') AND ROWNUM = 1
          );
          COMMIT;
          DELETE deal.d4_coupon  WHERE cp_company in (select mb_id  from deal.g4_member where mb_shop_code = v_shopcode) AND cp_pid = v_goodscode;    
          COMMIT;
          deal.COUPON_CR_ONE(v_shopcode,trim(v_goodscode));
          COMMIT;
        END IF;
    ELSE 
        DELETE DEAL_GOODS  WHERE DEAL_SHOP_CODE = v_shopcode AND META_ID = v_goodscode AND TO_CHAR(sysdate,'YYYY-MM-DD') = TO_CHAR(REG_DATE,'YYYY-MM-DD');
        COMMIT; 
    END IF;
END;
