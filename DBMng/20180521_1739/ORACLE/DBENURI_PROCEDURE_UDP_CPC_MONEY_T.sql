/* *************************************************************************
 * NAME : DBENURI.UDP_CPC_MONEY_T
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CPC_MONEY_T" 
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
 
 v_model_cpc_cnt    NUMBER(8) := 0;


BEGIN
 DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_CPC_MONEY start ......');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_MONEY_T','START');
    COMMIT;

 --==========================================================================================
 --기존 집계 데이타 삭제
 --==========================================================================================
 DELETE /*+ append nologging */  TBL_CPC_CLICK_LOG_ENABLE
 WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
 AND regdate < to_char(sysdate,'yyyymmdd')
 AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2');

 DELETE /*+ append nologging */  TBL_CPC_DAILY_ACC
 WHERE accdate >= to_char(sysdate-1,'yyyymmdd')
 AND accdate < to_char(sysdate,'yyyymmdd')
 AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2');

 --=========================================================================================
 -- CPC 과금 로그 데이타 등록
 --=========================================================================================
 FOR tmp_loop in (
   SELECT shop_code,pl_no,min(seq) seq,NVL(count(*),0) excnt
   FROM TBL_CPC_CLICK_LOG
   WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
   --AND pl_no in (164257030,152129143)
   AND regdate < to_char(sysdate,'yyyymmdd')
   AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2')
   GROUP BY shop_code,pl_no,ip,tempid
 ) LOOP

    SELECT shop_code,pl_no,seq,modelno,ca_code,price,ip,tempid,browser,regdate
    INTO v_shop_code,v_pl_no,v_seq,v_modelno,v_ca_code,v_price,v_ip,v_tempid,v_browser,v_regdatetime
    FROM TBL_CPC_CLICK_LOG
    WHERE shop_code=tmp_loop.shop_code
    AND pl_no=tmp_loop.pl_no
    AND seq=tmp_loop.seq;

    v_incharge :=150;

    BEGIN
        SELECT tr_goodsubname INTO v_goodsnm FROM TBL_TOUR_GOODSUB WHERE MODEL_SUBNO=tmp_loop.pl_no;
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
    SELECT shop_code,pl_no,max(modelno) modelno,max(ca_code) ca_code,max(price) price,max(goodsnm) goodsnm FROM TBL_CPC_CLICK_LOG_ENABLE
        WHERE regdate >= to_char(sysdate-1,'yyyymmdd')
        AND regdate < to_char(sysdate,'yyyymmdd')
        AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2')
        --AND PL_NO > 0    
        GROUP BY shop_code,pl_no
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
  AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2');

  FOR tmp_loop in (SELECT shop_code,ca_code,sum(incnt) incnt,sum(realcnt) realcnt,sum(incharge) incharge,sum(excnt) excnt,
    sum(excharge) excharge,sum(md_hit) md_hit FROM TBL_CPC_DAILY_ACC 
    WHERE accdate = to_char(sysdate-1,'yyyymmdd') 
    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2')
    GROUP BY shop_code,ca_code) LOOP

    --BEGIN
    --    SELECT NVL(sum(md_hit),0) md_hit INTO v_md_hit
    --    FROM TBL_CPC_MODEL_DHIT
    --    WHERE accdate=to_char(sysdate-1,'yyyymmdd')
    --    AND MODELNO IN
    --        (SELECT DISTINCT MODELNO FROM TBL_CPC_DAILY_ACC
    --            WHERE ACCDATE=to_char(sysdate-1,'yyyymmdd')
    --            AND CA_CODE=tmp_loop.shop_code
    --            AND SHOP_CODE=tmp_loop.shop_code
    --            AND MODELNO > 0);
    --EXCEPTION WHEN OTHERS THEN
    --    v_md_hit := 0;
    --END;


    INSERT /*+ append nologging */ INTO TBL_CPC_DAILY_SUM(shop_code,accdate,ca_code,realcnt,incnt,incharge,excnt,excharge,md_hit)
    VALUES(tmp_loop.shop_code,to_char(sysdate-1,'yyyymmdd'),tmp_loop.ca_code,tmp_loop.realcnt,tmp_loop.incnt,tmp_loop.incharge,
    tmp_loop.excnt,tmp_loop.excharge,tmp_loop.md_hit);

  END LOOP;
  COMMIT;
  
   --=======================================================================
  --일별 정산금액에 기록
  --========================================================================
  FOR tmp_loop in (SELECT shop_code, NVL(sum(incharge),0) cpc_money FROM TBL_CPC_DAILY_ACC 
                    WHERE accdate = to_char(sysdate-1,'yyyymmdd') 
                    AND shop_code IN (SELECT shop_code FROM TBL_SHOPLIST WHERE cpc_flag='2' AND shop_code in (6010,5942,6026))
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
            
    v_cpc_money := v_cpc_money - tmp_loop.cpc_money; 
    
    UPDATE TBL_SHOPLIST
    SET cpc_money=v_cpc_money
    WHERE shop_code=tmp_loop.shop_code;

    DELETE /*+ append nologging */ TBL_CPC_SHOPLIST_HISTORY
    WHERE shop_code = tmp_loop.shop_code
    AND accdate = to_char(sysdate-1,'yyyymmdd');

    INSERT /*+ append nologging */ INTO TBL_CPC_SHOPLIST_HISTORY(shop_code,accdate,service,cpc_money)
    VALUES(tmp_loop.shop_code,to_char(sysdate-1,'yyyymmdd'),v_service,v_cpc_money);

    COMMIT;

    --DELETE /*+ append nologging */ TBL_CPC_MODEL_DHIT
    --WHERE accdate < to_char(sysdate-8,'yyyymmdd');

    COMMIT;

  END LOOP;
  --=============================================================================================
  --마스타상품 클릭수 집계
  
  FOR tmp_loop in (SELECT shop_code,modelno FROM TBL_TOUR_GOODS WHERE TR_DEL_FLAG='0') LOOP

    BEGIN
        SELECT NVL(sum(realcnt),0) realcnt INTO v_model_cpc_cnt
        FROM TBL_CPC_DAILY_ACC
        WHERE PL_NO IN
            (SELECT MODEL_SUBNO FROM TBL_TOUR_GOODSUB
             WHERE MODELNO=tmp_loop.modelno)
        AND ACCDATE >= TO_CHAR(sysdate-7,'YYYYMMDD')
        AND SHOP_CODE=tmp_loop.shop_code;
    EXCEPTION WHEN OTHERS THEN
        v_model_cpc_cnt := 0;
    END;

    UPDATE TBL_TOUR_GOODS SET TR_CPC_COUNT=v_model_cpc_cnt WHERE MODELNO=tmp_loop.modelno;

  END LOOP;
  COMMIT;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CPC_MONEY_T','END');
    COMMIT;
        
END UDP_CPC_MONEY_T;