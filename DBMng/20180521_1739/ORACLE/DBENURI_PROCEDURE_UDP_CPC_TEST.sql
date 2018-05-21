/* *************************************************************************
 * NAME : DBENURI.UDP_CPC_TEST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CPC_TEST" 
IS

 v_shop_code tbl_shoplist.shop_code%TYPE := 0;
 v_cpc_money tbl_shoplist.cpc_money%TYPE := 0;

 v_sdate    tbl_cpc_charge_rate.sdate%TYPE := '';
 v_eprice1  tbl_cpc_charge_rate.eprice%TYPE := 0;
 v_ratio1   tbl_cpc_charge_rate.ratio%TYPE := 0;
 v_eprice2  tbl_cpc_charge_rate.eprice%TYPE := 0;
 v_ratio2   tbl_cpc_charge_rate.ratio%TYPE := 0;
 v_eprice3  tbl_cpc_charge_rate.eprice%TYPE := 0;
 v_ratio3   tbl_cpc_charge_rate.ratio%TYPE := 0;
 v_eprice4  tbl_cpc_charge_rate.eprice%TYPE := 0;
 v_ratio4   tbl_cpc_charge_rate.ratio%TYPE := 0;
 v_seq      tbl_cpc_click_log.seq%TYPE := 0;
 v_pl_no    tbl_cpc_click_log.pl_no%TYPE := 0;
 v_tempid   tbl_cpc_click_log.tempid%TYPE := '';
 v_ip       tbl_cpc_click_log.ip%TYPE := '';
 v_modelno  tbl_cpc_click_log.modelno%TYPE := 0;
 v_ca_code  tbl_cpc_click_log.ca_code%TYPE := '';
 v_goodsnm  tbl_pricelist.goodsnm%TYPE := '';
 v_price    tbl_cpc_click_log.price%TYPE := 0;
 v_acctime  tbl_cpc_click_log.regdate%TYPE := sysdate;
 v_browser  tbl_cpc_click_log.browser%TYPE := '';
 v_service  CHAR(1) := '';

 v_regdate  VARCHAR2(8) := '';
 v_regdatetime  tbl_cpc_click_log.regdate%TYPE := sysdate;
 v_incharge   NUMBER(10) := 0;
 v_incnt    NUMBER(8) := 0;
 v_realcnt  NUMBER(8) := 0;
 v_avgcnt  NUMBER(8) := 0;
 v_excnt    NUMBER(8) := 0;
 v_charge_rate_cnt    NUMBER(8) := 0;

 v_tmp_shop_incnt  NUMBER(8) := 0;
 v_tmp_cnt  NUMBER(8) := 0;
 v_md_hit    NUMBER(8) := 0;


BEGIN
 DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_CPC_MONEY start ......');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_TEST','START');
    COMMIT;
    
  --=======================================================================
  --일별 집계 테이블 생성
  --=======================================================================
  DELETE TBL_CPC_DAILY_SUM
  WHERE accdate > '20081026'
  AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1');

  FOR tmp_loop in (SELECT accdate,shop_code,NVL(ca_code,'00000000') ca_code,sum(incnt) incnt,sum(realcnt) realcnt,sum(incharge) incharge,sum(excnt) excnt,
    sum(excharge) excharge,sum(md_hit) md_hit FROM TBL_CPC_DAILY_ACC 
    --WHERE accdate = to_char(sysdate-1,'yyyymmdd') 
    WHERE accdate > '20081026'
    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
    GROUP BY shop_code,ca_code,accdate) LOOP


    INSERT /*+ append nologging */ INTO TBL_CPC_DAILY_SUM(shop_code,accdate,ca_code,realcnt,incnt,incharge,excnt,excharge,md_hit)
    VALUES(tmp_loop.shop_code,tmp_loop.accdate,tmp_loop.ca_code,tmp_loop.realcnt,tmp_loop.incnt,tmp_loop.incharge,
    tmp_loop.excnt,tmp_loop.excharge,tmp_loop.md_hit);

  END LOOP;
  COMMIT;
 
 --=======================================================================
  --일별 정산금액에 기록
  --=======================================================================
  FOR tmp_loop in (SELECT accdate,shop_code, NVL(sum(incharge),0) cpc_money FROM TBL_CPC_DAILY_ACC 
                    WHERE accdate > '20081026'
                    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
                    GROUP BY shop_code,accdate
                    ORDER BY accdate) LOOP
    

    BEGIN
        SELECT NVL(cpc_money,0) cpc_money INTO v_cpc_money
        FROM TBL_CPC_SHOPLIST_HISTORY
        WHERE shop_code = tmp_loop.shop_code
        AND accdate = to_char(to_date(tmp_loop.accdate,'yyyymmdd')-2,'yyyymmdd');
    EXCEPTION WHEN OTHERS THEN
        -- 이전 히스토리가 없을 경우 SHOP_LIST 의 CPC_MONEY 의 데이타 등록
        INSERT /*+ append nologging */ INTO TBL_CPC_SHOPLIST_HISTORY(shop_code,accdate,service,cpc_money)
        VALUES(tmp_loop.shop_code,to_char(to_date(tmp_loop.accdate,'yyyymmdd')-2,'yyyymmdd'),v_service,(SELECT NVL(cpc_money,0) FROM TBL_SHOPLIST WHERE shop_code=tmp_loop.shop_code));
        
        SELECT NVL(cpc_money,0) cpc_money  INTO v_cpc_money
        FROM TBL_SHOPLIST
        WHERE shop_code = tmp_loop.shop_code;
    END;
    --v_cpc_money := v_cpc_money + tmp_loop.cpc_money;
    
    IF v_cpc_money > 0 THEN
        v_service := '0';
    ELSE
        v_service := '1';
    END IF;
        
    v_cpc_money := v_cpc_money - tmp_loop.cpc_money; 

    --UPDATE TBL_SHOPLIST
    --SET service='1',cpc_money=v_cpc_money
    --WHERE shop_code=tmp_loop.shop_code;
    
    UPDATE TBL_SHOPLIST
    SET cpc_money=v_cpc_money
    WHERE shop_code=tmp_loop.shop_code;

    DELETE /*+ append nologging */ TBL_CPC_SHOPLIST_HISTORY
    WHERE shop_code = tmp_loop.shop_code
    AND accdate = to_char(to_date(tmp_loop.accdate,'yyyymmdd')-1,'yyyymmdd');

    INSERT /*+ append nologging */ INTO TBL_CPC_SHOPLIST_HISTORY(shop_code,accdate,service,cpc_money)
    VALUES(tmp_loop.shop_code,to_char(to_date(tmp_loop.accdate,'yyyymmdd')-1,'yyyymmdd'),v_service,v_cpc_money);

    COMMIT;

  END LOOP;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_TEST','END');
    COMMIT;
    
END UDP_CPC_TEST;