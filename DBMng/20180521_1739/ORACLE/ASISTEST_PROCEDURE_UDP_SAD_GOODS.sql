/* *************************************************************************
 * NAME : ASISTEST.UDP_SAD_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:30
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SAD_GOODS" 
IS

  V_ENURI_USER_ID		VARCHAR2(12) :='';
  V_MODELNO		NUMBER(8) := 0;
  V_PL_NO		NUMBER(10) := 0;
  V_GOODSCODE		VARCHAR2(20) :='';
  V_SHOP_CODE		NUMBER(8) := 0;
  V_CA_CODE		VARCHAR2(10) :='';
  V_SAD_STATUS		CHAR(1) :='';
  V_SAD_UNIT_COPY		VARCHAR2(1000) :='';
  V_SAD_UNIT_PRICE		NUMBER(8) := 0;
  V_SAD_UNIT_TERM		NUMBER(3) := 0;
  V_SAD_START_DATE		DATE :=''; 
  V_SAD_END_DATE		DATE :='';

BEGIN
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SAD_GOODS','START');
    COMMIT;
    
     FOR tmp_loop in (
            select ENURI_USER_ID, MODELNO, PL_NO, GOODSCODE, SHOP_CODE, CA_CODE, SAD_STATUS, SAD_UNIT_COPY, SAD_UNIT_PRICE, SAD_UNIT_TERM, SAD_START_DATE, SAD_END_DATE 
            from TBL_SAD_GOODS 
            WHERE SAD_STATUS = '1' AND SAD_END_DATE < sysdate
    ) LOOP
      
        BEGIN
          V_ENURI_USER_ID := tmp_loop.ENURI_USER_ID;
          V_MODELNO := tmp_loop.MODELNO;
          V_PL_NO := tmp_loop.PL_NO;
          V_GOODSCODE := tmp_loop.GOODSCODE;
          V_SHOP_CODE := tmp_loop.SHOP_CODE;
          V_CA_CODE := tmp_loop.CA_CODE;
          V_SAD_STATUS := tmp_loop.SAD_STATUS;
          V_SAD_UNIT_COPY := tmp_loop.SAD_UNIT_COPY;
          V_SAD_UNIT_PRICE := tmp_loop.SAD_UNIT_PRICE;
          V_SAD_UNIT_TERM := tmp_loop.SAD_UNIT_TERM;
          V_SAD_START_DATE := tmp_loop.SAD_START_DATE;
          V_SAD_END_DATE := tmp_loop.SAD_END_DATE;
          
          UPDATE TBL_SAD_GOODS SET SAD_STATUS = '3' WHERE ENURI_USER_ID = V_ENURI_USER_ID AND PL_NO = V_PL_NO;
          
          INSERT INTO TBL_SAD_GOODS_LOG (LOG_IDX, ENURI_USER_ID, MODELNO, PL_NO, GOODSCODE, SHOP_CODE, CA_CODE, SAD_STATUS, SAD_UNIT_COPY, SAD_UNIT_PRICE, SAD_UNIT_TERM, SAD_START_DATE, SAD_END_DATE, REG_DATE ) 
          VALUES ((SELECT NVL(MAX(LOG_IDX),0)+1 FROM TBL_SAD_GOODS_LOG), V_ENURI_USER_ID, V_MODELNO, V_PL_NO, V_GOODSCODE, V_SHOP_CODE, V_CA_CODE, '3', V_SAD_UNIT_COPY, V_SAD_UNIT_PRICE, V_SAD_UNIT_TERM, V_SAD_START_DATE, V_SAD_END_DATE, SYSDATE);
      END ;
    END LOOP;
    COMMIT;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SAD_GOODS','END');
    COMMIT;
    
END UDP_SAD_GOODS;