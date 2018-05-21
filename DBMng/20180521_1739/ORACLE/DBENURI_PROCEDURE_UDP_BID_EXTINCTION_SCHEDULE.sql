/* *************************************************************************
 * NAME : DBENURI.UDP_BID_EXTINCTION_SCHEDULE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_BID_EXTINCTION_SCHEDULE" 
IS
    v_enuri_user_id         VARCHAR2(20) :='';
    v_free_charge_money     NUMBER := 0;
    v_free_exhaustion_money NUMBER := 0;
    v_free_balance_money		NUMBER := 0;

BEGIN
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_EXTINCTION_SCHEDULE','START');
    COMMIT;

    FOR tmp_loop in (
                      SELECT ENURI_USER_ID, SUM(AL_MONEY) AS FREE_CHARGE_MONEY
                      FROM TBL_BID_ACCOUNT_LOG
                      WHERE AL_ACCOUNT_TYPE IN(2,4,5) AND to_char(AL_REG_DATE,'YYYYMM') = to_char(add_months(sysdate, -2),'YYYYMM')
                      GROUP BY ENURI_USER_ID
   ) LOOP
   
	 BEGIN
        v_enuri_user_id := tmp_loop.ENURI_USER_ID;
        v_free_charge_money := tmp_loop.FREE_CHARGE_MONEY;
        
        -- 소진금액
        SELECT NVL(SUM(FREE_EXHAUSTION_MONEY),0) INTO v_free_exhaustion_money 
        FROM TBL_BID_DAILY_BALANCE
        WHERE ENURI_USER_ID = TMP_LOOP.ENURI_USER_ID
        AND BID_DATE >= to_char((SELECT min(AL_REG_DATE) as AL_REG_DATE
        FROM TBL_BID_ACCOUNT_LOG
        WHERE AL_ACCOUNT_TYPE IN(2,4,5)
        AND ENURI_USER_ID=TMP_LOOP.ENURI_USER_ID
        AND to_char(AL_REG_DATE,'YYYYMM') = to_char(add_months(sysdate, -2),'YYYYMM')
        GROUP BY ENURI_USER_ID),'YYYY-MM-DD');
        
        -- 무상지급잔액
    	  SELECT  NVL(SUM(BONUS_MONEY),0) INTO v_free_balance_money
        FROM TBL_SDUL_MEMBER
        WHERE ENURI_USER_ID = TMP_LOOP.ENURI_USER_ID;
    
        IF v_free_charge_money > v_free_exhaustion_money THEN
          v_free_balance_money := v_free_balance_money - (v_free_charge_money - v_free_exhaustion_money);
          
          IF v_free_balance_money < 0 THEN
            v_free_balance_money := 0;
          END IF;
          
        BEGIN
      		UPDATE TBL_SDUL_MEMBER SET BONUS_MONEY = v_free_balance_money
      		WHERE ENURI_USER_ID = TMP_LOOP.ENURI_USER_ID;
      
    		  COMMIT;
    		  
          BEGIN
        		INSERT INTO TBL_BID_EXTINCTION_LOG (ENURI_USER_ID, FREE_CHARGE_MONEY, FREE_EXHAUSTION_MONEY, FREE_BALANCE_MONEY, EXTINCTION_DATE, FREE_ABANDONED_MONEY)
      	    		VALUES(v_enuri_user_id, v_free_charge_money, v_free_exhaustion_money, v_free_balance_money, sysdate, (v_free_charge_money - v_free_exhaustion_money));
      
          COMMIT;
    		  
          EXCEPTION
           		WHEN OTHERS THEN
            		ROLLBACK;
         	END;
    		  
        EXCEPTION
        	WHEN OTHERS THEN
          	ROLLBACK;
        END;
        END IF;

    END ;
    END LOOP;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_EXTINCTION_SCHEDULE','END');
    COMMIT;
    
END UDP_BID_EXTINCTION_SCHEDULE;