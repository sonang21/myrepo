/* *************************************************************************
 * NAME : DBENURI.UDP_DEAL_GOODS_INSERT_CRAWER
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 13:46:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEAL_GOODS_INSERT_CRAWER" (v_shopcode IN NUMBER,v_goodscode IN VARCHAR)
IS
/*
 NGIT 체크 - 변경없음 김영원 20180424
*/
BEGIN
    
        DELETE DEAL_GOODS  WHERE DEAL_SHOP_CODE = v_shopcode AND META_ID = v_goodscode;    
        COMMIT;         
        INSERT INTO DEAL_GOODS (DEAL_IDX,DEAL_SHOP_CODE,META_ID,START_AT,END_AT,TITLE,URL,PRICE,DIVISION,FREE_SHIPPING,IMAGE_W,REG_DATE,FROM_JCA)
        (
            SELECT DEAL_SEQ.NEXTVAL DEAL_IDX ,SHOP_CODE DEAL_SHOP_CODE,GOODSCODE META_ID,SYSDATE START_AT, TRUNC(sysdate)+1-1/24/3600 END_AT,GOODSNM TITLE,URL URL,PRICE PRICE,UDF_DEAL_CATE_MAPPING(CA_CODE) DIVISION,
                   (CASE WHEN DELIVERYINFO = '무료배송' THEN 'Y' 
                         ELSE CASE WHEN INSTR(DELIVERYINFO,'미만') >= 0 THEN 'C' 
                                   ELSE CASE WHEN INSTR(DELIVERYINFO,'이하') >= 0 THEN 'C' 
                                             ELSE 'N'
                                        END
                              END 
                    END) FREE_SHIPPING,
                   IMGURL IMAGE_W,
                   SYSDATE REG_DATE,
                   'C' FROM_JCA
              FROM TBL_PRICELIST
             WHERE SHOP_CODE = v_shopcode
               AND GOODSCODE = v_goodscode
               AND STATUS in ('0','8','9')
               AND SRVFLAG in ('0','L','R') 
               AND ROWNUM = 1
        );
        COMMIT;

END;
