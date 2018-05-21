/* *************************************************************************
 * NAME : DBADM.UP_MIG_JOB_RUNS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-18 12:29:25
 *        Modify: 2018-04-18 12:54:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBADM"."UP_MIG_JOB_RUNS" (P_RUN_GROUP VARCHAR2, P_LOG_GROUP VARCHAR2)
AUTHID CURRENT_USER
IS
  V_RUN_GROUP   VARCHAR2(100) := 'ST1%';
  V_LOG_GROUP   DBADM.TB_MIG_LOG.LOG_GROUP%TYPE;
  
  V_JOB_ID      DBADM.TB_MIG_JOBS.JOB_ID%TYPE;
  V_JOB_NM      DBADM.TB_MIG_JOBS.JOB_NM%TYPE;
  V_JOB_GROUP   DBADM.TB_MIG_JOBS.JOB_GROUP%TYPE;
  V_JOB_TYPE    DBADM.TB_MIG_JOBS.JOB_TYPE%TYPE;
  V_JOB_DESC    DBADM.TB_MIG_JOBS.JOB_DESC%TYPE;
  V_TARGET_TBL  DBADM.TB_MIG_JOBS.TARGET_TBL%TYPE;
  V_SOURCE_TBL  DBADM.TB_MIG_JOBS.SOURCE_TBL%TYPE;
  
  V_CMD_SQL     CLOB;  -- VARCHAR2(32767);
  V_ROW_CNT     NUMBER(5);
  CURSOR ICUR 
       IS SELECT A.JOB_ID, A.JOB_NM, A.JOB_GROUP, A.JOB_TYPE, A.JOB_DESC
               , A.TARGET_TBL, A.SOURCE_TBL
               , A.CMD_SQL
            FROM DBADM.TB_MIG_JOBS A
           WHERE JOB_GROUP LIKE 'ST1%'
             AND RUN_STAT = 'READY'
           ORDER BY JOB_GROUP, PRIORITY
           FOR UPDATE OF RUN_STAT, LOG_ID;
  
BEGIN 
    V_RUN_GROUP := P_RUN_GROUP;
    V_LOG_GROUP := P_LOG_GROUP;
    V_ROW_CNT := 1;
    WHILE V_ROW_CNT > 0
    LOOP
        V_ROW_CNT := 0;
        FOR REC IN ICUR
        LOOP
            -- UPDATE DBADM.TB_MIG_JOBS SET RUN_STAT = 'READY' WHERE JOB_ID = REC.JOB_ID;
            V_JOB_ID        := REC.JOB_ID;
            V_JOB_NM        := REC.JOB_NM;
            V_JOB_GROUP     := REC.JOB_GROUP;
            V_JOB_TYPE      := REC.JOB_TYPE;
            V_JOB_DESC      := REC.JOB_DESC;
            V_TARGET_TBL    := REC.TARGET_TBL;
            V_SOURCE_TBL    := REC.SOURCE_TBL;
            V_CMD_SQL       := REC.CMD_SQL;
            
            UPDATE DBADM.TB_MIG_JOBS SET RUN_STAT = 'START' WHERE CURRENT OF ICUR;
            V_ROW_CNT := SQL%ROWCOUNT;
            COMMIT;
            EXIT;
        END LOOP;
        EXIT WHEN V_ROW_CNT = 0;
        DBMS_OUTPUT.ENABLE(1000);
        DBMS_OUTPUT.PUT_LINE('----------');
        DBMS_OUTPUT.PUT_LINE(V_JOB_ID||':'||V_JOB_NM);
        
        DBADM.UP_MIG_JOB_RUN(P_JOB_ID => V_JOB_ID, P_LOG_GROUP=>V_LOG_GROUP);
        
        DBMS_OUTPUT.PUT_LINE('==========');
        --COMMIT;
    END LOOP;
END;