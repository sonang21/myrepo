/* *************************************************************************
 * NAME : dbo.VW_MIG_LOG
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2018-04-02 14:37:13.153
 *        Modify: 2018-04-19 11:41:14.127
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE VIEW [dbo].[VW_MIG_LOG]
AS  -- MS SQL 
SELECT A.LOG_ID
     , A.LOG_GROUP
     , A.JOB_ID
     , A.JOB_NAME
     , A.TARGET_TABLE
     , A.SOURCE_TABLE
     , CASE WHEN A.RES_CODE = 'ERROR'   THEN '0.ERROR'
            WHEN A.STATUS   = 'READY'   THEN '1.READY'
            WHEN A.STATUS   = 'RUNNING' THEN '2.RUNNING'
            WHEN A.RES_CODE = 'SUCCESS' THEN '3.SUCCESS'
            ELSE '9.' + ISNULL(A.RES_CODE, STATUS)
       END STAT -- (결과)진행상태
     ,   RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC /60 /60 ) ), 2) + ':'
       + RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC /60) % 60 ), 2) + ':'
       + RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC    ) % 60 ), 2) RUN_TIME   -- 실행중인 시간(시:분:초)
     ---------------------------------------------------------
     -- BASE TIME COMPARE
     , CASE WHEN B.BAS_ELAPSED_SEC != 0 THEN CONVERT(DEC(7,1), A.RUN_SEC * 100.0 / B.BAS_ELAPSED_SEC) END "BAS(%)"
     , dbo.FN_SEC_TO_HMS(B.BAS_ELAPSED_SEC)   BASE_TM
     -- , BEF_LOG TIME COMPARE
     , CASE WHEN A.BEF_SEC != 0 THEN CONVERT(DEC(7,1), A.RUN_SEC * 100.0 / A.BEF_SEC) END "BEF(%)"
     , CASE WHEN A.BEF_SEC IS NOT NULL THEN
           '[' +  CONVERT(VARCHAR, BEF_LOG) + '] '
           + RIGHT('0' + CONVERT(VARCHAR, (A.BEF_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.BEF_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.BEF_SEC    ) % 60 ), 2) 
       END REF_TIME     -- 이전 수행시간(시:분:초)
     ---------------------------------------------------------
     , CASE WHEN A.REQ_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC    ) % 60 ), 2)
       END REQ_TIME     -- 소요시간(시:분:초)
     , A.START_TIME
     , A.END_TIME
     , A.REQ_SEC          -- 소요시간(초)
     , A.RUN_SEC          -- 실행시간(초)
     , A.BEF_SEC          -- 이전소요시간(초)
     , A.STATUS           -- 진행상태
     , A.RES_CODE         -- 결과코드
     , A.SOURCE_CNT       -- 원천테이블건수
     , A.TARGET_CNT       -- 전환대상건수
     , A.RESULT_CNT       -- 전환결과건수 
     , A.ERROR_CODE       -- 오류코드
     , A.ERROR_MSG        -- 오류메시지
     , A.LOG_TIME         -- 로그기록시간
     , A.LOG_COMMENT      -- 로그부연설명
     , A.GRP_START        -- 그룹 시작 시간
     , A.GRP_END          -- 그룹 종료 시간
     , A.SUM_SEC          -- 그룹 합계 시간 
     , CASE WHEN A.SUM_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC    ) % 60 ), 2)
       END SUM_TIME     -- 그룹 합계 시간(시:분:초) -- 개별소요시간 합계 
     , A.GRP_SEC          -- 그룹 소요시간(종료시간-시작시간)
     , CASE WHEN A.GRP_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC    ) % 60 ), 2)
       END GRP_TIME     -- 그룹 소요시간(시:분:초)  -- (최종종료시간 - 최초시작시간)
  FROM ( SELECT A.*
              , DATEDIFF(SECOND, A.START_TIME, A.END_TIME )                    REQ_SEC
              , DATEDIFF(SECOND, A.START_TIME, ISNULL(A.END_TIME, GETDATE()))  RUN_SEC
              , SUM(DATEDIFF(SECOND, A.START_TIME, A.END_TIME )) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE) SUM_SEC 
              , MIN(A.START_TIME) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)             GRP_START
              , MAX(A.END_TIME  ) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)             GRP_END
              , DATEDIFF(SECOND, MIN(A.START_TIME) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)
                               , MAX(A.END_TIME  ) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)
                        )                      GRP_SEC
              , (SELECT MAX(LOG_ID)
                   FROM TB_MIG_LOG S
                  WHERE S.JOB_NAME = A.JOB_NAME 
                    AND S.RES_CODE = 'SUCCESS'
                    AND S.LOG_ID < A.LOG_ID
                ) BEF_LOG
              , (SELECT DATEDIFF(SECOND, S.START_TIME, S.END_TIME )
                   FROM TB_MIG_LOG S
                  WHERE LOG_ID = (SELECT MAX(LOG_ID)
                                   FROM TB_MIG_LOG X
                                  WHERE X.JOB_NAME = A.JOB_NAME 
                                    AND X.RES_CODE = 'SUCCESS'
                                    AND X.LOG_ID < A.LOG_ID
                                 )
                ) BEF_SEC
--              , LEAD(LOG_ID)
--                    OVER (PARTITION BY JOB_NAME ORDER BY DECODE(RES_CODE, 'SUCCESS', 0, NULL, 0, 9), LOG_ID DESC)        BEF_LOG
--              , LEAD(TRUNC((A.END_TIME - A.START_TIME) * 24 * 3600))
--                    OVER (PARTITION BY JOB_NAME ORDER BY DECODE(RES_CODE, 'SUCCESS', 0, NULL, 0, 9), LOG_ID DESC)        BEF_SEC
           FROM TB_MIG_LOG A WITH (NOLOCK)
       ) A
       LEFT OUTER JOIN TB_MIG_JOBS B ON (B.JOB_ID = A.JOB_ID)
 -- ORDER BY A.LOG_ID DESC
;

