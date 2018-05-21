/* *************************************************************************
 * NAME : DBENURI.UDP_ENURI_PC_PARTNER
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ENURI_PC_PARTNER" ( logDate VARCHAR2  ) AS 
v_run_date           char(14) :=0; 
v_sqlcode           varchar2(4000) :='';
v_sqlmsg            varchar2(4000) :='';
BEGIN
  SELECT to_char(sysdate,'YYYYMMDDHH24MISS') INTO v_run_date FROM dual;
  INSERT INTO TBL_ENURIPC_PARTNER_BAK (NO,CARDCASH,NAME,CEO,NUM,ADDRESS,TYPE,STATUS,FAX,TEL,LOGO,GOOD,HTML,INQU_INFO,DELI_INFO,RETURN_INFO,LOCA_INFO,NOTI_INFO,BEST_SHOP_ORD,SPECIAL_SHOP_YN,BAK_DATE, USE_YN) 
  (
    SELECT NO,CARDCASH,NAME,CEO,NUM,ADDRESS,TYPE,STATUS,FAX,TEL,LOGO,GOOD,HTML,INQU_INFO,DELI_INFO,RETURN_INFO,LOCA_INFO,NOTI_INFO,BEST_SHOP_ORD,SPECIAL_SHOP_YN,v_run_date, USE_YN FROM TBL_ENURIPC_PARTNER
   );
   DELETE TBL_ENURIPC_PARTNER;
   INSERT INTO TBL_ENURIPC_PARTNER (SELECT * FROM TBL_ENURIPC_PARTNER_TMP);       
   
  commit; 

 EXCEPTION
     WHEN OTHERS THEN
       v_sqlcode := SQLCODE;
       v_sqlmsg  := SQLERRM;       
       ROLLBACK;
       insert into TBL_ENURIPC_API_LOG values (logDate,'UDP_ENURI_PC_PARTNER',sysdate,sysdate,'FAIL','UDP_ENURI_PC_PARTNER error : errorcode => ' || v_sqlcode || ', ERRMSG => ' || v_sqlmsg,0,'PARTNER');
       commit;
         
END UDP_ENURI_PC_PARTNER;