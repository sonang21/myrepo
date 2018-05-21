/* *************************************************************************
 * NAME : DBENURI.UDP_BID_BALANCE_MA_SCHEDULE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_BID_BALANCE_MA_SCHEDULE" (SDATE IN VARCHAR2)
IS
    v_bid_date              VARCHAR2(10) :='';
    v_enuri_user_id         VARCHAR2(20) :='';
    v_user_name             VARCHAR2(20) :='';
    v_pay_charge_money      NUMBER := 0;
    v_free_charge_money     NUMBER := 0;
    v_pay_exhaustion_money  NUMBER := 0;
    v_free_exhaustion_money NUMBER := 0;
    v_return_money          NUMBER := 0;
    v_pay_balance_money     NUMBER := 0;
    v_free_balance_money		NUMBER := 0;
    v_pay_sad_exhaustion_money  NUMBER := 0;
    v_free_sad_exhaustion_money NUMBER := 0;
    v_pay_sdul_exhaustion_money  NUMBER := 0;
    v_free_sdul_exhaustion_money NUMBER := 0;
    v_befo_pay_balance_money     NUMBER := 0;
    v_befo_free_balance_money     NUMBER := 0;
    v_free_abandoned_money		NUMBER := 0;

BEGIN
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_BALANCE_MA_SCHEDULE','START');
    COMMIT;
    
    DELETE TBL_BID_DAILY_BALANCE WHERE BID_DATE = (TO_DATE(SDATE,'YYYY-MM-DD'));
    COMMIT;

    FOR tmp_loop in (
              SELECT A.ENURI_USER_ID as ENURI_USER_ID, A.USER_NAME as USER_NAME, NVL(A.ENURI_MONEY,0) as PAY_BALANCE_MONEY, NVL(A.BONUS_MONEY,0) as FREE_BALANCE_MONEY
              FROM TBL_SDUL_MEMBER A
              ORDER BY A.ENURI_USER_ID
    ) LOOP

    BEGIN
        v_enuri_user_id := tmp_loop.ENURI_USER_ID;
        v_user_name := tmp_loop.USER_NAME;
        
        -- 전일 유상 잔액
        SELECT NVL(SUM(PAY_BALANCE_MONEY),0) INTO v_befo_pay_balance_money 
    	  FROM TBL_BID_DAILY_BALANCE
    	  WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
    	  AND BID_DATE=(TO_DATE(SDATE,'YYYY-MM-DD')-1);
        
        -- 전일 무상 잔액
        SELECT NVL(SUM(FREE_BALANCE_MONEY),0) INTO v_befo_free_balance_money 
    	  FROM TBL_BID_DAILY_BALANCE
    	  WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
    	  AND BID_DATE=(TO_DATE(SDATE,'YYYY-MM-DD')-1);
        
        -- 충전금액
    	  SELECT NVL(SUM(MONEY),0) INTO v_pay_charge_money 
    	  FROM TBL_BID_ACCOUNT
    	  WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
    	  AND TO_CHAR(REGDATE,'YYYYMMDD') = TO_CHAR(to_date(SDATE),'YYYYMMDD');
    
        -- 무상지급액
        SELECT NVL(SUM(AL_MONEY),0) INTO v_free_charge_money 
        FROM TBL_BID_ACCOUNT_LOG 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND TO_CHAR(AL_REG_DATE,'YYYYMMDD') = TO_CHAR(to_date(SDATE),'YYYYMMDD') AND AL_ACCOUNT_TYPE IN(2,4,5);
        
        -- 유상 소진액
        SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_exhaustion_money 
        FROM TBL_BID_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND CASH_TYPE = 1 AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
       
        -- 무상 소진액
        SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_exhaustion_money 
        FROM TBL_BID_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND CASH_TYPE = 1 AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
        
        -- 유상 판매자 광고문구 소진액
        SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_sad_exhaustion_money 
        FROM TBL_SAD_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
        
        -- 무상 판매자 광고문구 소진액
        SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_sad_exhaustion_money 
        FROM TBL_SAD_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
        
        -- 유상 상품등록 소진액
        SELECT NVL(SUM(ENURI_DEDUCTION),0) INTO v_pay_sdul_exhaustion_money 
        FROM TBL_SDUL_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
        
        -- 무상 상품등록 소진액
        SELECT NVL(SUM(BONUS_DEDUCTION),0) INTO v_free_sdul_exhaustion_money 
        FROM TBL_SDUL_DEDUCTION 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND DEDUCTION_SEARCH_DATE = TO_CHAR(to_date(SDATE),'YYYYMMDD');
    
        -- 환불금액
        SELECT NVL(SUM(AL_MONEY),0) INTO v_return_money 
        FROM TBL_BID_ACCOUNT_LOG 
        WHERE enuri_user_id = tmp_loop.ENURI_USER_ID
        AND TO_CHAR(AL_REG_DATE,'YYYYMMDD') = TO_CHAR(to_date(SDATE),'YYYYMMDD') AND AL_ACCOUNT_TYPE = 3;
        
        v_pay_balance_money := (v_befo_pay_balance_money+(v_pay_charge_money-v_return_money))-(v_pay_exhaustion_money+v_pay_sad_exhaustion_money+v_pay_sdul_exhaustion_money);
        v_free_balance_money := (v_befo_free_balance_money+v_free_charge_money)-(v_free_exhaustion_money+v_free_sad_exhaustion_money+v_free_sdul_exhaustion_money);
    
    
    		INSERT INTO TBL_BID_DAILY_BALANCE (BID_DATE, ENURI_USER_ID, USER_NAME, PAY_CHARGE_MONEY, FREE_CHARGE_MONEY, PAY_EXHAUSTION_MONEY, FREE_EXHAUSTION_MONEY, RETURN_MONEY,	PAY_BALANCE_MONEY, FREE_BALANCE_MONEY, FREE_ABANDONED_MONEY, PAY_SAD_EXHAUSTION_MONEY, FREE_SAD_EXHAUSTION_MONEY, PAY_SDUL_EXHAUSTION_MONEY, FREE_SDUL_EXHAUSTION_MONEY )
    	  VALUES (SDATE, v_enuri_user_id, v_user_name,	v_pay_charge_money,	v_free_charge_money, v_pay_exhaustion_money, v_free_exhaustion_money,	v_return_money,	v_pay_balance_money, v_free_balance_money, v_free_abandoned_money , v_pay_sad_exhaustion_money, v_free_sad_exhaustion_money, v_pay_sdul_exhaustion_money, v_free_sdul_exhaustion_money);
    
    		COMMIT;

    END ;
    END LOOP;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_BALANCE_MA_SCHEDULE','END');
    COMMIT;
    
END UDP_BID_BALANCE_MA_SCHEDULE;