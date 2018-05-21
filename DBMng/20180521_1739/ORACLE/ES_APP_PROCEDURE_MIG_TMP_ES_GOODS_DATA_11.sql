/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_ES_GOODS_DATA_11
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-08 15:05:28
 *        Modify: 2018-04-08 15:06:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_ES_GOODS_DATA_11" 
IS

BEGIN
     INSERT INTO /*+ APPEND NOLOGGING */ ES_APP.TMP_ES_GOODS_DATA_11
                  ( ID                ,modelno          ,pl_no             ,modelno_group  
                   ,category          ,ca_code          ,ca_dept_code      ,ca_lcode_ran   
                   ,ca_mcode_ran      ,ca_scode_ran     ,ca_dcode_ran      ,modelnm        
                   ,modelnm2          ,shop_code        ,shop_name         ,shop_name_code 
                   ,factory           ,brand            ,popular           ,popular2       
                   ,sale_cnt          ,model_factory    ,minprice          ,maxprice       
                   ,minprices         ,C_DATE           ,mallcnt           ,spec           
                   ,openexpectflag    ,condiname        ,KEYWORD           ,keyword2       
                   ,BRANDCODE1        ,BRANDCODE2       ,SPECOPT           ,bookflag       
                   ,useflag           ,weight           ,socialprice       ,minprice3      
                   ,minprice2         ,maxprice3        ,mobile_flag       ,minprice4      
                   ,store_flag        ,bbs_num          ,zum_check         ,service_gubun  
                   ,minprice5         ,ext_condi_flag 
                   )
     SELECT /*+ PARALLEL(5) */
            'G' || NVL(modelno_group,modelno)                                                                                                                                                                    AS ID
          , NVL(modelno_group,modelno)                                                                                                                                                                           AS modelno
          , 0                                                                                                                                                                                                    AS pl_no
          , CASE WHEN MAX(modelno_group) IS NULL OR NVL(MAX(modelno_group),0)=0 THEN '0' ELSE '1' END                                                                                                            AS modelno_group
          , NVL(UDF_RTN_GET_CATEGORY3(NVL(modelno_group,modelno)), ' ')                                                                                                                                          AS category                   --수정필요
          , MIN(ca_code)                                                                                                                                                                                         AS ca_code
          , CASE WHEN MAX(NVL(minprice4,0)) > 0 THEN UDF_RTN_GET_DEPT_CA_CODE(MAX(modelno)) ELSE '' END                                                                                                          AS ca_dept_code               --수정필요
          , SUBSTR(MIN(ca_code),0,2)                                                                                                                                                                             AS ca_lcode_ran
          , SUBSTR(MIN(ca_code),0,4)                                                                                                                                                                             AS ca_mcode_ran
          , SUBSTR(MIN(ca_code),0,6)                                                                                                                                                                             AS ca_scode_ran
          , SUBSTR(MIN(ca_code),0,8)                                                                                                                                                                             AS ca_dcode_ran
          , MAX(replace(replace(modelnm,replace(condiname,'.',''),''),'[]',''))                                                                                                                                  AS modelnm
          , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname))                                                                                                                       AS modelnm2
          ,  0                                                                                                                                                                                                   AS shop_code
          , ''                                                                                                                                                                                                   AS shop_name
          , ''                                                                                                                                                                                                   AS shop_name_code
          , LTRIM(RTRIM(MAX(factory)))                                                                                                                                                                           AS factory
          , LTRIM(RTRIM(MAX(brand)))                                                                                                                                                                             AS brand
          , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END                                                                                                       AS popular
          , CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END                                                                                                       AS popular2
          , MAX(sale_cnt)                                                                                                                                                                                        AS sale_cnt
          , UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname))                                                                                                                       AS model_factory
          , CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice) ELSE UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) END                                                 AS minprice                   --수정필요
          , MAX(minprice)                                                                                                                                                                                        AS maxprice
          , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN MIN(minprice) || '' ELSE UDF_MODEL_GROUP_MINPRICE(NVL(MAX(modelno_group),0)) END                                                                        AS minprices                  --수정필요
          , TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS')                                                                                                                                                              AS C_DATE
          , MAX(mallcnt)                                                                                                                                                                                         AS mallcnt
          , replace(replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' '),'+',' ')                                                                                                       AS spec
          , case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end                                                                                                       AS openexpectflag
          , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN '' ELSE UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0)) END                                                                                        AS condiname                  --수정필요
          , CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') ELSE UDF_MODEL_GROUP_KEYWORD(NVL(MAX(modelno_group),0)) || ' ' || NVL(MAX(BRAND),'') END             AS KEYWORD                    --수정필요
          , UDF_CATEGORY_KEYWORD_POPULAR2(MIN(modelno))                                                                                                                                                          AS keyword2                   --수정필요
          , ''                                                                                                                                                                                                   AS BRANDCODE1
          , ''                                                                                                                                                                                                   AS BRANDCODE2
          , UDF_RTN_GET_SPECOPT(NVL(modelno_group,modelno))                                                                                                                                                      AS SPECOPT                    --수정필요
          , CASE WHEN MAX(substr(ca_code,0,2)) = '93' then '1' else '0' end                                                                                                                                      AS bookflag 
          , CASE WHEN  MAX(mallcnt) > 0 and   (case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end) = '0' and MAX(substr(ca_code,0,2)) <> '93' then '1' else '0' end  AS useflag
          , CASE WHEN substr(MAX(ca_code),0,4)='0501' then NVL(MAX(weight)*100,0) else NVL(MAX(weight)*100,999999) end                                                                                           AS weight
          , NVL(MIN(socialprice),0)                                                                                                                                                                              AS socialprice
          , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice3,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),3) ELSE MIN(minprice3) END                                                AS minprice3
          , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice2,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),2) ELSE MIN(minprice2) END                                                AS minprice2
          , MAX(minprice3)                                                                                                                                                                                       AS maxprice3
          , '1'                                                                                                                                                                                                  AS mobile_flag
          , CASE WHEN NVL(MAX(modelno_group),0) > 0 AND MAX(NVL(minprice4,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(MAX(modelno_group),4) ELSE MIN(minprice4) END                                                AS minprice4
          , CASE WHEN MIN(NVL(minprice4,0)) > 0 then '1' else '0' end                                                                                                                                            AS store_flag 
          , UDF_BBS_NUM_SUM(NVL(modelno_group,modelno))                                                                                                                                                          AS bbs_num
          , '1'                                                                                                                                                                                                  AS zum_check
          , '1'                                                                                                                                                                                                  AS service_gubun
          , UDF_MODEL_GROUP_MINPRICE_ETC(NVL(MAX(modelno_group),0),5)                                                                                                                                            AS minprice5                  --수정필요
          , NVL(MIN(EXT_CONDI_FLAG),'0')                                                                                                                                                                         AS ext_condi_flag
      from  tbl_goods A
     WHERE  jobcode>='1'
       AND (constrain = '1' OR (constrain = '5' AND mallcnt > 0))
       AND  cateflag ='0'
     GROUP BY nvl(modelno_group,modelno)
     ;
    
     COMMIT;

/*EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;*/
END;
