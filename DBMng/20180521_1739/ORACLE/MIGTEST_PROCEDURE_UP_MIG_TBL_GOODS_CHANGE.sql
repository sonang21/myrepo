/* *************************************************************************
 * NAME : MIGTEST.UP_MIG_TBL_GOODS_CHANGE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-17 13:50:41
 *        Modify: 2018-04-19 18:35:25
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "MIGTEST"."UP_MIG_TBL_GOODS_CHANGE" (P_VALUE VARCHAR2 DEFAULT NULL)
-- =============================================================================
-- 대상테이블 : TBL_GOODS_CHANGE (MIG_CATE_GOODS)
-- 소스테이블 : TBL_GOODS (OLD)
-- 설  명 : 
--------------------------------------------------------------------------------
-- 작성자 : 송정훈
-- 작성일 : 2018.03.21
-- ----------------------------------------------------------------------------
-- [수정] : 2018.04.19 : 스키마 변경시 반드시 대소문자 구분하여 일괄 변경
-- [확인] : source_schema=>DBENURI, target_schema => migtest 
-- COUNT:
-- =============================================================================
IS
    -- 사용자 설정 영역
    V_TARGET_TABLE  VARCHAR2(100) := 'MIG_GOODS_CHANGE';  -- NEED CONNECT NAME FOR DDL
    V_SOURCE_TABLE  VARCHAR2(100) := 'TBL_GOODS_CHANGE(OLD)';
    -----------------------------------------------
    -- 내부 사용 
    V_SOURCE_COUNT  NUMBER ;
    V_TARGET_COUNT  NUMBER ;
    V_RESULT_COUNT  NUMBER := 0;
    -- V_WORK_COUNT    NUMBER := 0;       -- 작업 진행 건수 
    -- V_WORK_UNIT     NUMBER := 1000000; -- 작업 단위(미사용)
    V_JOB_NAME VARCHAR2(50);
    
BEGIN
    -----------------------------------------------------------------------------
    -- 01. [고정] SP_LOG_CREATE('jobname', 'target_table','source_table');
    -----------------------------------------------------------------------------
    V_JOB_NAME := $$PLSQL_UNIT || CASE WHEN P_VALUE IS NOT NULL THEN '('||P_VALUE||')' END;
    DBADM.PG_MIG.SP_LOG_CREATE (V_JOB_NAME, V_TARGET_TABLE, V_SOURCE_TABLE);
    -------------------------------------------------------------------------------
    -- 02. SOURCE_COUNT & TARGET_COUNT -- SKIP FOR PERF
    -------------------------------------------------------------------------------   
    -- ■■■ [편집영역] 전환 건수 산정 
    SELECT /*+ PARALLEL(4) */ 
           COUNT(*), COUNT(DISTINCT MODELNO)                                                 
      INTO V_SOURCE_COUNT
         , V_TARGET_COUNT
      FROM DBENURI.ASIS_TBL_GOODS_CHANGE;
   
    IF V_TARGET_COUNT IS NULL THEN
        V_TARGET_COUNT := V_SOURCE_COUNT;
    END IF;
    
    -------------------------------------------------------------------------------
    --03. [고정] SP_LOG_START
    -------------------------------------------------------------------------------    
    -- DBADM.PG_MIG.SP_LOG_SOURCE_COUNT(V_SOURCE_COUNT, V_TARGET_COUNT);
    DBADM.PG_MIG.SP_LOG_START(P_SOURCE_CNT=>V_SOURCE_COUNT, P_TARGET_CNT=> V_TARGET_COUNT);
    /* *******************************************************************************
    -- 04. [편집] MIG SQL
    ---------------------------------------------------------------------------------
    WHILE V_WORK_COUNT <= V_TARGET_COUNT
    LOOP
        -- DO SOMETHING
        V_WORK_COUNT := V_WORK_COUNT + V_WORK_UNIT;
    END;    
    ******************************************************************************* */  
    EXECUTE IMMEDIATE 'ALTER    TABLE migtest.'||V_TARGET_TABLE||'    NOLOGGING';
    -------------------------------------------------------------------------------
    -- ■■■ [편집영역] 전환 SQL 작성 영역 
    
    INSERT /*+ APPEND */
      INTO migtest.MIG_GOODS_CHANGE
         ( MODELNO
         , ALL_COMPONENT
         , SPEC_TAG
         , SPEC_LP_TAG
         , SPEC_LP_TAG2
         , SPEC_VIP_TAG
         , IS_RESERVE 
         )
    SELECT /*+ PARALLEL 4 */
           MODELNO
         , ALL_COMPONENT
         , SPEC_TAG
         , SPEC_LP_TAG
         , SPEC_LP_TAG2
         , SPEC_VIP_TAG
         , IS_RESERVE 
      FROM DBENURI.ASIS_TBL_GOODS_CHANGE
    ;

    -------------------------------------------------------------------------------
    -- 05. [고정] COUNT EFFECTED ROWS AND COMMIT
    -------------------------------------------------------------------------------
    V_RESULT_COUNT := V_RESULT_COUNT + SQL%ROWCOUNT;
    
    COMMIT;
    EXECUTE IMMEDIATE 'ALTER    TABLE migtest.'||V_TARGET_TABLE||'    LOGGING';
    -------------------------------------------------------------------------------
    -- 06. [고정] SP_LOG_END 
    -------------------------------------------------------------------------------
    DBADM.PG_MIG.SP_LOG_END(V_RESULT_COUNT);
EXCEPTION WHEN OTHERS THEN
    -- 07. [고정] SP_LOG_END : ERROR
    DBADM.PG_MIG.SP_LOG_END(V_RESULT_COUNT, 'ERROR', SQLCODE, SQLERRM);
    RAISE;
END;