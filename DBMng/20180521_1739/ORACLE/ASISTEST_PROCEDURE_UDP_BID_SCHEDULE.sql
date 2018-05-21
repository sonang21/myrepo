/* *************************************************************************
 * NAME : ASISTEST.UDP_BID_SCHEDULE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:16
 *        Modify: 2018-05-04 18:53:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_BID_SCHEDULE" 
IS
    v_bid_possess_money             NUMBER := 0;
    v_bid_total_view                NUMBER := 0;
    v_bid_valid_view                NUMBER := 0;
    v_bid_total_click               NUMBER := 0;
    v_bid_valid_click               NUMBER := 0;
    v_before_bid_possess_money      NUMBER := 0;
    v_bid_all_price                 NUMBER := 0;
    v_bid_exhaustion_money          NUMBER := 0;
    v_modelno                       NUMBER := 0;
    v_bid_unit_price				NUMBER := 0;
    v_bid_cnt						NUMBER := 0;
    v_service_cnt                   NUMBER := 0;
    v_add_service_cnt               NUMBER := 0;
    v_ca_code                       VARCHAR2(12) :='';
    v_no							NUMBER := 0;
    i_count      NUMBER := 0;

BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_SCHEDULE','START');
    COMMIT;
    
    --=================================================================================================
    -- 일별,입찰건수별 전체 집계
    --=================================================================================================

    DELETE TBL_BID_DAILY WHERE BID_DATE = to_char(sysdate-1,'YYYYMMDD');
    COMMIT;

    SELECT NVL(MAX(BID_DAILY_NO),0) INTO v_no FROM TBL_BID_DAILY;
    i_count := 0;
        
    FOR tmp_loop in (
                     SELECT PL_NO as pl_no, BID_UNIT_PRICE as bid_unit_price
         				     FROM TBL_BID_GOODS_EXP
 			          		 WHERE BID_STATUS = '1'
      				       OR (BID_STATUS = '3' AND to_char(BID_END_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD'))
      				       UNION
      				       SELECT PL_NO as pl_no, UNIT_PRICE  as bid_unit_price
      				       FROM TBL_BID_REPORT
      				       WHERE to_char(REG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD')
      				       UNION
					           SELECT UNIT_LOG_PL_NO as pl_no, UNIT_LOG_PRICE  as bid_unit_price
          					 FROM TBL_BID_UNIT_LOG
					           WHERE (UNIT_LOG_STATUS = '1' OR UNIT_LOG_STATUS = '2')
          					 AND to_char(UNIT_LOG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD')
                    ) LOOP
      BEGIN
        v_bid_possess_money := 0;
        v_bid_total_view := 0;
        v_bid_valid_view := 0;
        v_bid_unit_price := 0;
        v_add_service_cnt := 0;
        v_bid_cnt := 0;
        v_service_cnt := 0;
        v_bid_total_click := 0;
        v_bid_valid_click := 0;

        FOR tmp_loop2 in (SELECT DEDUCTION_IDX
                               , PL_NO
                               , BID_UNIT_PRICE
                               , BID_ALL_PRICE
                               , CASH_TYPE
                          FROM TBL_BID_DEDUCTION
                          WHERE DEDUCTION_TYPE='1'
                          AND DEDUCTION_SEARCH_DATE = to_char(sysdate-1,'YYYYMMDD')
                          AND PL_NO = tmp_loop.pl_no
                          AND BID_UNIT_PRICE = tmp_loop.bid_unit_price
                          ORDER BY DEDUCTION_IDX
                        ) LOOP

            BEGIN
                  -- 금일 소진액
                  v_bid_possess_money := v_bid_possess_money + (tmp_loop2.cash_type * tmp_loop2.bid_unit_price);

                  -- 총 노출수
                  v_bid_total_view := v_bid_total_view + 1;

                  -- 유효 노출수
                  v_bid_valid_view := v_bid_valid_view + tmp_loop2.cash_type;

                  -- 단가
                  IF v_bid_unit_price < tmp_loop2.bid_unit_price THEN
                     v_bid_unit_price := tmp_loop2.bid_unit_price;
                  END IF;

                  -- 입찰 총 비용
                  v_bid_all_price := tmp_loop2.bid_all_price;

                  EXCEPTION WHEN OTHERS THEN
                  COMMIT;

            END;

        END LOOP;

        -- 총 클릭수
        SELECT COUNT(CASE WHEN DEDUCTION_TYPE = '2' THEN CUSTOMER_IP END) INTO v_bid_total_click
        FROM TBL_BID_DEDUCTION
        WHERE pl_no = tmp_loop.pl_no
        AND bid_unit_price = tmp_loop.bid_unit_price
        AND deduction_search_date = to_char(sysdate-1,'YYYYMMDD');

        -- 유효 클릭수
        SELECT COUNT(DISTINCT CASE WHEN DEDUCTION_TYPE = '2' THEN CUSTOMER_IP END) INTO v_bid_valid_click
        FROM TBL_BID_DEDUCTION
        WHERE pl_no = tmp_loop.pl_no
        AND bid_unit_price = tmp_loop.bid_unit_price
        AND deduction_search_date = to_char(sysdate-1,'YYYYMMDD');

        -- 지난 총 소진금액 구하기
        SELECT NVL(SUM(bid_possess_money),0) bid_possess_money INTO v_before_bid_possess_money
        FROM TBL_BID_DAILY
        WHERE pl_no = tmp_loop.pl_no
        AND bid_unit_price = tmp_loop.bid_unit_price;

        -- 잔액 구하기
        v_bid_exhaustion_money := 0;
        v_bid_exhaustion_money := v_bid_all_price - (v_before_bid_possess_money + v_bid_possess_money);

        IF v_bid_exhaustion_money < 0 THEN --잔액이 0 보다 작아지면 0 으로..
           v_bid_exhaustion_money := 0;
        END IF;

        -- 분류코드, 모델넘버 구하기
        BEGIN

          SELECT a.ca_code,a.modelno INTO v_ca_code,v_modelno FROM TBL_GOODS a, TBL_PRICELIST b
          WHERE b.pl_no = tmp_loop.pl_no
          AND b.modelno=a.modelno
          AND a.cateflag='0';

          EXCEPTION WHEN NO_DATA_FOUND THEN
            v_ca_code := '0';
            v_modelno := 0 ;
        END;


        -- 입찰수 구하기
        SELECT COUNT(CASE WHEN (BID_TYPE = 'U' OR BID_TYPE = 'I') THEN LOG_IDX END) INTO v_bid_cnt
        FROM TBL_BID_LOG
        WHERE to_char(BID_REG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD')
        AND BID_UNIT_PRICE = tmp_loop.bid_unit_price
        AND PL_NO = tmp_loop.pl_no;

        -- 서비스수 구하기
        SELECT  COUNT(CASE WHEN (UNIT_LOG_STATUS = '1') THEN UNIT_LOG_IDX END) INTO v_service_cnt
        FROM TBL_BID_UNIT_LOG
        WHERE to_char(UNIT_LOG_DATE,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD')
        AND unit_log_price = tmp_loop.bid_unit_price
        AND unit_log_pl_no = tmp_loop.pl_no;

        v_no := v_no + 1;

				INSERT INTO TBL_BID_DAILY(bid_daily_no, bid_date, pl_no, ca_code, modelno, bid_valid_view, bid_total_view, bid_possess_money, bid_all_money, bid_exhaustion_money, bid_unit_price, bid_cnt, service_cnt, bid_total_click, bid_valid_click)
			  VALUES(v_no, to_char(sysdate-1,'YYYYMMDD'), tmp_loop.pl_no, v_ca_code, v_modelno, v_bid_valid_view, v_bid_total_view, v_bid_possess_money, v_bid_all_price,v_bid_exhaustion_money, v_bid_unit_price, v_bid_cnt, v_service_cnt, v_bid_total_click, v_bid_valid_click);

        i_count := i_count + 1;

 	   END;
     
    IF i_count = 100 THEN
      COMMIT;
      i_count := 0;
    END IF;

  END LOOP;

  COMMIT;

  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_BID_SCHEDULE','END');
  COMMIT;
    
END UDP_BID_SCHEDULE;

--------------------------------------------------;