/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_PRICE_DATA_03
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-06 10:34:52
 *        Modify: 2018-04-06 10:34:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_PRICE_DATA_03" 
IS

REC_CNT                  number(20)        :=0;

v_ID                     VARCHAR2(2000)   ;
v_modelno                number(20)        ;
v_pl_no                  number(20)        ;
v_modelno_group          VARCHAR2(2000)   ;
v_MODELNO_GROUP_FLAG     number(10)        ;
v_category               VARCHAR2(2000)   ;
v_CG                     VARCHAR2(2000)   ;
v_CAT1                   VARCHAR2(2000)   ;
v_CAT2                   VARCHAR2(2000)   ;
v_CAT3                   VARCHAR2(2000)   ;
v_CAT4                   VARCHAR2(2000)   ;
v_ca_code                VARCHAR2(2000)   ;
v_ca_dept_mcode          VARCHAR2(2000)   ;
v_ca_dept_code           VARCHAR2(2000)   ;
v_ca_dept_dcode          VARCHAR2(2000)   ;
v_ca_lcode_ran           VARCHAR2(2000)   ;
v_ca_mcode_ran           VARCHAR2(2000)   ;
v_ca_scode_ran           VARCHAR2(2000)   ;
v_ca_dcode_ran           VARCHAR2(2000)   ;
v_shop_code              number(20)       ;
v_shop_name              VARCHAR2(2000)   ;
v_shop_name_code         VARCHAR2(2000)   ;
v_modelnm                VARCHAR2(2000)   ;
v_modelnm2               VARCHAR2(2000)   ;
v_factory                VARCHAR2(2000)   ;
v_brand                  VARCHAR2(2000)   ;
v_popular                number(20)       ;
v_popular2               number(20)       ;
v_sale_cnt               number(20)       ;
v_model_factory          VARCHAR2(2000)   ;
v_minprice               number(20)       ;
v_maxprice               number(20)       ;
v_minprices              VARCHAR2(2000)   ;
v_C_DATE                 VARCHAR2(2000)   ;
v_mallcnt                number(20)       ;
v_MALLCNT_FLAG           number(10)        ;
v_spec                   VARCHAR2(2000)   ;
v_openexpectflag         VARCHAR2(2000)   ;
v_condiname              VARCHAR2(2000)   ;
v_KEYWORD                VARCHAR2(2000)   ;
v_keyword2               VARCHAR2(2000)   ;
v_BRANDCODE1             VARCHAR2(2000)   ;
v_BRANDCODE2             VARCHAR2(2000)   ;
v_SPECOPT                VARCHAR2(2000)   ;
v_bookflag               VARCHAR2(2000)   ;
v_useflag                VARCHAR2(2000)   ;
v_weight                 number(20)       ;
v_minprice3              number(20)       ;
v_minprice2              number(20)       ;
v_maxprice3              number(20)       ;
v_mobile_flag            VARCHAR2(2000)   ;
v_minprice4              number(20)       ;
v_store_flag             VARCHAR2(2000)   ;
v_bbs_num                number(20)       ;
v_zum_check              VARCHAR2(2000)   ;
v_service_gubun          VARCHAR2(2000)   ;
v_minprice5              number(20)       ;
v_ext_condi_flag         VARCHAR2(2000)   ;
v_to_all                 VARCHAR2(4000)   ;

CURSOR DATA IS 
select
    ID,
    modelno,
    pl_no,
    modelno_group,
    DECODE(NVL(MODELNO_GROUP,0),0,0,1) AS MODELNO_GROUP_FLAG,
    UDF_CATEGORY_ALL(CATEGORY) AS category,
    CASE WHEN SERVICE_GUBUN = 1 THEN UDF_CATEGORY_SUB(CATEGORY,4) ELSE UDF_CATEGORY_SUB(CATEGORY,2) END AS CG,
    UDF_CATEGORY_SUB(CATEGORY,2) AS CAT1,
    UDF_CATEGORY_SUB(CATEGORY,4) AS CAT2,
    UDF_CATEGORY_SUB(CATEGORY,2) AS CAT3,
    UDF_CATEGORY_SUB(CATEGORY,2) AS CAT4,
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
    CASE WHEN SERVICE_GUBUN = 1 THEN REPLACE(MODELNM || ' ' || FACTORY, '-', '') ELSE '' END AS model_factory,
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
    MODELNM || ' ' || FACTORY || ' ' || SPEC || ' ' || KEYWORD || ' ' || KEYWORD2 || ' ' || CONDINAME AS to_all
from (

select    /*+ PARALLEL(A, 3) */
    ID,
    modelno,
    pl_no,
    modelno_group,
    CASE WHEN service_gubun='2' AND store_flag='1' AND ca_dept_code IS NOT NULL THEN RTRIM(category || ' '  || ca_dept_code) ELSE category END AS category,
    ca_code,
    CASE WHEN SUBSTR(RTRIM(ca_dept_code),3,8)='000000' OR SUBSTR(RTRIM(ca_dept_code),3,8) IS NULL THEN '' ELSE SUBSTR(RTRIM(ca_dept_code),0,4) END AS ca_dept_mcode,
    CASE WHEN SUBSTR(RTRIM(ca_dept_code),5,8)='0000' OR SUBSTR(RTRIM(ca_dept_code),5,8) IS NULL THEN '' ELSE SUBSTR(RTRIM(ca_dept_code),0,6) END AS ca_dept_code,
    CASE WHEN SUBSTR(RTRIM(ca_dept_code),7,8)='00' OR SUBSTR(RTRIM(ca_dept_code),7,8) IS NULL THEN '' ELSE SUBSTR(RTRIM(ca_dept_code),0,8) END AS ca_dept_dcode,
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
    replace(minprices, ' ', '    ') as minprices,
    C_DATE,
    mallcnt,
    replace(replace(spec,',',' '),'/',' ') spec,
    openexpectflag,
    replace(condiname, ' ', '    ') as condiname,
    CASE WHEN socialprice=0 THEN keyword ELSE keyword || ' ' || UDF_SOCIAL_GOODSNM(modelno_group,modelno) END AS KEYWORD,
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
    ext_condi_flag
FROM (
    SELECT /*+ PARALLEL(P,5) use_nl(p,g,s) index(p,asis_idx_pl_no) */
    'P' || P.pl_no ID,
    P.pl_no MODELNO,
    P.PL_NO pl_no,
    '0' modelno_group,
    CASE WHEN P.CA_CODE IS NULL THEN '000000' WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || '0000' WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' ELSE P.CA_CODE END AS CATEGORY,
    CASE WHEN P.CA_CODE IS NULL THEN '000000' WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || '0000' WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' ELSE P.CA_CODE END AS CA_CODE,
    CASE WHEN store_flag='1' THEN ca_code_dept ELSE '' END AS ca_dept_code,
    '' AS ca_lcode_ran,
    '' AS ca_mcode_ran,
    '' AS ca_scode_ran,
    '' AS ca_dcode_ran,
    CASE WHEN SUBSTR(P.CA_CODE,0,4) = '9501' then UDF_GOODSNM_REMOVE(P.goodsnm) || ' 음반 앨범' else UDF_GOODSNM_REMOVE(P.goodsnm) end as modelnm ,
    CASE WHEN SUBSTR(P.CA_CODE,0,4) = '1219' THEN UDF_GOODSNM_REMOVE(P.goodsnm) ELSE '' END AS modelnm2,
    P.shop_code,
    S.shop_name,
    '' as shop_name_code,
    '[추가]' factory,
    '기타' brand,
    NVL(P.POPULAR,0) AS POPULAR,
    NVL(P.POPULAR,0) AS POPULAR2,
        sale_cnt,
    '' model_factory,
    P.price minprice,
    P.price maxprice,
    P.price || ' ' minprices,
    TO_CHAR(P.U_DATE,'YYYYMMDDHH24MISS') AS C_DATE,
    1 mallcnt,
    ' ' spec,
    '0' openexpectflag,
    ' ' condiname,
    ' ' keyword,
    ' ' keyword2,
    ' ' brandcode1,
    ' ' brandcode2,
    ' ' specopt,
    CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' then '1' else '0' end as bookflag ,
    CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' then '0' else '1' end as useflag,
    0 weight,
    0 socialprice,
    (case when NVL(instance_price,0) = 0 then price else case when instance_price < price then instance_price else price end end) minprice3,
    CASE WHEN deliverytype2=0 THEN (price + 2500) ELSE (price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END minprice2,
    NVL(instance_price,0) maxprice3,
    CASE WHEN NVL(instance_price,0) = 0 then '0' else '1' end as mobile_flag,
    CASE WHEN NVL(store_flag,'0')='1' THEN price ELSE 0 END AS minprice4,
    NVL(store_flag,'0') store_flag,
    0 bbs_num,
    UDF_ZUM_CHECK(P.shop_code) zum_check,
    '2' service_gubun,
    P.price minprice5,
    '0' as ext_condi_flag
    FROM   TBL_PRICELIST P
      INNER JOIN TBL_SHOPLIST S
      ON P.SHOP_CODE = S.SHOP_CODE
      LEFT OUTER JOIN TBL_GOODS G
      ON P.MODELNO = G.MODELNO AND G.CATEFLAG='0'
    WHERE  P.SRVFLAG in ('0','L','R','Z','2','3','6','7','9','O','D','S','P')
    AND SUBSTR(P.CA_CODE,0,2) in ('86', '02', '14')
    AND P.PL_NO LIKE '3%'
    AND (
      P.modelno<=0
      OR ( G.CONSTRAIN='1' AND G.JOBCODE = '0' )
      OR ( G.CONSTRAIN IS NULL AND G.JOBCODE IS NULL )
      OR G.CONSTRAIN IN ('2','3')
      OR (P.option_flag2='1' AND G.minprice < P.price)
      OR P.SRVFLAG IN ('Z','2','3','6','7','9','O','D','P')
    ) 
 ) A
-- WHERE ROWNUM <= 1000

);


BEGIN

     REC_CNT := 0;

     OPEN DATA;     
     
     LOOP FETCH DATA INTO  v_ID                     
                          ,v_modelno                
                          ,v_pl_no                  
                          ,v_modelno_group          
                          ,v_MODELNO_GROUP_FLAG     
                          ,v_category               
                          ,v_CG                     
                          ,v_CAT1                   
                          ,v_CAT2                   
                          ,v_CAT3                   
                          ,v_CAT4                   
                          ,v_ca_code                
                          ,v_ca_dept_mcode          
                          ,v_ca_dept_code           
                          ,v_ca_dept_dcode          
                          ,v_ca_lcode_ran           
                          ,v_ca_mcode_ran           
                          ,v_ca_scode_ran           
                          ,v_ca_dcode_ran           
                          ,v_shop_code              
                          ,v_shop_name              
                          ,v_shop_name_code         
                          ,v_modelnm                
                          ,v_modelnm2               
                          ,v_factory                
                          ,v_brand                  
                          ,v_popular                
                          ,v_popular2               
                          ,v_sale_cnt               
                          ,v_model_factory          
                          ,v_minprice               
                          ,v_maxprice               
                          ,v_minprices              
                          ,v_C_DATE                 
                          ,v_mallcnt                
                          ,v_MALLCNT_FLAG           
                          ,v_spec                   
                          ,v_openexpectflag         
                          ,v_condiname              
                          ,v_KEYWORD                
                          ,v_keyword2               
                          ,v_BRANDCODE1             
                          ,v_BRANDCODE2             
                          ,v_SPECOPT                
                          ,v_bookflag               
                          ,v_useflag                
                          ,v_weight                 
                          ,v_minprice3              
                          ,v_minprice2              
                          ,v_maxprice3              
                          ,v_mobile_flag            
                          ,v_minprice4              
                          ,v_store_flag             
                          ,v_bbs_num                
                          ,v_zum_check              
                          ,v_service_gubun          
                          ,v_minprice5              
                          ,v_ext_condi_flag         
                          ,v_to_all        ;
          EXIT WHEN DATA%NOTFOUND;

          REC_CNT := REC_CNT + 1 ;
          
          INSERT INTO ES_APP.TMP_PRICE_DATA_03
                         ( ID                     
                          ,modelno                
                          ,pl_no                  
                          ,modelno_group          
                          ,MODELNO_GROUP_FLAG     
                          ,category               
                          ,CG                     
                          ,CAT1                   
                          ,CAT2                   
                          ,CAT3                   
                          ,CAT4                   
                          ,ca_code                
                          ,ca_dept_mcode          
                          ,ca_dept_code           
                          ,ca_dept_dcode          
                          ,ca_lcode_ran           
                          ,ca_mcode_ran           
                          ,ca_scode_ran           
                          ,ca_dcode_ran           
                          ,shop_code              
                          ,shop_name              
                          ,shop_name_code         
                          ,modelnm                
                          ,modelnm2               
                          ,factory                
                          ,brand                  
                          ,popular                
                          ,popular2               
                          ,sale_cnt               
                          ,model_factory          
                          ,minprice               
                          ,maxprice               
                          ,minprices              
                          ,C_DATE                 
                          ,mallcnt                
                          ,MALLCNT_FLAG           
                          ,spec                   
                          ,openexpectflag         
                          ,condiname              
                          ,KEYWORD                
                          ,keyword2               
                          ,BRANDCODE1             
                          ,BRANDCODE2             
                          ,SPECOPT                
                          ,bookflag               
                          ,useflag                
                          ,weight                 
                          ,minprice3              
                          ,minprice2              
                          ,maxprice3              
                          ,mobile_flag            
                          ,minprice4              
                          ,store_flag             
                          ,bbs_num                
                          ,zum_check              
                          ,service_gubun          
                          ,minprice5              
                          ,ext_condi_flag         
                          ,to_all     
                          )
                   VALUES( v_ID                     
                          ,v_modelno                
                          ,v_pl_no                  
                          ,v_modelno_group          
                          ,v_MODELNO_GROUP_FLAG     
                          ,v_category               
                          ,v_CG                     
                          ,v_CAT1                   
                          ,v_CAT2                   
                          ,v_CAT3                   
                          ,v_CAT4                   
                          ,v_ca_code                
                          ,v_ca_dept_mcode          
                          ,v_ca_dept_code           
                          ,v_ca_dept_dcode          
                          ,v_ca_lcode_ran           
                          ,v_ca_mcode_ran           
                          ,v_ca_scode_ran           
                          ,v_ca_dcode_ran           
                          ,v_shop_code              
                          ,v_shop_name              
                          ,v_shop_name_code         
                          ,v_modelnm                
                          ,v_modelnm2               
                          ,v_factory                
                          ,v_brand                  
                          ,v_popular                
                          ,v_popular2               
                          ,v_sale_cnt               
                          ,v_model_factory          
                          ,v_minprice               
                          ,v_maxprice               
                          ,v_minprices              
                          ,v_C_DATE                 
                          ,v_mallcnt                
                          ,v_MALLCNT_FLAG           
                          ,v_spec                   
                          ,v_openexpectflag         
                          ,v_condiname              
                          ,v_KEYWORD                
                          ,v_keyword2               
                          ,v_BRANDCODE1             
                          ,v_BRANDCODE2             
                          ,v_SPECOPT                
                          ,v_bookflag               
                          ,v_useflag                
                          ,v_weight                 
                          ,v_minprice3              
                          ,v_minprice2              
                          ,v_maxprice3              
                          ,v_mobile_flag            
                          ,v_minprice4              
                          ,v_store_flag             
                          ,v_bbs_num                
                          ,v_zum_check              
                          ,v_service_gubun          
                          ,v_minprice5              
                          ,v_ext_condi_flag         
                          ,v_to_all        
                          )
                          ;
                          
         IF REC_CNT >= 1000 THEN 
            COMMIT;
            REC_CNT := 0;
         END IF;
                          
     END LOOP
     
     COMMIT;
     
/*EXCEPTION WHEN OTHERS THEN
  ROLLBACK;*/
END;
