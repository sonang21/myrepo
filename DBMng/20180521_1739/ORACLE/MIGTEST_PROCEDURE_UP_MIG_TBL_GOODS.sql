/* *************************************************************************
 * NAME : MIGTEST.UP_MIG_TBL_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-17 13:36:49
 *        Modify: 2018-04-19 18:30:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "MIGTEST"."UP_MIG_TBL_GOODS" (P_VALUE VARCHAR2 DEFAULT NULL)
-- =============================================================================
-- 대상테이블 : TBL_GOODS (MIG_CATE_GOODS)
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
    V_TARGET_TABLE  VARCHAR2(100) := 'MIG_GOODS';  -- NEED CONNECT NAME FOR DDL
    V_SOURCE_TABLE  VARCHAR2(100) := 'TBL_GOODS(OLD)';
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
      FROM DBENURI.ASIS_TBL_GOODS;
   
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
      INTO migtest.MIG_GOODS
           ( MODELNO
           , RECOMMEND
           , MODELNM
           , FACTORY
           , SPEC
           ------------------------ 5
           , C_DATE
           , IMGCHK
           , CONSTRAIN
           , FLAG
           , REFID
           ------------------------ 10
           , MANUAL_LINK
           , LINKSERVICEFLAG
           , G_SIZE
           , FUNC
           , KEYWORD
           ------------------------ 15
           , JOBCODE
           , MODDATE
           , OPENEXPECTFLAG
           , MODELNO_GROUP
           , CONDINAME
           ------------------------ 20
           , MODEL_SORT
           -- , CA_LCODE
           -- , CATEFLAG
           , NO
           , REFERMODELNO
           , FACTORY_ETC
           , RSIFLAG
           ------------------------ 25
           , P_PL_NO
           , P_IMGURL
           , P_IMGURLFLAG
           , REFSHOP
           , BRAND
           ------------------------ 30
           , FUNC_IMG
           , KEYWORD2
           , WEIGHT
           , HEIGHT
           , SPEC_GROUP
           ------------------------ 35
           , P_IMGURL2
           , KB_TITLE
           , IMGCHK2
           , IMGCHK3
           , MOBILE_FLAG
           ------------------------ 40
           , EXT_CONDI_FLAG
           , STANDARD
           , AMOUNT
           , CHANGE
           , UNIT
           ------------------------ 45
           )
    SELECT /*+ PARALLEL(4) */
           A.MODELNO
         , MAX(A.RECOMMEND        )
         , MAX(A.MODELNM          )
         , MAX(A.FACTORY          )
         , MAX(A.SPEC             )
          ------------------------ 5
         , MAX(A.C_DATE           )
         , MAX(A.IMGCHK           )
         , MAX(A.CONSTRAIN        )
         , MAX(A.FLAG             )
         , MAX(A.REFID            )
          ------------------------ 10
         , MAX(A.MANUAL_LINK      )
         , MAX(A.LINKSERVICEFLAG  )
         , MAX(A.G_SIZE           )
         , (SELECT S.FUNC FROM DBENURI.ASIS_TBL_GOODS S WHERE S.MODELNO = A.MODELNO AND ROWNUM=1) FUNC
         , MAX(A.KEYWORD          )
          ------------------------ 15
         , MAX(A.JOBCODE          )
         , MAX(A.MODDATE          )
         , MAX(A.OPENEXPECTFLAG   )
         , MAX(A.MODELNO_GROUP    )
         , MAX(A.CONDINAME        )
          ------------------------ 20
         , MAX(A.MODEL_SORT       )
         --MAX( , CA_LCODE        )
         --MAX( , CATEFLAG        )
         , MAX(A.NO               )
         , MAX(A.REFERMODELNO     )
         , MAX(A.FACTORY_ETC      )
         , MAX(A.RSIFLAG          )
          ------------------------ 25
         , MAX(A.P_PL_NO          )
         , MAX(A.P_IMGURL         )
         , MAX(A.P_IMGURLFLAG     )
         , MAX(A.REFSHOP          )
         , MAX(A.BRAND            )
          ------------------------ 30
         , MAX(A.FUNC_IMG         )
         , MAX(A.KEYWORD2         )
         , MAX(A.WEIGHT           )
         , MAX(A.HEIGHT           )
         , MAX(A.SPEC_GROUP       )
          ------------------------ 35
         , MAX(A.P_IMGURL2        )
         , MAX(A.KB_TITLE         )
         , MAX(A.IMGCHK2          )
         , MAX(A.IMGCHK3          )
         , MAX(A.MOBILE_FLAG      )
          ------------------------ 40
         , MAX(A.EXT_CONDI_FLAG   )
         , MAX(A.B.STANDARD       )
         , MAX(A.B.AMOUNT         )
         , MAX(A.B.CHANGE         )
         , MAX(A.B.UNIT           )
           ------------------------ 45
      FROM DBENURI.ASIS_TBL_GOODS A
           LEFT OUTER JOIN DBENURI.ASIS_TBL_GOODS_CHANGE B ON (B.MODELNO = A.MODELNO)
     GROUP BY A.MODELNO
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