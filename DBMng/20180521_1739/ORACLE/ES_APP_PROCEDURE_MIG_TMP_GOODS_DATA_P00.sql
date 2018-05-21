/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_GOODS_DATA_P00
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-15 13:21:14
 *        Modify: 2018-04-15 14:11:41
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_GOODS_DATA_P00" 
( V_MOD_NO  NUMBER ,  -- 6등분 번호(0~5)
  V_PAR_NO  NUMBER    -- PARALLEL 갯수 
)
IS

EXE_SQL             VARCHAR2(30000) := '';

BEGIN



       EXE_SQL := 'INSERT /*+ APPEND NOLOGGING */ INTO ES_APP.TMP_GOODS_DATA_01 PARTITION FOR ('||V_MOD_NO||')
                  ( ID                     
                   ,MODELNO          ,PL_NO            ,MODELNO_GROUP    ,MODELNO_GROUP_FLAG  
                   ,CATEGORY         ,CG               ,CAT1             ,CAT2                
                   ,CAT3             ,CAT4             ,CA_CODE          ,CA_DEPT_MCODE       
                   ,CA_DEPT_CODE     ,CA_DEPT_DCODE    ,CA_LCODE_RAN     ,CA_MCODE_RAN        
                   ,CA_SCODE_RAN     ,CA_DCODE_RAN     ,SHOP_CODE        ,SHOP_NAME           
                   ,SHOP_NAME_CODE   ,MODELNM          ,MODELNM2         ,FACTORY             
                   ,BRAND            ,POPULAR          ,POPULAR2         ,SALE_CNT            
                   ,MODEL_FACTORY    ,MINPRICE         ,MAXPRICE         ,MINPRICES           
                   ,C_DATE           ,MALLCNT          ,MALLCNT_FLAG     ,SPEC                
                   ,OPENEXPECTFLAG   ,CONDINAME        ,KEYWORD          ,KEYWORD2            
                   ,BRANDCODE1       ,BRANDCODE2       ,SPECOPT          ,BOOKFLAG            
                   ,USEFLAG          ,WEIGHT           ,MINPRICE3        ,MINPRICE2           
                   ,MAXPRICE3        ,MOBILE_FLAG      ,MINPRICE4        ,STORE_FLAG          
                   ,BBS_NUM          ,ZUM_CHECK        ,SERVICE_GUBUN    ,MINPRICE5           
                   ,EXT_CONDI_FLAG   ,TO_ALL           ,MOD_NO              
                   ) '
       ||

       'SELECT /*+ PARALLEL('||V_PAR_NO||') */
            ID,
            modelno,
            pl_no,
            modelno_group,
            DECODE(NVL(MODELNO_GROUP,0),0,0,1) AS MODELNO_GROUP_FLAG,
            CATALL AS category,
            CASE WHEN SERVICE_GUBUN = 1 THEN CAT2 ELSE CAT1 END AS CG,
            CAT1,
            CAT2,
            CAT3,
            CAT4,
            ca_code,
            ca_dept_mcode,
            ca_dept_code,
            ca_dept_dcode,
            ca_lcode_ran,
            ca_mcode_ran,
            ca_scode_ran,
            ca_dcode_ran,
            shop_code,
            shop_name,
            shop_name_code,
            modelnm,
            modelnm2,
            factory,
            brand,
            popular,
            popular2,
            sale_cnt,
            CASE WHEN SERVICE_GUBUN = 1 THEN REPLACE(MODELNM || '' '' || FACTORY, ''-'', '''') ELSE '''' END AS model_factory,
            minprice,
            maxprice,
            minprices,
            C_DATE,
            mallcnt,
            DECODE(NVL(MALLCNT,0),0,0,1) AS MALLCNT_FLAG,
            spec,
            openexpectflag,
            condiname,
            KEYWORD,
            keyword2,
            BRANDCODE1,
            BRANDCODE2,
            SPECOPT,
            bookflag,
            useflag,
            weight,
            minprice3,
            minprice2,
            maxprice3,
            mobile_flag,
            minprice4,
            store_flag,
            bbs_num,
            zum_check,
            service_gubun,
            minprice5,
            ext_condi_flag,
            MODELNM || '' '' || FACTORY || '' '' || SPEC || '' '' || KEYWORD || '' '' || KEYWORD2 || '' '' || CONDINAME AS to_all,
            mod_no
        from (
        
        select /*+ PARALLEL(3) */
            ID,
            modelno,
            pl_no,
            modelno_group,
            CASE WHEN service_gubun=''2'' AND store_flag=''1'' AND ca_dept_code IS NOT NULL THEN RTRIM(category || '' ''  || ca_dept_code) ELSE category END AS category,
            ca_code,
            CASE WHEN SUBSTR(RTRIM(ca_dept_code),3,8)=''000000'' OR SUBSTR(RTRIM(ca_dept_code),3,8) IS NULL THEN '''' ELSE SUBSTR(RTRIM(ca_dept_code),0,4) END AS ca_dept_mcode,
            CASE WHEN SUBSTR(RTRIM(ca_dept_code),5,8)=''0000''   OR SUBSTR(RTRIM(ca_dept_code),5,8) IS NULL THEN '''' ELSE SUBSTR(RTRIM(ca_dept_code),0,6) END AS ca_dept_code,
            CASE WHEN SUBSTR(RTRIM(ca_dept_code),7,8)=''00''     OR SUBSTR(RTRIM(ca_dept_code),7,8) IS NULL THEN '''' ELSE SUBSTR(RTRIM(ca_dept_code),0,8) END AS ca_dept_dcode,
            ca_lcode_ran,
            ca_mcode_ran,
            ca_scode_ran,
            ca_dcode_ran,
            shop_code,
            shop_name,
            shop_name_code,
            modelnm,
            modelnm2,
            factory,
            brand,
            popular,
            popular2,
            sale_cnt,
            model_factory,
            minprice,
            maxprice,
            replace(minprices, '' '', ''    '') as minprices,
            C_DATE,
            mallcnt,
            replace(replace(spec,'','','' ''),''/'','' '') spec,
            openexpectflag,
            replace(condiname, '' '', ''    '') as condiname,
            CASE WHEN socialprice=0 THEN keyword ELSE keyword || '' '' || '''' END AS KEYWORD, -- UDF_SOCIAL_GOODSNM(modelno_group,modelno) END AS KEYWORD,
            keyword2,
            BRANDCODE1,
            BRANDCODE2,
            SPECOPT,
            bookflag,
            useflag,
            weight,
            minprice3,
            minprice2,
            maxprice3,
            mobile_flag,
            minprice4,
            store_flag,
            bbs_num,
            zum_check,
            service_gubun,
            minprice5,
            ext_condi_flag,
            mod_no
        FROM (
               SELECT 
                      ID
                    , MODELNO
                    , PL_NO
                    , MODELNO_GROUP
                    , CATEGORY
                    , CA_CODE
                    , CA_DEPT_CODE
                    , CA_LCODE_RAN
                    , CA_MCODE_RAN
                    , CA_SCODE_RAN
                    , CA_DCODE_RAN
                    , MODELNM
                    , MODELNM2
                    , SHOP_CODE
                    , SHOP_NAME
                    , SHOP_NAME_CODE
                    , FACTORY
                    , BRAND
                    , POPULAR
                    , POPULAR2
                    , SALE_CNT
                    , MODEL_FACTORY
                    , MINPRICE
                    , MAXPRICE
                    , MINPRICES
                    , C_DATE
                    , MALLCNT
                    , SPEC
                    , OPENEXPECTFLAG
                    , CONDINAME
                    , KEYWORD
                    , KEYWORD2
                    , BRANDCODE1
                    , BRANDCODE2
                    , SPECOPT
                    , BOOKFLAG
                    , USEFLAG
                    , WEIGHT
                    , SOCIALPRICE
                    , MINPRICE3
                    , MINPRICE2
                    , MAXPRICE3
                    , MOBILE_FLAG
                    , MINPRICE4
                    , STORE_FLAG
                    , BBS_NUM
                    , ZUM_CHECK
                    , SERVICE_GUBUN
                    , MINPRICE5
                    , EXT_CONDI_FLAG
                    , MOD_NO
                FROM  TMP_ES_GOODS_DATA_01
                WHERE MOD_NO = ' ||V_MOD_NO||'
           )
           
         ) A LEFT JOIN ES_APP.TMP_ES_GOODS_CATE_01 B ON (B.CATEGORY = A.CATEGORY) 
     ';

     EXECUTE IMMEDIATE EXE_SQL ;
     
     COMMIT;

/*EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;*/

END;
