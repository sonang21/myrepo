/* *************************************************************************
 * NAME : DBENURI.UDP_CPC_MONEY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 15:09:25
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CPC_MONEY" 
IS
/*
 NGIT 체크 - 변경없음 김영원 20180424
*/

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
 v_tmp_cnt  NUMBER(8) := 0;
 v_md_hit    NUMBER(8) := 0;
 
 i_count      NUMBER := 0;

BEGIN
 DBMS_OUTPUT.ENABLE;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_MONEY','START');
    COMMIT;
    
    i_count := 0;
    
 SELECT MAX(sdate) sdate INTO v_sdate
 FROM TBL_CPC_CHARGE_RATE
 WHERE sdate <= to_char(sysdate,'yyyymmdd');
 --=========================================================================================
 -- CPC 과금 기준 테이블
 --=========================================================================================
 FOR tmp_loop in (SELECT seq,eprice,ratio FROM TBL_CPC_CHARGE_RATE WHERE SDATE=v_sdate order by seq) LOOP
    IF tmp_loop.seq = 1 THEN
        v_eprice1 := tmp_loop.eprice;
        v_ratio1 := tmp_loop.ratio;
    END IF;
    IF tmp_loop.seq = 2 THEN
        v_eprice2 := tmp_loop.eprice;
        v_ratio2 := tmp_loop.ratio;
    END IF;
    IF tmp_loop.seq = 3 THEN
        v_eprice3 := tmp_loop.eprice;
        v_ratio3 := tmp_loop.ratio;
    END IF;
    IF tmp_loop.seq = 4 THEN
        v_eprice4 := tmp_loop.eprice;
        v_ratio4 := tmp_loop.ratio;
    END IF;
 END LOOP;

 --==========================================================================================
 --기존 집계 데이타 삭제
 --==========================================================================================
 DELETE /*+ append nologging */  TBL_CPC_CLICK_LOG_ENABLE
 WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
 AND regdate < to_char(sysdate,'yyyymmdd')
 AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1');

 DELETE /*+ append nologging */  TBL_CPC_DAILY_ACC
 WHERE accdate >= to_char(sysdate-1,'yyyymmdd')
 AND accdate < to_char(sysdate,'yyyymmdd')
 AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1');

 --=========================================================================================
 -- CPC 과금 로그 데이타 등록
 --=========================================================================================
 FOR tmp_loop in (
   SELECT shop_code,pl_no,min(seq) seq,NVL(count(*),0) excnt
   FROM TBL_CPC_CLICK_LOG
   WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
   --AND pl_no in (164257030,152129143)
   AND regdate < to_char(sysdate,'yyyymmdd')
   AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1' AND SERVICE='0')
   GROUP BY shop_code,pl_no,ip,tempid
 ) LOOP

    SELECT shop_code,pl_no,seq,modelno,ca_code,price,ip,tempid,browser,regdate
    INTO v_shop_code,v_pl_no,v_seq,v_modelno,v_ca_code,v_price,v_ip,v_tempid,v_browser,v_regdatetime
    FROM TBL_CPC_CLICK_LOG
    WHERE shop_code=tmp_loop.shop_code
    AND pl_no=tmp_loop.pl_no
    AND seq=tmp_loop.seq;

    v_incharge :=0;

    IF v_price < v_eprice1 THEN
      v_incharge := v_price * (v_ratio1/100);
    END IF;
    IF v_price >= v_eprice1 AND v_price < v_eprice2 THEN
      v_incharge := v_eprice1 * (v_ratio1/100);
      v_incharge := v_incharge + ((v_price - v_eprice1) * (v_ratio2/100));
    END IF;
    IF v_price >= v_eprice2 AND v_price < v_eprice3 THEN
      v_incharge := v_eprice1 * (v_ratio1/100);
      --DBMS_OUTPUT.PUT_LINE('1-1......' || v_incharge);
      v_incharge := v_incharge + ((v_eprice2 - v_eprice1) * (v_ratio2/100));
      --DBMS_OUTPUT.PUT_LINE('2-1......' || v_incharge || '--' || (v_eprice2 - v_eprice1));
      v_incharge := v_incharge + ((v_price - v_eprice2) * (v_ratio3/100));
      --DBMS_OUTPUT.PUT_LINE('2-2......' || v_incharge || '--' || (v_price - v_eprice2 - v_eprice1));
    END IF;
    IF v_price >= v_eprice3 AND v_price < v_eprice4 THEN
      v_incharge := v_eprice1 * (v_ratio1/100);
      --DBMS_OUTPUT.PUT_LINE('1......' || v_incharge);
      v_incharge := v_incharge + ((v_eprice2 - v_eprice1) * (v_ratio2/100));
      --DBMS_OUTPUT.PUT_LINE('2......' || v_incharge || '--' || (v_eprice2 - v_eprice1));
      v_incharge := v_incharge + ((v_eprice3 - v_eprice2) * (v_ratio3/100));
      --DBMS_OUTPUT.PUT_LINE('3......' || v_incharge || '--' || (v_eprice3 - v_eprice2 - v_eprice1));
      v_incharge := v_incharge + ((v_price - v_eprice3) * (v_ratio4/100));
      --DBMS_OUTPUT.PUT_LINE('4......' || v_incharge || '--' || (v_price - v_eprice3));
    END IF;
    IF v_price >= v_eprice4 THEN
      v_price := v_eprice4;
      v_incharge := v_eprice1 * (v_ratio1/100);
      v_incharge := v_incharge + ((v_eprice2 - v_eprice1) * (v_ratio2/100));
      v_incharge := v_incharge + ((v_eprice3 - v_eprice2) * (v_ratio3/100));
      v_incharge := v_incharge + ((v_eprice4 - v_eprice3) * (v_ratio4/100));
    END IF;

    BEGIN
        SELECT goodsnm INTO v_goodsnm FROM TBL_PRICELIST WHERE PL_NO=tmp_loop.pl_no;
    EXCEPTION WHEN OTHERS THEN
        v_goodsnm :='';
    END;

    INSERT /*+ append nologging */ INTO TBL_CPC_CLICK_LOG_ENABLE(shop_code,pl_no,seq,modelno,ca_code,price,ip,tempid,browser,regdate,incharge,goodsnm,excnt)
    VALUES(v_shop_code,v_pl_no,v_seq,v_modelno,v_ca_code,v_price,v_ip,v_tempid,v_browser,v_regdatetime,v_incharge,v_goodsnm,tmp_loop.excnt);


 END LOOP;
 COMMIT;
  --=======================================================================
  --업체별 일자별 CPC LOG 계산
  --=======================================================================

  FOR tmp_loop in (
    SELECT shop_code,pl_no,MAX(modelno) modelno,MAX(ca_code) ca_code,MAX(price) price,MAX(goodsnm) goodsnm FROM(
	SELECT shop_code,pl_no,modelno,ca_code,price,goodsnm FROM TBL_PRICELIST
        WHERE
            (SHOP_CODE IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
            AND status='0' AND srvflag='0')
	union
    SELECT DISTINCT shop_code,pl_no,modelno,ca_code,price,goodsnm FROM TBL_CPC_CLICK_LOG_ENABLE
        WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
        AND regdate < to_char(sysdate,'yyyymmdd')
        AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
        AND PL_NO > 0
    ) GROUP BY shop_code,pl_no
  ) LOOP

    BEGIN
        SELECT NVL(COUNT(*),0) realcnt, NVL(SUM(incharge),0),
           to_char(MIN(regdate),'yyyymmdd') regdate, MIN(regdate) acctime
        INTO v_realcnt,v_incharge,v_regdate,v_acctime
        FROM TBL_CPC_CLICK_LOG_ENABLE
        WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
        AND regdate < to_char(sysdate,'yyyymmdd')
        AND PL_NO=tmp_loop.PL_NO
        AND SHOP_CODE=tmp_loop.SHOP_CODE
        GROUP BY shop_code,pl_no;
    EXCEPTION WHEN OTHERS THEN
        v_incharge := 0;
        v_realcnt := 0;
        v_regdate := to_char(sysdate-1,'yyyymmdd');
        v_acctime := sysdate-1;
    END;
    --DBMS_OUTPUT.PUT_LINE('2..v_incharge....' || v_incharge);
    BEGIN
        SELECT NVL(COUNT(*),0) into v_excnt
            FROM TBL_CPC_CLICK_LOG
            WHERE shop_code=tmp_loop.shop_code
            AND pl_no=tmp_loop.pl_no
            AND regdate >= to_char(sysdate-1,'yyyymmdd')
            AND regdate < to_char(sysdate,'yyyymmdd');
    EXCEPTION WHEN OTHERS THEN
        v_excnt := 0;
    END;

    v_md_hit :=0;
    --DBMS_OUTPUT.PUT_LINE('tmp_loop.modelno....' || tmp_loop.modelno);
    IF tmp_loop.modelno > 0 THEN
        BEGIN
            SELECT NVL(md_hit,0) into v_md_hit
                FROM TBL_CPC_MODEL_DHIT
                WHERE modelno = tmp_loop.modelno
                AND accdate = to_char(sysdate-1,'yyyymmdd');
        EXCEPTION WHEN OTHERS THEN
             v_md_hit := 0;
        END;
     ELSE
        BEGIN
            SELECT NVL(COUNT(*),0) into v_md_hit
            FROM TBL_CPC_CLICK_LOG
            WHERE pl_no = tmp_loop.pl_no
            AND shop_code=tmp_loop.shop_code
            AND regdate BETWEEN to_char(sysdate-1,'yyyymmdd') AND to_char(sysdate,'yyyymmdd');
        EXCEPTION WHEN OTHERS THEN
            v_md_hit := 0;
        END;
        --DBMS_OUTPUT.PUT_LINE('v_md_hit....' || v_md_hit);
    END IF;

    IF v_md_hit < v_excnt then
        v_md_hit := v_excnt * 1.3;
    END IF;

    v_shop_code :=tmp_loop.shop_code;
    v_pl_no :=tmp_loop.pl_no;
    v_modelno :=tmp_loop.modelno;
    v_ca_code :=tmp_loop.ca_code;
    v_price :=tmp_loop.price;
    v_goodsnm :=tmp_loop.goodsnm;

    --===============================================================================================
    --상품별 일주일 클릭수
    --===============================================================================================
    SELECT NVL(count(distinct accdate),0),NVL(AVG(incnt),0) incnt into v_tmp_cnt,v_avgcnt
    FROM TBL_CPC_DAILY_ACC
    WHERE accdate >= to_char(sysdate-8,'yyyymmdd') AND accdate < to_char(sysdate-1,'yyyymmdd')
    AND shop_code=v_shop_code
    AND pl_no=v_pl_no;

    v_incnt := v_realcnt;
    --DBMS_OUTPUT.PUT_LINE('3...v_incharge...' || v_incharge);
    IF v_realcnt > 0 THEN

        IF v_tmp_cnt = 7 THEN
            IF v_avgcnt >= 100 THEN
              v_avgcnt := v_avgcnt * 1.5;
            END IF;

            IF v_avgcnt >= 51 AND v_avgcnt < 100 THEN
              v_avgcnt := v_avgcnt * 2;
            END IF;

            IF v_avgcnt >= 21 AND v_avgcnt < 50 THEN
              v_avgcnt := v_avgcnt * 2.5;
            END IF;

            IF v_avgcnt >= 11 AND v_avgcnt < 20 THEN
              v_avgcnt := v_avgcnt * 3;
            END IF;

            IF v_avgcnt >= 0 AND v_avgcnt < 10 THEN
              v_avgcnt := v_avgcnt * 3.5;
            END IF;

            IF v_realcnt > v_avgcnt AND v_avgcnt > 0 THEN
              v_incnt := v_avgcnt;
            ELSE
              v_incnt := v_realcnt;
            END IF;
            
        END IF;

    END IF;
    --DBMS_OUTPUT.PUT_LINE('4...v_incharge...' || v_incharge);

    INSERT /*+ append nologging */ INTO TBL_CPC_DAILY_ACC (shop_code,pl_no,accdate,acctime,goodsnm,ca_code,realcnt,incnt,avgcnt,incharge,excnt,excharge,price,modelno,md_hit)
    VALUES(v_shop_code,v_pl_no,v_regdate,v_acctime,v_goodsnm,v_ca_code,v_realcnt,v_incnt,v_avgcnt,v_incharge,v_excnt,0,v_price,v_modelno,v_md_hit);

  END LOOP;
  COMMIT;

  --=======================================================================
  --일별 집계 테이블 생성
  --=======================================================================
  DELETE TBL_CPC_DAILY_SUM
  WHERE accdate = to_char(sysdate-1,'yyyymmdd')
  AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1');

  FOR tmp_loop in (SELECT shop_code,NVL(ca_code,'00000000') ca_code,sum(incnt) incnt,sum(realcnt) realcnt,sum(incharge) incharge,sum(excnt) excnt,
    sum(excharge) excharge,sum(md_hit) md_hit FROM TBL_CPC_DAILY_ACC 
    WHERE accdate = to_char(sysdate-1,'yyyymmdd') 
    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
    GROUP BY shop_code,ca_code) LOOP

    INSERT /*+ append nologging */ INTO TBL_CPC_DAILY_SUM(shop_code,accdate,ca_code,realcnt,incnt,incharge,excnt,excharge,md_hit)
    VALUES(tmp_loop.shop_code,to_char(sysdate-1,'yyyymmdd'),tmp_loop.ca_code,tmp_loop.realcnt,tmp_loop.incnt,tmp_loop.incharge,
    tmp_loop.excnt,tmp_loop.excharge,tmp_loop.md_hit);

  END LOOP;
  COMMIT;
  --=======================================================================
  --일별 정산금액에 기록
  --=======================================================================
  FOR tmp_loop in (SELECT shop_code, NVL(sum(incharge),0) cpc_money FROM TBL_CPC_DAILY_ACC 
                    WHERE accdate = to_char(sysdate-1,'yyyymmdd') 
                    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='1')
                    GROUP BY shop_code) LOOP
    

    BEGIN
        SELECT NVL(cpc_money,0) cpc_money INTO v_cpc_money
        FROM TBL_CPC_SHOPLIST_HISTORY
        WHERE shop_code = tmp_loop.shop_code
        AND accdate = to_char(sysdate-2,'yyyymmdd');
      EXCEPTION WHEN OTHERS THEN
        -- 이전 히스토리가 없을 경우 SHOP_LIST 의 CPC_MONEY 의 데이타 등록
        INSERT /*+ append nologging */ INTO TBL_CPC_SHOPLIST_HISTORY(shop_code,accdate,service,cpc_money)
        VALUES(tmp_loop.shop_code,to_char(sysdate-2,'yyyymmdd'),v_service,(SELECT NVL(cpc_money,0) FROM TBL_SHOPLIST WHERE shop_code=tmp_loop.shop_code));
        
        SELECT NVL(cpc_money,0) cpc_money  INTO v_cpc_money
        FROM TBL_SHOPLIST
        WHERE shop_code = tmp_loop.shop_code;
    END;
    
    IF v_cpc_money > 0 THEN
        v_service := '0';
    ELSE
        v_service := '1';
    END IF;
        
    v_cpc_money := v_cpc_money - tmp_loop.cpc_money; 

     BEGIN
      UPDATE TBL_SHOPLIST
      SET cpc_money=v_cpc_money
      WHERE shop_code=tmp_loop.shop_code;
  
      DELETE /*+ append nologging */ TBL_CPC_SHOPLIST_HISTORY
      WHERE shop_code = tmp_loop.shop_code
      AND accdate = to_char(sysdate-1,'yyyymmdd');
  
      INSERT /*+ append nologging */ INTO TBL_CPC_SHOPLIST_HISTORY(shop_code,accdate,service,cpc_money)
      VALUES(tmp_loop.shop_code,to_char(sysdate-1,'yyyymmdd'),v_service,v_cpc_money);
      
       EXCEPTION WHEN OTHERS THEN
       COMMIT;
       
       i_count := i_count + 1;
    END;
    
    IF i_count = 10 THEN
      COMMIT;
      i_count := 0;
    END IF;

  END LOOP;

  COMMIT;
  
  DELETE /*+ append nologging */ TBL_CPC_MODEL_DHIT
  WHERE accdate < to_char(sysdate-8,'yyyymmdd');
  COMMIT;
 
  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_MONEY','END');
  COMMIT;
    
END UDP_CPC_MONEY;
