/* *************************************************************************
 * NAME : DBENURI.UDP_SEARCH_LOG_ES_TEST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-10 11:16:11
 *        Modify: 2018-05-17 12:24:38
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SEARCH_LOG_ES_TEST" AS

--P_SID     NUMBER(20) := 0;
P_SID     VARCHAR2(50) := '';

BEGIN

    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 0508 �߰����ο� ��ǰ �ڷ� ���� (CK_03.SQL, CK_04.SQL ����)
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- ó������ 1.�۾����(TBL_ES_SEARCH_LOG) ���̺� �۾��� FLAG UPDATE 
    --            - SL_APPLY_FLAG = '2', SL_APPLY_SID = SESSIONID Ȱ��
    --            - SL_APPLY_FLAG = 1:���, 2:�۾���, 3:�Ϸ�, 4:���� 
    --          2.�۾� �� 
    --            - SL_SEND_FLAG = '2', SL_PID = SESSIONID �������� '3' UPDATE
    --          3.�۾��� ������ ��� '2' -> '1' ���� 
    -------------------------------------------------------------------------------------------------------------------------------------------------
    
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 0508 ���� �ʿ���� 
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- 1.�Ʒ� QUERY ���� (Ư�� 'Ȯ��','@' ǥ��)
    --   - ���̺� ���� �� �ʿ�� TBL_ES_SEARCH_LOG �÷� �߰�, Ʈ���� �����Ͽ� �߰��� �÷��� �� �ݿ� ���� �ʿ� 
    -- 2.�׽�Ʈ �Ϸ��� TBL_SEARCH_LOG_TMP -> TBL_SEARCH_LOG ����, NOLOGGING ���� �ؾ� �� 
    -- 3.TBL_ES_SEARCH_LOG �Ϸ� ó���� ������ ���/���� ��� �߰� 
    -- 4.���Ǵ� function �� ES_APP�� �� �� �ݿ� ���� (�ڡڡڡڡ�)
    -------------------------------------------------------------------------------------------------------------------------------------------------
     
    -------------------------------------------------------------------------------------------------------------------------------------------------
    -- SESSION ID
    -------------------------------------------------------------------------------------------------------------------------------------------------
    
    BEGIN
         SELECT TRIM(TO_CHAR(SYS_CONTEXT('USERENV','SESSIONID'),'0999999999')) || '-' || 
                TO_CHAR(SYSTIMESTAMP,'YYYYMMDD-HH24MISS-FF9')
           INTO P_SID
           FROM DUAL;
    END;
    
    BEGIN
         --------------------------------------------------------------------------------------------------------------------------------------------
         -- 1.�۾����(TBL_ES_SEARCH_LOG) ���̺� �۾��� FLAG UPDATE
         --------------------------------------------------------------------------------------------------------------------------------------------
      
         UPDATE TBL_ES_SEARCH_LOG
            SET SL_APPLY_FLAG   = '2'
              , SL_APPLY_SID    = P_SID
            --, SL_APPLY_S_DATE = SYSDATE OR SYSTIMESTAMP
          WHERE SL_APPLY_FLAG   = '1';

       --IF SQLCODE < 0 THEN DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM); END IF;

         IF SQL%ROWCOUNT >= 1 THEN
            
            BEGIN
              
                 INSERT /*+ APPEND NOLOGGING */ INTO TBL_SEARCH_LOG_TMP 
                 ------------------------------------------------------------------------------------------------------------------------------------
                 -- 1.TBL_PRICELIST ���� ( PL_NO JOIN )
                 ------------------------------------------------------------------------------------------------------------------------------------
                 SELECT  /*+ PARALLEL(2) */   -- /*+ PARALLEL('||V_PARL_NO||') */
                       'P' || P.PL_NO                                                                                                AS ID
                      , P.PL_NO                                                                                                      AS MODELNO
                      , '@'                                                                                                          AS GROUP_FLAG      -- Ȯ�� 
                      , CASE WHEN P.CA_CODE IS NULL          THEN '000000' 
                             WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM(P.CA_CODE) || '0000' 
                             WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' 
                             ELSE P.CA_CODE 
                             END                                                                                                     AS CATEGORY
                      , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '9501' THEN 
                                  UDF_GOODSNM_REMOVE(P.goodsnm) || ' ���� �ٹ�' 
                             ELSE UDF_GOODSNM_REMOVE(P.goodsnm) 
                             END                                                                                                     AS MODELNM
                      , P.shop_code                                                                                                  AS SHOP_CODE
                      , '[�߰�]'                                                                                                     AS FACTORY        -- Ȯ�� 
                      , NVL(P.POPULAR,0)                                                                                             AS POPULAR
                      , P.price                                                                                                      AS MINPRICE
                      , P.price                                                                                                      AS MAXPRICE
                      , P.price || ' '                                                                                               AS MINPRICES
                      , TO_CHAR(P.U_DATE,'YYYYMMDDHH24MISS')                                                                         AS C_DATE
                      , 1                                                                                                            AS MALLCNT
                      , ' '                                                                                                          AS SPEC
                      , '0'                                                                                                          AS OPENEXPECTFLAG
                      , ' '                                                                                                          AS CONDINAME
                      , ' '                                                                                                          AS KEYWORD
                      , ' '                                                                                                          AS KEYWORD2
                      , ' '                                                                                                          AS BRANDCODE1
                      , ' '                                                                                                          AS BRANDCODE2
                      , ' '                                                                                                          AS SPECOPT
                      , '@'                                                                                                          AS SERVICE_FLAG
                      , E.STATUS                                                                                                     AS STATUS          -- Ȯ�� 
                      , E.REGDATE                                                                                                    AS REGDATE         -- Ȯ�� 
                      , CASE WHEN P.CA_CODE IS NULL          THEN '000000' 
                             WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM(P.CA_CODE) || '0000' 
                             WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' 
                             ELSE P.CA_CODE 
                             END                                                                                                     AS CA_CODE
                      , P.PL_NO                                                                                                      AS PL_NO           -- Ȯ�� 
                      , M.SALE_CNT                                                                                                   AS SALE_CNT
                      , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' THEN '1' ELSE '0' END                                                 AS BOOKFLAG
                      , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' THEN '0' ELSE '1' END                                                 AS USEFLAG
                      , NVL(P.POPULAR,0)                                                                                             AS POPULAR2
                      , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '1219' THEN 
                                  UDF_GOODSNM_REMOVE(P.goodsnm) 
                             ELSE '' 
                             END                                                                                                     AS MODELNM2
                      , 0                                                                                                            AS WEIGHT
                      , '@'                                                                                                          AS SC_WEB          -- Ȯ��  UDF_SC_CHECK('0', v_modelno, '1', v_shop_code)
                      , '@'                                                                                                          AS SC_MOBILE       -- Ȯ��  UDF_SC_CHECK('0', v_modelno, '2', v_shop_code)
                      , NVL(store_flag,'0')                                                                                          AS STORE_FLAG
                      , CASE WHEN NVL(store_flag,'0')='1' THEN price ELSE 0 END                                                      AS MINPRICE4
                      , '��Ÿ'                                                                                                       AS BRAND
                      , CASE WHEN store_flag='1' THEN 
                                  ca_code_dept 
                             ELSE '' 
                             END                                                                                                     AS CA_DEPT_CODE
                      ,(CASE WHEN NVL(instance_price,0) = 0 THEN 
                                  price 
                             ELSE CASE WHEN instance_price < price THEN 
                                            instance_price 
                                       ELSE price 
                                       END 
                             END)                                                                                                    AS MINPRICE3
                      , '@'                                                                                                          AS GOODSBRAND      -- Ȯ��
                      , NVL(instance_price,0)                                                                                        AS MAXPRICE3
                      , 0                                                                                                            AS BBS_NUM
                      , CASE WHEN deliverytype2=0 THEN 
                                  (price + 2500) 
                             ELSE (price + DECODE(deliveryinfo, '������', 0, NVL(deliveryinfo2, 2500))) 
                             END                                                                                                     AS MINPRICE2
                      , '0'                                                                                                          AS EXT_CONDI_FLAG
                 FROM   TBL_PRICELIST                     P -- SUBPARTITION ���� ó�� ���  
                        INNER JOIN      TBL_ES_SEARCH_LOG E ON P.PL_NO     = E.PL_NO     AND E.SL_APPLY_FLAG = '2' AND E.SL_APPLY_SID  = P_SID
                                                                                                                -- 0508 Ȯ�� �ʿ� -> PL_NO �ִ� �� �� ? 
                        INNER JOIN      TBL_SHOPLIST      S ON P.SHOP_CODE = S.SHOP_CODE
                        LEFT OUTER JOIN TBL_GOODS         G ON P.MODELNO   = G.MODELNO                          -- 0508 Ȯ�� �ʿ�
                        LEFT OUTER JOIN TBL_GOODS_SUM     M ON P.MODELNO   = M.MODELNO                          -- 0508 Ȯ�� �ʿ� 
                        LEFT OUTER JOIN TBL_CATE_GOODS    C ON P.MODELNO   = C.MODELNO   AND C.CATEFLAG = '0'
                 WHERE  P.SRVFLAG IN ('0','L','R','Z','2','3','6','7','9','O','D','S','P')
                   AND  P.STATUS  IN ('0','8','9')
                   AND (P.ca_code IS NOT NULL AND rtrim(P.ca_code) IS NOT NULL )
                   AND (
                        P.MODELNO <= 0
                        OR ( G.CONSTRAIN    = '1' AND G.JOBCODE = '0'   )
                        OR ( G.CONSTRAIN IS NULL  AND G.JOBCODE IS NULL )
                        OR   G.CONSTRAIN IN ('2','3')
                        OR ( P.OPTION_FLAG2 = '1' AND M.MINPRICE < P.PRICE )
                        OR   P.SRVFLAG   IN ('Z','2','3','6','7','9','O','D','P' )
                       ) 
                 
                 UNION ALL
                 
                 --------------------------------------------------------------------------------------------------------------------------------------------
                 -- 2.TBL_GOODS ���� ( MODELNO JOIN )
                 --------------------------------------------------------------------------------------------------------------------------------------------      

                 SELECT  /*+ PARALLEL(2) */
                        'G' || NVL(modelno_group,G.modelno)                                                                         AS ID
                      , NVL(modelno_group,G.modelno)                                                                                AS modelno
                      , '@'                                                                                                         AS GROUP_FLAG     -- Ȯ�� 
                      , NVL(UDF_RTN_GET_CATEGORY3(NVL(modelno_group,G.modelno)), ' ')                                               AS category           
                      , MAX(replace(replace(modelnm,replace(condiname,'.',''),''),'[]',''))                                         AS modelnm
                      , 0                                                                                                           AS shop_code
                      , LTRIM(RTRIM(MAX(factory)))                                                                                  AS factory
                      , CASE WHEN MAX(modelno_group) IS NULL THEN 
                                  NVL(MAX(popular),0) 
                             ELSE NVL(MAX(sum_popular),0)
                             END                                                                                                    AS popular
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN
                                  MIN(minprice) 
                             ELSE UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) 
                             END                                                                                                    AS minprice       
                      , MAX(minprice)                                                                                               AS maxprice
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN 
                                  MIN(minprice) || '' 
                             ELSE UDF_MODEL_GROUP_MINPRICE(NVL(MAX(modelno_group),0)) 
                             END                                                                                                    AS minprices      
                      , TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS')                                                                     AS C_DATE
                      , MAX(mallcnt)                                                                                                AS mallcnt
                      , replace(replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' '),'+',' ')              AS spec
                      , CASE WHEN NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end              AS openexpectflag
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN 
                                  '' 
                             ELSE UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0)) 
                             END                                                                                                    AS condiname      
                      , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN 
                                  NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') 
                             ELSE UDF_MODEL_GROUP_KEYWORD(NVL(MAX(modelno_group),0)) || ' ' || NVL(MAX(BRAND),'') 
                             END                                                                                                    AS KEYWORD        
                      , UDF_CATEGORY_KEYWORD_POPULAR2(MIN(G.modelno))                                                               AS keyword2       
                      , ''                                                                                                          AS BRANDCODE1
                      , ''                                                                                                          AS BRANDCODE2
                      , UDF_RTN_GET_SPECOPT(NVL(modelno_group,G.modelno))                                                           AS SPECOPT        
                      , '@'                                                                                                         AS SERVICE_FLAG
                      , MAX(E.STATUS )                                                                                              AS STATUS          -- Ȯ�� MAX
                      , MAX(E.REGDATE)                                                                                              AS REGDATE         -- Ȯ�� MAX
                      , MIN(G.ca_code)                                                                                                AS ca_code
                      , 0                                                                                                           AS pl_no           -- Ȯ�� 
                      , MAX(sale_cnt)                                                                                               AS sale_cnt
                      , CASE WHEN MAX(substr(G.ca_code,0,2)) = '93' then '1' else '0' end                                             AS bookflag 
                      , CASE WHEN MAX(mallcnt) > 0 AND (CASE WHEN NVL(MIN(openexpectflag),'0') = '1' OR  min(c_date) > sysdate  THEN '1' 
                                                             ELSE '0' 
                                                             END) = '0' AND MAX(substr(G.ca_code,0,2)) <> '93' THEN '1' 
                             ELSE '0' 
                             END                                                                                                    AS USEFLAG
                      , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END              AS popular2
                      , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname))                              AS modelnm2
                      , CASE WHEN substr(MAX(g.ca_code),0,4)='0501' THEN 
                                  NVL(MAX(weight)*100,0) 
                             ELSE NVL(MAX(weight)*100,999999)
                             END                                                                                                    AS weight
                      , '@'                                                                                                         AS SC_WEB          -- Ȯ��  UDF_SC_CHECK('0', v_modelno, '1', v_shop_code)
                      , '@'                                                                                                         AS SC_MOBILE       -- Ȯ��  UDF_SC_CHECK('0', v_modelno, '2', v_shop_code)
                      , CASE WHEN MIN(NVL(minprice4,0)) > 0 THEN '1' ELSE '0' end                                                   AS store_flag 
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice4,0)) > 0 THEN 
                                  UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),4) 
                             ELSE MIN(minprice4) 
                             END                                                                                                    AS minprice4
                      , LTRIM(RTRIM(MAX(brand)))                                                                                    AS brand
                      , CASE WHEN MAX(NVL(minprice4,0)) > 0 THEN 
                                  UDF_RTN_GET_DEPT_CA_CODE(MAX(G.modelno)) 
                             ELSE '' 
                             END                                                                                                    AS ca_dept_code   
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice3,0)) > 0 THEN 
                                  UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),3) 
                             ELSE MIN(minprice3) 
                             END                                                                                                    AS minprice3
                      , '@'                                                                                                         AS GOODSBRAND      -- Ȯ��
                      , MAX(minprice3)                                                                                              AS maxprice3
                      , UDF_BBS_NUM_SUM(NVL(modelno_group,G.modelno))                                                               AS bbs_num
                      , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice2,0)) > 0 THEN 
                                  UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),2) 
                             ELSE MIN(minprice2) 
                             END                                                                                                    AS minprice2
                      , NVL(MIN(EXT_CONDI_FLAG),'0')                                                                                AS ext_condi_flag
                  FROM  TBL_GOODS                         G  -- PARTITION ���� ó�� ��� 
                        INNER JOIN      TBL_ES_SEARCH_LOG E ON G.MODELNO   = E.MODELNO  AND E.SL_APPLY_FLAG = '2' AND E.SL_APPLY_SID  = P_SID 
                                                                                                                -- 0508 Ȯ�� �ʿ� -> MODELNO �ִ� �� �� ? 
                        LEFT OUTER JOIN TBL_GOODS_SUM     M ON G.MODELNO   = M.MODELNO                          -- 0508 Ȯ�� �ʿ� 
                        LEFT OUTER JOIN TBL_CATE_GOODS    C ON G.MODELNO   = C.MODELNO  AND C.CATEFLAG = '0'    -- 0508 Ȯ�� �ʿ� 
                  WHERE jobcode >= '1'
                    AND (constrain = '1' OR (constrain = '5' AND mallcnt > 0))
                    AND  cateflag ='0'
                  GROUP BY nvl(modelno_group,G.modelno)
                --ORDER BY E.REGDATE                                                                            -- 0510 Ȯ�� : ORDER BY or DISTINCT MODELNO, TBL_PRICELIST�� 
                  ;

                  --------------------------------------------------------------------------------------------------------------------------------------------
                  -- 2.�۾����(TBL_ES_SEARCH_LOG) ���̺� �۾��Ϸ� FLAG UPDATE
                  --------------------------------------------------------------------------------------------------------------------------------------------
                  IF SQL%ROWCOUNT >= 1 THEN

                     UPDATE TBL_ES_SEARCH_LOG
                        SET SL_APPLY_FLAG   = '3'
                        --, SL_APPLY_E_DATE = SYSDATE OR SYSTIMESTAMP
                      WHERE SL_APPLY_FLAG   = '2'
                        AND SL_APPLY_SID    = P_SID;    -- 0508 index �߰� ����
                    
                     IF SQL%ROWCOUNT >= 1 THEN
                        COMMIT;
                     ELSE
                        ROLLBACK;
                     END IF;   

                  END IF; 

            END;
         END IF;
    END;

END;
