/* *************************************************************************
 * NAME : ASISTEST.UDP_ENURI_PC_PRICE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:22
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ENURI_PC_PRICE" ( logDate VARCHAR2  ) AS 
v_run_date           char(14) :=0; 
v_sqlcode           varchar2(4000) :='';
v_sqlmsg            varchar2(4000) :='';
BEGIN
  SELECT to_char(sysdate,'YYYYMMDDHH24MISS') INTO v_run_date FROM dual;
  INSERT INTO TBL_ENURIPC_PRICE_BAK (PD_NO,PD_CARD_PRICE,PD_CASH_PRICE,PD_MINPRICE,BAK_DATE) 
  (
    SELECT PD_NO,PD_CARD_PRICE,PD_CASH_PRICE,PD_MINPRICE,v_run_date FROM TBL_ENURIPC_PRICE
   );
   DELETE TBL_ENURIPC_PRICE;
   INSERT INTO TBL_ENURIPC_PRICE (SELECT * FROM TBL_ENURIPC_PRICE_TMP);       
   
  INSERT INTO TBL_ENURIPC_COMPANY_PRICE_BAK (PD_NO,NO,PRICE,BAK_DATE) 
  (
    SELECT PD_NO,NO,PRICE,v_run_date FROM TBL_ENURIPC_COMPANY_PRICE_BAK
   );
   DELETE TBL_ENURIPC_COMPANY_PRICE;
   INSERT INTO TBL_ENURIPC_COMPANY_PRICE (SELECT * FROM TBL_ENURIPC_COMPANY_PRICE_TMP); 

  UPDATE TBL_ENURIPC_PRICE A SET PD_MINPRICE = 
  (SELECT MINPRICE FROM (SELECT PD_NO,  MIN(PRICE) AS MINPRICE FROM TBL_ENURIPC_COMPANY_PRICE WHERE PRICE > 0 GROUP BY PD_NO ) B
  WHERE A.PD_NO = B.PD_NO);   
  
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_ENURI_PC error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
       v_sqlcode := SQLCODE;
       v_sqlmsg  := SQLERRM;       
       ROLLBACK;
       insert into TBL_ENURIPC_API_LOG values (logDate,'UDP_ENURI_PC_PRICE',sysdate,sysdate,'FAIL','UDP_ENURI_PC_PRICE error : errorcode => ' || v_sqlcode || ', ERRMSG => ' || v_sqlmsg,0,'PRICE');
       commit;
         
END UDP_ENURI_PC_PRICE;