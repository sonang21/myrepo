/* *************************************************************************
 * NAME : DBENURI.UDP_SEARCH_LOG_ES
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-08 14:41:45
 *        Modify: 2018-05-17 18:40:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SEARCH_LOG_ES" AS

P_SID       NUMBER(20) := 0;
P_FIRST_CNT NUMBER(20) := 0;
BEGIN

    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 추가색인용 상품 자료 생성
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 처리순서 1.작업대상(TBL_ES_SEARCH_LOG) 테이블에 작업중 FLAG UPDATE
    --            - SL_APPLY_FLAG = '2', SL_APPLY_SID = SESSIONID 활용
    --            - SL_APPLY_FLAG = 1:대상, 2:작업중, 3:완료, 4:오류
    --          2.작업 후
    --            - SL_SEND_FLAG = '2', SL_PID = SESSIONID 기준으로 '3' UPDATE 
    --             (작업대상으로 Update한 건수와 동일한 경우에만 COMMIT, 다를 경우 ROLLBACK)
    --          3.작업중 오류인 경우 '2' -> '1' 변경
    -------------------------------------------------------------------------------------------------------------------------------------------------

    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 0508 검토 필요사항
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 1.아래 QUERY 점검 (특히 '확인','@' 표시)
    --   - 테이블에 없는 값 필요시 TBL_ES_SEARCH_LOG 컬럼 추가, 트리거 수정하여 추가된 컬럼에 값 반영 검토 필요  --> 완료
    -- 2.테스트 완료후 TBL_SEARCH_LOG_TMP -> TBL_SEARCH_LOG 변경해야 함                                          --> 완료
    -------------------------------------------------------------------------------------------------------------------------------------------------

    BEGIN
         SELECT SYS_CONTEXT('USERENV','SESSIONID')
           INTO P_SID
           FROM DUAL;
    END;

    BEGIN
         --------------------------------------------------------------------------------------------------------------------------------------------
         -- 1.작업대상(TBL_ES_SEARCH_LOG) 테이블에 작업중 FLAG UPDATE
         --------------------------------------------------------------------------------------------------------------------------------------------

         UPDATE TBL_ES_SEARCH_LOG
            SET SL_APPLY_FLAG   = '2'
              , SL_APPLY_SID    = P_SID
              , SL_APPLY_S_DATE = SYSTIMESTAMP
          WHERE SL_APPLY_FLAG   = '1';  -- 아래 Query 조건에 해당되지 않는 건도 Update 됨, 문제는 아님 

         IF SQL%ROWCOUNT >= 1 THEN

            P_FIRST_CNT := SQL%ROWCOUNT;

            BEGIN

                 INSERT /*+ APPEND NOLOGGING */ INTO TBL_SEARCH_LOG   -- _TMP 테스트할 때 붙여서 할 것 
                 ------------------------------------------------------------------------------------------------------------------------------------
                 -- 1.TBL_PRICELIST 기준 ( PL_NO JOIN )
                 ------------------------------------------------------------------------------------------------------------------------------------
                 SELECT  /*+ PARALLEL(2) */
                       'P' || P.PL_NO                                                                                               AS ID
                      , P.PL_NO                                                                                                     AS MODELNO
                      , '0'                                                                                                         AS GROUP_FLAG      -- 확인(이주현) -> 0 (상수입력)
                      , CASE WHEN P.CA_CODE IS NULL          THEN '000000'
                             WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM(P.CA_CODE) || '0000'
                             WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00'
                             ELSE P.CA_CODE
                             END                                                                                                    AS CATEGORY
                      , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '9501' THEN UDF_GOODSNM_REMOVE(P.goodsnm) || ' 음반 앨범'
                                                                 ELSE UDF_GOODSNM_REMOVE(P.goodsnm)
                                                                 END                                                                AS MODELNM
                      , P.shop_code                                                                                                 AS SHOP_CODE
                      , '[추가]'                                                                                                    AS FACTORY        -- 확인(이주현) -> '[추가]' (상수입력)
                      , NVL(P.POPULAR,0)                                                                                            AS POPULAR
                      , P.price                                                                                                     AS MINPRICE
                      , P.price                                                                                                     AS MAXPRICE
                      , P.price || ' '                                                                                              AS MINPRICES
                      , TO_CHAR(P.U_DATE,'YYYYMMDDHH24MISS')                                                                        AS C_DATE
                      , 1                                                                                                           AS MALLCNT
                      , ' '                                                                                                         AS SPEC
                      , '0'                                                                                                         AS OPENEXPECTFLAG
                      , ' '                                                                                                         AS CONDINAME
                      , ' '                                                                                                         AS KEYWORD
                      , ' '                                                                                                         AS KEYWORD2
                      , ' '                                                                                                         AS BRANDCODE1
                      , ' '                                                                                                         AS BRANDCODE2
                      , ' '                                                                                                         AS SPECOPT
                      , '2'                                                                                                         AS SERVICE_FLAG    -- 확인(이주현) -> '2'
                      , E.STATUS                                                                                                    AS STATUS          -- 확인(이주현) -> TBL_ES_SEARCH_LOG.STATUS
                      , E.REGDATE                                                                                                   AS REGDATE         -- 확인(이주현) -> TBL_ES_SEARCH_LOG.REGDATE
                      , CASE WHEN P.CA_CODE IS NULL          THEN '000000'
                             WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || '0000'
                             WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE)  || '00'
                             ELSE P.CA_CODE
                             END                                                                                                    AS CA_CODE
                      , P.PL_NO                                                                                                     AS PL_NO           -- 확인(이주현) -> TBL_ES_SEARCH_LOG.PL_NO
                      , M.SALE_CNT                                                                                                  AS SALE_CNT
                      , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' THEN '1' ELSE '0' END                                                AS BOOKFLAG
                      , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' THEN '0' ELSE '1' END                                                AS USEFLAG
                      , NVL(P.POPULAR,0)                                                                                            AS POPULAR2
                      , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '1219' THEN UDF_GOODSNM_REMOVE(P.goodsnm)
                                                                 ELSE '' END                                                        AS MODELNM2
                      , 0                                                                                                           AS WEIGHT
                      , '0'                                                                                                         AS SC_WEB          -- 확인(이주현)  UDF_SC_CHECK('0', v_modelno, '1', v_shop_code) --> '0'(상수입력)
                      , '0'                                                                                                         AS SC_MOBILE       -- 확인(이주현)  UDF_SC_CHECK('0', v_modelno, '2', v_shop_code) --> '0'(상수입력)
                      , NVL(store_flag,'0')                                                                                         AS STORE_FLAG
                      , CASE WHEN NVL(store_flag,'0')='1' THEN price ELSE 0 END                                                     AS MINPRICE4
                      , '기타'                                                                                                      AS BRAND
                      , CASE WHEN store_flag='1'           THEN ca_code_dept ELSE ''
                             END                                                                                                    AS CA_DEPT_CODE
                      ,(CASE WHEN NVL(instance_price,0) = 0 THEN price
                             ELSE CASE WHEN instance_price < price THEN instance_price
                                       ELSE price
                                       END
                             END)                                                                                                   AS MINPRICE3
                      , ''                                                                                                          AS GOODSBRAND      -- 확인(이주현) --> '' (null 입력)
                      , NVL(instance_price,0)                                                                                       AS MAXPRICE3
                      , 0                                                                                                           AS BBS_NUM
                      , CASE WHEN deliverytype2=0 THEN (price + 2500)
                             ELSE (price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                             END                                                                                                    AS MINPRICE2
                      , '0'                                                                                                         AS EXT_CONDI_FLAG
                 FROM   TBL_PRICELIST                     P -- SUBPARTITION 단위 처리 고려
                        INNER JOIN
                        (
                            SELECT MODELNO
                                 , STATUS
                                 , REGDATE
                                 , PL_NO
                                 , SL_APPLY_FLAG
                                 , SL_APPLY_SID 
                              FROM (
                                     SELECT MODELNO
                                          , STATUS
                                          , REGDATE
                                          , PL_NO
                                          , SL_APPLY_FLAG
                                          , SL_APPLY_SID
                                          , ROW_NUMBER() OVER (PARTITION BY PL_NO ORDER BY REGDATE DESC ) AS RK      -- 0516 MODELNO -> PL_NO 한용규 변경  
                                       FROM TBL_ES_SEARCH_LOG 
                                      WHERE SL_APPLY_FLAG = '2'        -- 성능 튜닝 필요(Full Scan 해소)
                                        AND SL_APPLY_SID  = P_SID
                                        AND PL_NO         > 0
                                   ) 
                             WHERE RK = 1
                        ) ------------------------------------------------------------------------------------------------------------------------------------
                          -- 추가색인 데이터 수집 기간 동안 동일 pl_no가 쌓일 경우 가장 최근의 pl_no만 수집 (이주현)
                          ------------------------------------------------------------------------------------------------------------------------------------
                                                          E ON P.PL_NO     = E.PL_NO     
                        INNER JOIN      TBL_SHOPLIST      S ON P.SHOP_CODE = S.SHOP_CODE
                        LEFT OUTER JOIN TBL_GOODS         G ON P.MODELNO   = G.MODELNO                               -- 0508 확인 필요
                        LEFT OUTER JOIN TBL_GOODS_SUM     M ON P.MODELNO   = M.MODELNO                               -- 0508 확인 필요
                 WHERE  P.SRVFLAG IN ('0','L','R','Z','2','3','6','7','9','O','D','S','P')
                 AND    P.STATUS  IN ('0','8','9')
                 AND  ( P.ca_code IS NOT NULL AND rtrim(P.ca_code) IS NOT NULL )
                 AND  (
                        P.MODELNO <= 0
                        OR ( G.CONSTRAIN    = '1' AND G.JOBCODE = '0'   )
                        OR ( G.CONSTRAIN IS NULL  AND G.JOBCODE IS NULL )
                        OR   G.CONSTRAIN IN ('2','3')
                        OR ( P.OPTION_FLAG2 = '1' AND M.MINPRICE < P.PRICE )
                        OR   P.SRVFLAG   IN ('Z','2','3','6','7','9','O','D','P' )
                      )

                 UNION ALL

                 --------------------------------------------------------------------------------------------------------------------------------------------
                 -- 2.TBL_GOODS 기준 ( MODELNO JOIN )
                 --------------------------------------------------------------------------------------------------------------------------------------------

                 SELECT  /*+ PARALLEL(2) */
                        'G' || NVL(modelno_group,G.modelno)                                                                         AS ID
                      , NVL(modelno_group,G.modelno)                                                                                AS modelno
                      , CASE WHEN MAX(modelno_group) is null then '0' else '1' end                                                  AS GROUP_FLAG     -- 확인 (이주현 추가)
                      , NVL(UDF_RTN_GET_CATEGORY3(NVL(modelno_group,G.modelno)), ' ')                                               AS category
                      , MAX(replace(replace(modelnm,replace(condiname,'.',''),''),'[]',''))                                         AS modelnm
                      , 0                                                                                                           AS shop_code
                      , LTRIM(RTRIM(MAX(factory)))                                                                                  AS factory
                      , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END              AS popular
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice)
                             ELSE UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0))
                             END                                                                                                    AS minprice
                      , MAX(minprice)                                                                                               AS maxprice
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN MIN(minprice) || ''
                             ELSE UDF_MODEL_GROUP_MINPRICE(NVL(MAX(modelno_group),0))
                             END                                                                                                    AS minprices
                      , TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS')                                                                     AS C_DATE
                      , MAX(mallcnt)                                                                                                AS mallcnt
                      , replace(replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' '),'+',' ')              AS spec
                      , case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end              AS openexpectflag
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN ''
                             ELSE UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0))
                             END                                                                                                    AS condiname
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'')
                             ELSE UDF_MODEL_GROUP_KEYWORD(NVL(MAX(modelno_group),0)) || ' ' || NVL(MAX(BRAND),'')
                             END                                                                                                    AS KEYWORD
                      , UDF_CATEGORY_KEYWORD_POPULAR2(MIN(G.modelno))                                                               AS keyword2
                      , ''                                                                                                          AS BRANDCODE1
                      , ''                                                                                                          AS BRANDCODE2
                      , UDF_RTN_GET_SPECOPT(NVL(modelno_group,G.modelno))                                                           AS SPECOPT
                      , '1'                                                                                                         AS SERVICE_FLAG   -- 확인(이주현) -> '1'
                      , MAX(E.STATUS)                                                                                               AS STATUS          -- 확인(이주현)
                      , MAX(E.REGDATE)                                                                                              AS REGDATE         -- 확인(이주현)
                      , MIN(ca_code)                                                                                                AS ca_code
                      , 0                                                                                                           AS pl_no           -- 확인 -> 맞음
                      , MAX(sale_cnt)                                                                                               AS sale_cnt
                      , CASE WHEN MAX(substr(ca_code,0,2)) = '93' then '1' else '0' end                                             AS bookflag
                      , CASE WHEN MAX(mallcnt) > 0 AND (CASE WHEN NVL(MIN(openexpectflag),'0') = '1' OR  min(c_date) > sysdate  THEN '1'
                                                             ELSE '0'
                                                             END) = '0' AND MAX(substr(ca_code,0,2)) <> '93' THEN '1'
                                                             ELSE '0'
                                                             END                                                                    AS USEFLAG
                      , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END              AS popular2
                      , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname))                              AS modelnm2
                      , CASE WHEN substr(MAX(ca_code),0,4)='0501' THEN NVL(MAX(weight)*100,0) ELSE NVL(MAX(weight)*100,999999) END  AS weight
                      , '0'                                                                                                         AS SC_WEB          -- 확인(이주현)  UDF_SC_CHECK('0', v_modelno, '1', v_shop_code) --> '0'(상수입력)
                      , '0'                                                                                                         AS SC_MOBILE       -- 확인(이주현)  UDF_SC_CHECK('0', v_modelno, '2', v_shop_code) --> '0'(상수입력)
                      , CASE WHEN MIN(NVL(minprice4,0)) > 0 THEN '1' ELSE '0' end                                                   AS store_flag
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND
                                  MAX(NVL(minprice4,0)) > 0     THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),4)
                             ELSE MIN(minprice4)
                             END                                                                                                    AS minprice4
                      , LTRIM(RTRIM(MAX(brand)))                                                                                    AS brand
                      , CASE WHEN MAX(NVL(minprice4,0)) > 0 THEN UDF_RTN_GET_DEPT_CA_CODE(MAX(G.modelno)) ELSE '' END               AS ca_dept_code
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND
                                  MAX(NVL(minprice3,0)) > 0     THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),3)
                             ELSE MIN(minprice3)
                             END                                                                                                    AS minprice3
                      , RTRIM(LTRIM(MAX(factory)))                                                                                  AS goodsbrand      -- 확인 (이주현 수정)
                      , MAX(minprice3)                                                                                              AS maxprice3
                      , UDF_BBS_NUM_SUM(NVL(modelno_group,G.modelno))                                                               AS bbs_num
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND
                                  MAX(NVL(minprice2,0)) > 0     THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),2)
                             ELSE MIN(minprice2)
                             END                                                                                                    AS minprice2
                      , NVL(MIN(EXT_CONDI_FLAG),'0')                                                                                AS ext_condi_flag
                  FROM  TBL_GOODS                         G  -- PARTITION 단위 처리 고려
                        INNER JOIN
                        (
                            SELECT MODELNO
                                 , STATUS
                                 , REGDATE
                                 , PL_NO
                                 , SL_APPLY_FLAG
                                 , SL_APPLY_SID 
                             FROM (
                                    SELECT MODELNO
                                         , STATUS
                                         , REGDATE
                                         , PL_NO
                                         , SL_APPLY_FLAG
                                         , SL_APPLY_SID
                                         , ROW_NUMBER() OVER (PARTITION BY MODELNO ORDER BY REGDATE DESC ) AS RK 
                                      FROM TBL_ES_SEARCH_LOG 
                                     WHERE SL_APPLY_FLAG = '2'       -- 성능 튜닝 필요(Full Scan 해소)
                                       AND SL_APPLY_SID  = P_SID
                                       AND MODELNO       > 0
                                  ) 
                            WHERE RK = 1
                        ) ------------------------------------------------------------------------------------------------------------------------------------
                          -- 추가색인 데이터 수집 기간 동안 동일 modelno가 쌓일 경우 가장 최근의 modelno만 수집 (이주현)
                          ------------------------------------------------------------------------------------------------------------------------------------
                                                          E ON G.MODELNO   = E.MODELNO  
                        LEFT OUTER JOIN TBL_GOODS_SUM     M ON G.MODELNO   = M.MODELNO                          -- 0508 확인 필요
                  WHERE jobcode >= '1'
                    AND (constrain = '1' OR (constrain = '5' AND mallcnt > 0))
                  --AND  cateflag ='0'                                                                          -- (이주현 제거)
                  GROUP BY nvl(modelno_group,G.modelno)
                  ;

                  --------------------------------------------------------------------------------------------------------------------------------------------
                  -- 2.작업대상(TBL_ES_SEARCH_LOG) 테이블에 작업완료 FLAG UPDATE
                  --------------------------------------------------------------------------------------------------------------------------------------------
                  IF SQL%ROWCOUNT >= 1 THEN           -- 없을 수 있을까 ? 

                     UPDATE TBL_ES_SEARCH_LOG
                        SET SL_APPLY_FLAG   = '3'
                          , SL_APPLY_E_DATE = SYSTIMESTAMP
                      WHERE SL_APPLY_FLAG   = '2'
                        AND SL_APPLY_SID    = P_SID;    -- 0508 index 추가 검토

                     -----------------------------------------------------------------------------------------------------------------------------------------
                     -- 최초 작업대상으로 UPDATE한 건수와 최종 완료처리 건수가 같아야 함  
                     -----------------------------------------------------------------------------------------------------------------------------------------
                     IF P_FIRST_CNT = SQL%ROWCOUNT THEN
                        COMMIT; 
                     ELSE
                        ROLLBACK;
                     END IF;

                  END IF;

            END;
         END IF;
    END;

END;
