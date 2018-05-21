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
       END STAT -- (���)�������
     ,   RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC /60 /60 ) ), 2) + ':'
       + RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC /60) % 60 ), 2) + ':'
       + RIGHT('0' + CONVERT(VARCHAR, (A.RUN_SEC    ) % 60 ), 2) RUN_TIME   -- �������� �ð�(��:��:��)
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
       END REF_TIME     -- ���� ����ð�(��:��:��)
     ---------------------------------------------------------
     , CASE WHEN A.REQ_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.REQ_SEC    ) % 60 ), 2)
       END REQ_TIME     -- �ҿ�ð�(��:��:��)
     , A.START_TIME
     , A.END_TIME
     , A.REQ_SEC          -- �ҿ�ð�(��)
     , A.RUN_SEC          -- ����ð�(��)
     , A.BEF_SEC          -- �����ҿ�ð�(��)
     , A.STATUS           -- �������
     , A.RES_CODE         -- ����ڵ�
     , A.SOURCE_CNT       -- ��õ���̺�Ǽ�
     , A.TARGET_CNT       -- ��ȯ���Ǽ�
     , A.RESULT_CNT       -- ��ȯ����Ǽ� 
     , A.ERROR_CODE       -- �����ڵ�
     , A.ERROR_MSG        -- �����޽���
     , A.LOG_TIME         -- �αױ�Ͻð�
     , A.LOG_COMMENT      -- �α׺ο�����
     , A.GRP_START        -- �׷� ���� �ð�
     , A.GRP_END          -- �׷� ���� �ð�
     , A.SUM_SEC          -- �׷� �հ� �ð� 
     , CASE WHEN A.SUM_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.SUM_SEC    ) % 60 ), 2)
       END SUM_TIME     -- �׷� �հ� �ð�(��:��:��) -- �����ҿ�ð� �հ� 
     , A.GRP_SEC          -- �׷� �ҿ�ð�(����ð�-���۽ð�)
     , CASE WHEN A.GRP_SEC > 0 THEN 
             RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC /60 /60 ) ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC /60) % 60 ), 2) + ':'
           + RIGHT('0' + CONVERT(VARCHAR, (A.GRP_SEC    ) % 60 ), 2)
       END GRP_TIME     -- �׷� �ҿ�ð�(��:��:��)  -- (��������ð� - ���ʽ��۽ð�)
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

