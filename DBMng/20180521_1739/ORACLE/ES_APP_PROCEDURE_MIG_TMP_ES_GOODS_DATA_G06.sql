/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_ES_GOODS_DATA_G06
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-10 12:20:48
 *        Modify: 2018-04-10 12:20:48
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_ES_GOODS_DATA_G06" 
IS

EXE_SQL VARCHAR2(30000)   := '';
V_PARTITION_NO  NUMBER(3) := 1 ;

BEGIN

       FOR RST IN
       ( 
           SELECT PARTITION_NAME
                , PARTITION_POSITION
                , TO_CHAR(PARTITION_POSITION) AS PARTITION_NO
           FROM   ALL_TAB_PARTITIONS 
           WHERE  TABLE_NAME = 'ASIS_TBL_GOODS' 
           AND  ( PARTITION_NAME LIKE 'P06%'
           OR     PARTITION_NAME LIKE 'P07%'
           OR     PARTITION_NAME LIKE 'P08%'
           OR     PARTITION_NAME LIKE 'P09%'
           OR     PARTITION_NAME LIKE 'P10%' )
           ORDER BY PARTITION_POSITION
       )
       LOOP
  
       EXE_SQL := 'INSERT /*+ APPEND NOLOGGING */ INTO ES_APP.TMP_ES_GOODS_DATA_01 PARTITION FOR ('||TO_CHAR(V_PARTITION_NO)||')
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
                   ,MINPRICE5        ,EXT_CONDI_FLAG   ,MOD_NO           ,PARTITION_NO
                   ) '
       ||
       'SELECT /*+ PARALLEL(3) */
               ''G'' || NVL(modelno_group,modelno)                                                                                                                                                                                  AS ID
             , NVL(modelno_group,modelno)                                                                                                                                                                                           AS modelno
             , 0                                                                                                                                                                                                                    AS pl_no
             , CASE WHEN MAX(modelno_group) IS NULL OR NVL(MAX(modelno_group),0)=0 THEN ''0'' ELSE ''1'' END                                                                                                                        AS modelno_group
             , NVL(UDF_RTN_GET_CATEGORY3(NVL(modelno_group,modelno)), '' '')                                                                                                                                                        AS category                   --수정필요
             , MIN(ca_code)                                                                                                                                                                                                         AS ca_code
             , CASE WHEN MAX(NVL(minprice4,0)) > 0 THEN UDF_RTN_GET_DEPT_CA_CODE(MAX(modelno)) ELSE '''' END                                                                                                                        AS ca_dept_code               --수정필요
             , SUBSTR(MIN(ca_code),0,2)                                                                                                                                                                                             AS ca_lcode_ran
             , SUBSTR(MIN(ca_code),0,4)                                                                                                                                                                                             AS ca_mcode_ran
             , SUBSTR(MIN(ca_code),0,6)                                                                                                                                                                                             AS ca_scode_ran
             , SUBSTR(MIN(ca_code),0,8)                                                                                                                                                                                             AS ca_dcode_ran
             , MAX(replace(replace(modelnm,replace(condiname,''.'',''''),''''),''[]'',''''))                                                                                                                                        AS modelnm
             , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || ''~!@'' || condiname))                                                                                                                                     AS modelnm2
             ,  0                                                                                                                                                                                                                   AS shop_code
             , ''''                                                                                                                                                                                                                 AS shop_name
             , ''''                                                                                                                                                                                                                 AS shop_name_code
             , LTRIM(RTRIM(MAX(factory)))                                                                                                                                                                                           AS factory
             , LTRIM(RTRIM(MAX(brand)))                                                                                                                                                                                             AS brand
             , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END                                                                                                                       AS popular
             , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END                                                                                                                       AS popular2
             , MAX(sale_cnt)                                                                                                                                                                                                        AS sale_cnt
             , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || ''~!@'' || condiname))                                                                                                                                     AS model_factory
             , CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice) ELSE UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) END                                                                 AS minprice                   --수정필요
             , MAX(minprice)                                                                                                                                                                                                        AS maxprice
             , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN MIN(minprice) || '''' ELSE UDF_MODEL_GROUP_MINPRICE(NVL(MAX(modelno_group),0)) END                                                                                      AS minprices                  --수정필요
             , TO_CHAR(MIN(C_DATE),''YYYYMMDDHH24MISS'')                                                                                                                                                                            AS C_DATE
             , MAX(mallcnt)                                                                                                                                                                                                         AS mallcnt
             , replace(replace(replace(replace(replace(MAX(spec),''/'','' ''),'','','' ''),''('','' ''),'')'','' ''),''+'','' '')                                                                                                   AS spec
             , case when NVL(MIN(openexpectflag),''0'')  = ''1'' or  min(c_date) > sysdate  then ''1'' else ''0'' end                                                                                                               AS openexpectflag
             , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN '''' ELSE UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0)) END                                                                                                      AS condiname                  --수정필요
             , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN NVL(MAX(KEYWORD), '''') || '' '' || NVL(MAX(BRAND),'''') ELSE UDF_MODEL_GROUP_KEYWORD(NVL(MAX(modelno_group),0)) || '' '' || NVL(MAX(BRAND),'''') END                   AS KEYWORD                    --수정필요
             , UDF_CATEGORY_KEYWORD_POPULAR2(MIN(modelno))                                                                                                                                                                          AS keyword2                   --수정필요
             , ''''                                                                                                                                                                                                                 AS BRANDCODE1
             , ''''                                                                                                                                                                                                                 AS BRANDCODE2
             , UDF_RTN_GET_SPECOPT(NVL(modelno_group,modelno))                                                                                                                                                                      AS SPECOPT                    --수정필요
             , CASE WHEN MAX(substr(ca_code,0,2)) = ''93'' then ''1'' else ''0'' end                                                                                                                                                AS bookflag 
             , CASE WHEN  MAX(mallcnt) > 0 and   (case when NVL(MIN(openexpectflag),''0'')  = ''1'' or  min(c_date) > sysdate  then ''1'' else ''0'' end) = ''0'' and MAX(substr(ca_code,0,2)) <> ''93'' then ''1'' else ''0'' end  AS useflag
             , CASE WHEN substr(MAX(ca_code),0,4)=''0501'' then NVL(MAX(weight)*100,0) else NVL(MAX(weight)*100,999999) end                                                                                                         AS weight
             , NVL(MIN(socialprice),0)                                                                                                                                                                                              AS socialprice
             , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice3,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),3) ELSE MIN(minprice3) END                                                                AS minprice3
             , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice2,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),2) ELSE MIN(minprice2) END                                                                AS minprice2
             , MAX(minprice3)                                                                                                                                                                                                       AS maxprice3
             , ''1''                                                                                                                                                                                                                AS mobile_flag
             , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice4,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),4) ELSE MIN(minprice4) END                                                                AS minprice4
             , CASE WHEN MIN(NVL(minprice4,0)) > 0 then ''1'' else ''0'' end                                                                                                                                                        AS store_flag 
             , UDF_BBS_NUM_SUM(NVL(modelno_group,modelno))                                                                                                                                                                          AS bbs_num
             , ''1''                                                                                                                                                                                                                AS zum_check
             , ''1''                                                                                                                                                                                                                AS service_gubun
             , UDF_MODEL_GROUP_MINPRICE_ETC(NVL(MAX(modelno_group),0),5)                                                                                                                                                            AS minprice5                  --수정필요
             , NVL(MIN(EXT_CONDI_FLAG),''0'')                                                                                                                                                                                       AS ext_condi_flag
             , mod(nvl(modelno_group,modelno), 6)                                                                                                                                                                                   AS MOD_NO
             , :PARTITION_NO
         from  tbl_goods A
        WHERE  jobcode>=''1''
          AND (constrain = ''1'' OR (constrain = ''5'' AND mallcnt > 0))
          AND  cateflag =''0''
        GROUP BY nvl(modelno_group,modelno)
        ';
     
        EXECUTE IMMEDIATE EXE_SQL USING V_PARTITION_NO;
     
        COMMIT;

       END LOOP;       
     
       COMMIT;

/*EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;*/
END;
