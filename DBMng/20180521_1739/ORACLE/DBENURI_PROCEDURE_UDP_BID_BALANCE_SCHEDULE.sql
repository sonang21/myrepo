/* *************************************************************************
 * NAME : DBENURI.UDP_BID_BALANCE_SCHEDULE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_BID_BALANCE_SCHEDULE" 
IS
    v_bid_date              VARCHAR2(10) :=''; 
    v_enuri_user_id         VARCHAR2(20) :='';
    v_user_name             VARCHAR2(20) :='';
    v_pay_charge_money      NUMBER := 0;
    v_free_charge_money     NUMBER := 0;
    v_pay_exhaustion_money  NUMBER := 0;
    v_free_exhaustion_money NUMBER := 0;
    v_pay_sad_exhaustion_money  NUMBER := 0;
    v_free_sad_exhaustion_money NUMBER := 0;
    v_pay_sdul_exhaustion_money  NUMBER := 0;
    v_free_sdul_exhaustion_money NUMBER := 0;
    v_return_money          NUMBER := 0;
    v_pay_balance_money     NUMBER := 0;
    v_free_balance_money		NUMBER := 0;
    v_free_abandoned_money		NUMBER := 0;
    i_count      NUMBER := 0;

BEGIN
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_BALANCE_SCHEDULE','START');
    COMMIT;
    
    --DELETE TBL_BID_DAILY_BALANCE WHERE BID_DATE = to_char(sysdate-1,'YYYY-MM-DD');
    --COMMIT;

    i_count := 0;
    FOR tmp_loop in (
              SELECT A.ENURI_USER_ID as ENURI_USER_ID, A.USER_NAME as USER_NAME, NVL(A.ENURI_MONEY,0) as PAY_BALANCE_MONEY, NVL(A.BONUS_MONEY,0) as FREE_BALANCE_MONEY
              FROM TBL_SDUL_MEMBER A
              ORDER BY A.ENURI_USER_ID
    ) LOOP

      BEGIN
          v_enuri_user_id := tmp_loop.ENURI_USER_ID;
          v_user_name := tmp_loop.USER_NAME;
          v_pay_balance_money := tmp_loop.PAY_BALANCE_MONEY;
          v_free_balance_money := tmp_loop.FREE_BALANCE_MONEY;
          
          -- �����ݾ�
          SELECT NVL(SUM(MONEY),0) INTO v_pay_charge_money 
          FROM TBL_BID_ACCOUNT
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND TO_CHAR(REGDATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD');
      
          -- �������޾�
          SELECT NVL(SUM(AL_MONEY),0) INTO v_free_charge_money 
          FROM TBL_BID_ACCOUNT_LOG 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND TO_CHAR(AL_REG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD') AND AL_ACCOUNT_TYPE IN(2,4,5);
          
          -- ���� ������
          SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_exhaustion_money 
          FROM TBL_BID_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID 
          AND CASH_TYPE = 1 AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
         
          -- ���� ������
          SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_exhaustion_money 
          FROM TBL_BID_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND CASH_TYPE = 1 AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
          
          -- ���� �Ǹ��� ������ ������
          SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_sad_exhaustion_money 
          FROM TBL_SAD_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
          
          -- ���� �Ǹ��� ������ ������
          SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_sad_exhaustion_money 
          FROM TBL_SAD_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
          
          -- ���� ��ǰ��� ������
          SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_sdul_exhaustion_money 
          FROM TBL_SDUL_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
          
          -- ���� ��ǰ��� ������
          SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_sdul_exhaustion_money 
          FROM TBL_SDUL_DEDUCTION 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD');
      
          -- ȯ�ұݾ�
          SELECT NVL(SUM(AL_MONEY),0) INTO v_return_money 
          FROM TBL_BID_ACCOUNT_LOG 
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND TO_CHAR(AL_REG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD') AND AL_ACCOUNT_TYPE = 3;
          
          -- ���� �Ҹ� �ݾ�
          SELECT NVL(SUM(FREE_ABANDONED_MONEY),0) INTO v_free_abandoned_money 
          FROM TBL_BID_EXTINCTION_LOG   
          WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
          AND TO_CHAR(EXTINCTION_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD') ;
      
      
          INSERT INTO TBL_BID_DAILY_BALANCE (BID_DATE, ENURI_USER_ID, USER_NAME, PAY_CHARGE_MONEY, FREE_CHARGE_MONEY, PAY_EXHAUSTION_MONEY, FREE_EXHAUSTION_MONEY, RETURN_MONEY,	PAY_BALANCE_MONEY, FREE_BALANCE_MONEY, FREE_ABANDONED_MONEY, PAY_SAD_EXHAUSTION_MONEY, FREE_SAD_EXHAUSTION_MONEY, PAY_SDUL_EXHAUSTION_MONEY, FREE_SDUL_EXHAUSTION_MONEY ) 
          VALUES(to_char(sysdate-1,'YYYY-MM-DD'), v_enuri_user_id, v_user_name,	v_pay_charge_money,	v_free_charge_money, v_pay_exhaustion_money, v_free_exhaustion_money,	v_return_money,	v_pay_balance_money, v_free_balance_money, v_free_abandoned_money, v_pay_sad_exhaustion_money, v_free_sad_exhaustion_money, v_pay_sdul_exhaustion_money, v_free_sdul_exhaustion_money );
      
           EXCEPTION WHEN OTHERS THEN
           COMMIT;
           
           i_count := i_count + 1;
           
      END ;
    
      IF i_count = 10 THEN
        COMMIT;
        i_count := 0;
      END IF;
    
    END LOOP;
    
    COMMIT;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_BALANCE_SCHEDULE','END');
    COMMIT;
    
END UDP_BID_BALANCE_SCHEDULE;