/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_ES_PRICE_DATA_P00
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-11 19:10:24
 *        Modify: 2018-04-23 14:10:05
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_ES_PRICE_DATA_P00" 
( V_PART_NO  NUMBER ,  -- �۾���ȣ(0~5, ��Ƽ�ǹ�ȣ)
  V_PARL_NO  NUMBER    -- PARALLEL ���� 
)
IS

EXE_SQL             VARCHAR2(30000) := '';
V_PARTITION_NAME    VARCHAR2(100)   := '';
V_SUBPARTITION_NAME VARCHAR2(100)   := '';

BEGIN
    
       FOR RST IN
       ( 

           SELECT A.TABLE_NAME                     AS TABLE_NAME
                , A.PARTITION_NAME                 AS PARTITION_NAME
                , B.SUBPARTITION_NAME              AS SUBPARTITION_NAME
                , A.PARTITION_POSITION             AS PARTITION_POSITION
                , B.SUBPARTITION_POSITION          AS SUBPARTITION_POSITION
           FROM   ALL_TAB_PARTITIONS    A
                , ALL_TAB_SUBPARTITIONS B
           WHERE  A.TABLE_NAME     = B.TABLE_NAME(+)
           AND    A.PARTITION_NAME = B.PARTITION_NAME(+)
           AND    A.TABLE_NAME     = 'ASIS_TBL_PRICELIST'
           AND    B.SUBPARTITION_NAME IN( SELECT   SUBPARTITION_NAME
                                            FROM   TMP_ES_PARTITIONS
                                           WHERE   TABLE_NAME = 'ASIS_TBL_PRICELIST'
                                             AND   PART_NO    = V_PART_NO
                                        )
           ORDER BY A.TABLE_NAME
                   ,A.PARTITION_NAME
                   ,B.SUBPARTITION_NAME

       )  
       LOOP
         
       V_PARTITION_NAME    := RST.PARTITION_NAME ;
       V_SUBPARTITION_NAME := RST.SUBPARTITION_NAME ;
  
       EXE_SQL := 'INSERT /*+ APPEND NOLOGGING */ INTO ES_APP.TMP_ES_PRICE_DATA_01 PARTITION FOR ('||V_PART_NO||')
                  ( ID               ,MODELNO          ,PL_NO            ,MODELNO_GROUP  
                   ,CATEGORY         ,CA_CODE          ,CA_DEPT_CODE     ,CA_LCODE_RAN   
                   ,CA_MCODE_RAN     ,CA_SCODE_RAN     ,CA_DCODE_RAN     ,MODELNM        
                   ,MODELNM2         ,SHOP_CODE        ,SHOP_NAME        ,SHOP_NAME_CODE 
                   ,FACTORY          ,BRAND            ,POPULAR          ,POPULAR2       
                   ,SALE_CNT         ,MODEL_FACTORY    ,MINPRICE         ,MAXPRICE       
                   ,MINPRICES        ,C_DATE           ,MALLCNT          ,SPEC           
                   ,OPENEXPECTFLAG   ,CONDINAME        ,KEYWORD          ,KEYWORD2       
                   ,BRANDCODE1       ,BRANDCODE2       ,SPECOPT          ,BOOKFLAG       
                   ,USEFLAG          ,WEIGHT           ,SOCIALPRICE      ,MINPRICE3      
                   ,MINPRICE2        ,MAXPRICE3        ,MOBILE_FLAG      ,MINPRICE4      
                   ,STORE_FLAG       ,BBS_NUM          ,ZUM_CHECK        ,SERVICE_GUBUN  
                   ,MINPRICE5        ,EXT_CONDI_FLAG   ,MOD_NO           ,PART_NO 
                   ,PARTITION_NAME
                   ,SUBPARTITION_NAME
                   ) '
       ||
       'SELECT /*+ PARALLEL('||V_PARL_NO||') */
              ''P'' || P.PL_NO                                                                                      AS ID
            , P.PL_NO                                                                                               AS MODELNO
            , P.PL_NO                                                                                               AS PL_NO
            , ''0''                                                                                                 AS MODELNO_GROUP
            , CASE WHEN P.CA_CODE IS NULL          THEN ''000000'' 
                   WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM(P.CA_CODE) || ''0000'' 
                   WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || ''00'' 
                   ELSE P.CA_CODE 
                   END                                                                                              AS CATEGORY
            , CASE WHEN P.CA_CODE IS NULL THEN ''000000'' 
                   WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || ''0000''
                   WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || ''00'' 
                   ELSE P.CA_CODE 
                   END                                                                                              AS CA_CODE
            , CASE WHEN store_flag=''1''           THEN ca_code_dept ELSE '''' 
                   END                                                                                              AS CA_DEPT_CODE
            , ''''                                                                                                  AS CA_LCODE_RAN
            , ''''                                                                                                  AS CA_MCODE_RAN
            , ''''                                                                                                  AS CA_SCODE_RAN
            , ''''                                                                                                  AS CA_DCODE_RAN
            , CASE WHEN SUBSTR(P.CA_CODE,0,4) = ''9501'' THEN UDF_GOODSNM_REMOVE(P.goodsnm) || '' ���� �ٹ�'' 
                                                         ELSE UDF_GOODSNM_REMOVE(P.goodsnm) 
                                                         END                                                        AS MODELNM
            , CASE WHEN SUBSTR(P.CA_CODE,0,4) = ''1219'' THEN UDF_GOODSNM_REMOVE(P.goodsnm) 
                                                         ELSE '''' END                                              AS MODELNM2
            , P.shop_code                                                                                           AS SHOP_CODE
            , S.shop_name                                                                                           AS SHOP_NAME
            , ''''                                                                                                  AS SHOP_NAME_CODE
            , ''[�߰�]''                                                                                            AS FACTORY
            , ''��Ÿ''                                                                                              AS BRAND
            , NVL(P.POPULAR,0)                                                                                      AS POPULAR
            , NVL(P.POPULAR,0)                                                                                      AS POPULAR2
            , sale_cnt                                                                                              AS SALE_CNT
            , ''''                                                                                                  AS MODEL_FACTORY
            , P.price                                                                                               AS MINPRICE
            , P.price                                                                                               AS MAXPRICE
            , P.price || '' ''                                                                                      AS MINPRICES
            , TO_CHAR(P.U_DATE,''YYYYMMDDHH24MISS'')                                                                AS C_DATE
            , 1                                                                                                     AS MALLCNT
            , '' ''                                                                                                 AS SPEC
            , ''0''                                                                                                 AS OPENEXPECTFLAG
            , '' ''                                                                                                 AS CONDINAME
            , '' ''                                                                                                 AS KEYWORD
            , '' ''                                                                                                 AS KEYWORD2
            , '' ''                                                                                                 AS BRANDCODE1
            , '' ''                                                                                                 AS BRANDCODE2
            , '' ''                                                                                                 AS SPECOPT
            , CASE WHEN SUBSTR(P.CA_CODE,0,2) = ''93'' THEN ''1'' ELSE ''0'' END                                    AS BOOKFLAG
            , CASE WHEN SUBSTR(P.CA_CODE,0,2) = ''93'' THEN ''0'' ELSE ''1'' END                                    AS USEFLAG
            , 0                                                                                                     AS WEIGHT
            , 0                                                                                                     AS SOCIALPRICE
            ,(CASE WHEN NVL(instance_price,0) = 0 THEN price 
                   ELSE CASE WHEN instance_price < price THEN instance_price 
                             ELSE price 
                             END 
                   END)                                                                                             AS MINPRICE3
            , CASE WHEN deliverytype2=0 THEN (price + 2500) 
                   ELSE (price + DECODE(deliveryinfo, ''������'', 0, NVL(deliveryinfo2, 2500))) 
                   END                                                                                              AS MINPRICE2
            , NVL(instance_price,0)                                                                                 AS MAXPRICE3
            , CASE WHEN NVL(instance_price,0) = 0   THEN ''0'' ELSE ''1'' END                                       AS MOBILE_FLAG
            , CASE WHEN NVL(store_flag,''0'')=''1'' THEN price ELSE 0 END                                           AS MINPRICE4
            , NVL(store_flag,''0'')                                                                                 AS STORE_FLAG
            , 0                                                                                                     AS BBS_NUM
            , CASE WHEN S.SHOP_TYPE = ''4'' OR S.SHOP_CODE=7861 THEN ''0'' ELSE ''1'' END                           AS ZUM_CHECK
            , ''2''                                                                                                 AS SERVICE_GUBUN
            , P.price                                                                                               AS MINPRICE5
            , ''0''                                                                                                 AS EXT_CONDI_FLAG
            , MOD(nvl(P.PL_NO,0), 6)
            , :PART_NO
            , :PARTITION_NAME   
            , :SUBPARTITION_NAME
       FROM   TBL_PRICELIST SUBPARTITION( '|| RST.SUBPARTITION_NAME ||') P'||
            ' INNER JOIN TBL_SHOPLIST   S ON P.SHOP_CODE = S.SHOP_CODE
              LEFT OUTER JOIN TBL_GOODS G ON P.MODELNO   = G.MODELNO   AND G.CATEFLAG = ''0''
       WHERE  P.SRVFLAG IN (''0'',''L'',''R'',''Z'',''2'',''3'',''6'',''7'',''9'',''O'',''D'',''S'',''P'')
       AND    P.STATUS in (''0'',''8'',''9'')
       AND (P.ca_code IS NOT NULL AND rtrim(P.ca_code) IS NOT NULL)
       AND (
             P.MODELNO <= 0
             OR ( G.CONSTRAIN = ''1'' AND G.JOBCODE = ''0'' )
             OR ( G.CONSTRAIN IS NULL AND G.JOBCODE IS NULL )
             OR   G.CONSTRAIN IN (''2'',''3'')
             OR ( P.OPTION_FLAG2 = ''1'' AND G.minprice < P.PRICE)
             OR   P.SRVFLAG IN (''Z'',''2'',''3'',''6'',''7'',''9'',''O'',''D'',''P'')
           ) 
     ';

     EXECUTE IMMEDIATE EXE_SQL USING V_PART_NO,V_PARTITION_NAME,V_SUBPARTITION_NAME;
     
     COMMIT;

     END LOOP;       
   
     COMMIT;      

/*EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;*/

END;
