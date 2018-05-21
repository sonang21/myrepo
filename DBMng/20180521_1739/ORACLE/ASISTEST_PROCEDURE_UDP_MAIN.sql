/* *************************************************************************
 * NAME : ASISTEST.UDP_MAIN
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:26
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_MAIN" (
     result_code OUT VARCHAR2,
     result_desc OUT VARCHAR2,
     startTime   OUT VARCHAR2,
     endTime     OUT VARCHAR2)
IS
 	tmp_start     VARCHAR2(100) := '';
 	tmp_end       VARCHAR2(100) := '';
  tmp_week      NUMBER(1) := 0;
  tmp_cur_day   CHAR(1) := '';
 	tmp_ca_lcode  VARCHAR2(100) := '';
BEGIN

  EXECUTE IMMEDIATE ('PURGE RECYCLEBIN');
  EXECUTE IMMEDIATE ('alter session enable parallel dml');

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_MAIN', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'START'
    FROM DUAL;
    COMMIT;


  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
    FROM DUAL;

 --첫번째 프로시저
 --검색관련 pricelist_popular 추가 시작(일요일만 실행)
 --select to_char(sysdate,'yyyymmdd') - to_char(next_day(sysdate,'SUNDAY'),'yyyymmdd') into tmp_week FROM DUAL;
 select to_char(next_day(sysdate,1) - sysdate) into tmp_week FROM DUAL;

 dbms_scheduler.run_job('SJ_GOODS_ALLNEW_PACK', false);


/*
 
 BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'09');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;

 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'14');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;


 
 BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'02');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
 BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'03');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'04');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'05');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'06');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'07');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'08');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'10');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'12');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'15');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'16');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'18');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'21');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'22');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'24');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 
  BEGIN
   UDP_GOODS_ALLNEW4(result_code, result_desc, startTime, endTime,'93');
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '|' || SQLCODE;
   result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR';
 END;
 

 BEGIN
 
     -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'START'
    FROM DUAL;
    COMMIT;

  --네번째 프로시저(1시간 30분)
   UDP_SUM_POPULAR(0, 'handphone', result_code, result_desc, startTime, endTime);
   
    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END'
    FROM DUAL;
    COMMIT;
    
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '' || SQLCODE;
   result_desc := result_desc || 'UDP_SUM_POPULAR => ERROR';
   
    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    FROM DUAL;
    COMMIT;
    
 END;

*/
 IF result_code = '' THEN
  result_code := '0';
 END IF;

 IF result_desc = '' THEN
  result_desc := 'UDP_MAIN => SUCCESS';
 END IF;

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;

-- SYS_LOG
INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
SELECT 'UDP_MAIN', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END'
FROM DUAL;
COMMIT;


 EXCEPTION
     WHEN OTHERS THEN
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
          INTO tmp_end
          FROM DUAL;

    IF result_code = '' THEN
         result_code := '' || SQLCODE;
        ELSE
         result_code := result_code || '|' || SQLCODE;
        END IF;

        IF result_desc = '' THEN
         result_desc := 'UDP_MAIN => ERROR';
        ELSE
         result_desc := result_desc || '|' || 'UDP_MAIN => ERROR';
        END IF;
        
 -- SYS_LOG
INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
SELECT 'UDP_MAIN', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
FROM DUAL;
COMMIT;

END;