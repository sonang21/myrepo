/* *************************************************************************
 * NAME : DBADM.VW_MIG_LOG
 * TYPE : VIEW
 * TIME : Create: 2018-03-27 20:23:21
 *        Modify: 2018-04-18 13:11:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBADM"."VW_MIG_LOG" ("LOG_ID", "LOG_GROUP", "JOB_NAME", "JOB_ID", "TARGET_TABLE", "SOURCE_TABLE", "STAT", "START_TIME", "END_TIME", "PCT", "RUN_TIME", "REF_TIME", "REQ_TIME", "REQ_SEC", "RUN_SEC", "BEF_SEC", "STATUS", "RES_CODE", "SOURCE_CNT", "TARGET_CNT", "RESULT_CNT", "ERROR_CODE", "ERROR_MSG", "LOG_TIME", "LOG_COMMENT", "GRP_START", "GRP_END", "SUM_SEC", "SUM_TIME", "GRP_SEC", "GRP_TIME") AS 
  SELECT LOG_ID          
     , LOG_GROUP 
     , JOB_NAME
     , JOB_ID     
     , TARGET_TABLE    
     , SOURCE_TABLE    
     -- , NVL(RES_CODE, STATUS)  STAT --진행상태(결과)
     , CASE WHEN RES_CODE = 'ERROR'   THEN '0.ERROR'
            WHEN STATUS   = 'READY'   THEN '1.READY'
            WHEN STATUS   = 'RUNNING' THEN '2.RUNNING'
            WHEN RES_CODE = 'SUCCESS' THEN '3.SUCCESS'
            ELSE '9.' || NVL(RES_CODE, STATUS)
       END STAT -- (결과)진행상태
     , START_TIME
     , END_TIME
     -- , BEF_LOG
     , CASE WHEN BEF_SEC != 0 THEN ROUND(RUN_SEC / BEF_SEC * 100, 0) END PCT   -- 최종소요시간 대비 현재 진행 시간 비율
     , FN_SEC_TO_TIME(RUN_SEC) RUN_TIME   -- 현재실행 진행 시간(시:분:초)
     , FN_SEC_TO_TIME(BEF_SEC) REF_TIME     -- 마지막 실행 소요시간(시:분:초)
     , FN_SEC_TO_TIME(REQ_SEC) REQ_TIME     -- 소요시간(시:분:초)
     , REQ_SEC          -- 소요시간(초)
     , RUN_SEC          -- 진행시간(초)
     , BEF_SEC          -- 최종 성공한 소요시간(초)
     , STATUS           -- 진행상태 
     , RES_CODE         -- 결과코드
     , SOURCE_CNT       -- 원본 테이블 건수
     , TARGET_CNT       -- 전환 대상 건수
     , RESULT_CNT       -- 전환 결과 건수
     , ERROR_CODE       -- 오류코드
     , ERROR_MSG        -- 오류메시지
     , LOG_TIME         -- 로그기록시각
     , LOG_COMMENT      -- 로그부연설명
     , GRP_START
     , GRP_END
     , SUM_SEC          -- 그룹의 각 개별 실행 시간(초)의 합계
     , FN_SEC_TO_TIME(SUM_SEC) SUM_TIME   -- 전체 그룹 합계 시간(시:분:초)  
     
     , GRP_SEC          -- 그룹의 시작시간, 종료시간의 간격(초)
     , FN_SEC_TO_TIME(GRP_SEC) GRP_TIME   -- 전체 그룹 실행 진행 시간(시:분:초)  
  FROM ( SELECT A.*
              , TRUNC((A.END_TIME - A.START_TIME) * 24 * 3600)               REQ_SEC
              , TRUNC((NVL(A.END_TIME, SYSDATE) - A.START_TIME) * 24 * 3600) RUN_SEC
              , TRUNC(SUM(A.END_TIME - A.START_TIME) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE) * 24 * 3600) SUM_SEC
              , MIN(A.START_TIME) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)             GRP_START
              , MAX(A.END_TIME  ) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)             GRP_END
              , TRUNC((MAX(A.END_TIME  ) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)
                       -  MIN(A.START_TIME) OVER (PARTITION BY A.LOG_GROUP, A.RES_CODE)
                       ) * 24 * 3600
                     )  GRP_SEC
              , (SELECT MAX(LOG_ID)
                   FROM TB_MIG_LOG S
                  WHERE S.JOB_NAME = A.JOB_NAME 
                    AND S.RES_CODE = 'SUCCESS'
                    AND S.LOG_ID < A.LOG_ID
                ) BEF_LOG
              , (SELECT TRUNC((S.END_TIME - S.START_TIME) * 24 * 3600)
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
           FROM TB_MIG_LOG A
       ) A
 ORDER BY A.LOG_ID DESC