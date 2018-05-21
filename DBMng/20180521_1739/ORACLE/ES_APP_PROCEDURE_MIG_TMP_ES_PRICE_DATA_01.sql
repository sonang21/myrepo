/* *************************************************************************
 * NAME : ES_APP.MIG_TMP_ES_PRICE_DATA_01
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-06 13:24:08
 *        Modify: 2018-04-06 13:50:22
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ES_APP"."MIG_TMP_ES_PRICE_DATA_01" 
IS

REC_CNT             number(20)       :=  0;

v_ID                VARCHAR2(2000)   := '';
v_modelno           number(20)       :=  0;
v_pl_no             number(20)       :=  0;
v_modelno_group     VARCHAR2(2000)   := '';
v_category          VARCHAR2(2000)   := '';
v_ca_code           VARCHAR2(2000)   := '';
v_ca_dept_code      VARCHAR2(2000)   := '';
v_ca_lcode_ran      VARCHAR2(2000)   := '';
v_ca_mcode_ran      VARCHAR2(2000)   := '';
v_ca_scode_ran      VARCHAR2(2000)   := '';
v_ca_dcode_ran      VARCHAR2(2000)   := '';
v_modelnm           VARCHAR2(2000)   := '';
v_modelnm2          VARCHAR2(2000)   := '';
v_shop_code         number(20)       := ''; -- 
v_shop_name         VARCHAR2(2000)   := '';
v_shop_name_code    VARCHAR2(2000)   := '';
v_factory           VARCHAR2(2000)   := '';
v_brand             VARCHAR2(2000)   := '';
v_popular           number(20)       :=  0;
v_popular2          number(20)       :=  0;
v_sale_cnt          number(20)       :=  0;
v_model_factory     VARCHAR2(2000)   := '';
v_minprice          number(20)       :=  0;
v_maxprice          number(20)       :=  0;
v_minprices         VARCHAR2(2000)   := '';
v_C_DATE            VARCHAR2(2000)   := '';
v_mallcnt           number(20)       :=  0;
v_spec              VARCHAR2(2000)   := '';
v_openexpectflag    VARCHAR2(2000)   := '';
v_condiname         VARCHAR2(2000)   := '';
v_KEYWORD           VARCHAR2(2000)   := '';
v_keyword2          VARCHAR2(2000)   := '';
v_BRANDCODE1        VARCHAR2(2000)   := '';
v_BRANDCODE2        VARCHAR2(2000)   := '';
v_SPECOPT           VARCHAR2(2000)   := '';
v_bookflag          VARCHAR2(2000)   := '';
v_useflag           VARCHAR2(2000)   := '';
v_weight            number(20)       :=  0;
v_socialprice       number(20)       :=  0;
v_minprice3         number(20)       :=  0;
v_minprice2         number(20)       :=  0;
v_maxprice3         number(20)       :=  0;
v_mobile_flag       VARCHAR2(2000)   := '';
v_minprice4         number(20)       :=  0;
v_store_flag        VARCHAR2(2000)   := '';
v_bbs_num           number(20)       :=  0;
v_zum_check         VARCHAR2(2000)   := '';
v_service_gubun     VARCHAR2(2000)   := '';
v_minprice5         number(20)       :=  0;
v_ext_condi_flag    VARCHAR2(2000)   := '';

CURSOR DATA IS 
SELECT /*+ PARALLEL(P,5) use_HASH(p,g,s) index(p,asis_idx_pl_no) */
       'P' || P.pl_no                                                                                                                                                                                           AS ID                                    
     , P.pl_no                                                                                                                                                                                                  AS modelno                               
     , P.PL_NO                                                                                                                                                                                                  AS pl_no                                 
     , '0'                                                                                                                                                                                                      AS modelno_group                         
     , CASE WHEN P.CA_CODE IS NULL THEN '000000' WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || '0000' WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' ELSE P.CA_CODE END              AS category                   --수정필요 
     , CASE WHEN P.CA_CODE IS NULL THEN '000000' WHEN LENGTH(RTRIM(P.CA_CODE))=2 THEN RTRIM( P.CA_CODE) || '0000' WHEN LENGTH(RTRIM(P.CA_CODE))=4 THEN RTRIM(P.CA_CODE) || '00' ELSE P.CA_CODE END              AS ca_code                               
     , CASE WHEN store_flag='1' THEN ca_code_dept ELSE '' END                                                                                                                                                   AS ca_dept_code               --수정필요 
     , ''                                                                                                                                                                                                       AS ca_lcode_ran                          
     , ''                                                                                                                                                                                                       AS ca_mcode_ran                          
     , ''                                                                                                                                                                                                       AS ca_scode_ran                          
     , ''                                                                                                                                                                                                       AS ca_dcode_ran                          
     , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '9501' then UDF_GOODSNM_REMOVE(P.goodsnm) || ' 음반 앨범' else UDF_GOODSNM_REMOVE(P.goodsnm) end                                                                       AS modelnm                               
     , CASE WHEN SUBSTR(P.CA_CODE,0,4) = '1219' THEN UDF_GOODSNM_REMOVE(P.goodsnm) ELSE '' END                                                                                                                  AS modelnm2                              
     , P.shop_code                                                                                                                                                                                              AS shop_code                             
     , S.shop_name                                                                                                                                                                                              AS shop_name                             
     , ''                                                                                                                                                                                                       AS shop_name_code                        
     , '[추가]'                                                                                                                                                                                                 AS factory                               
     , '기타'                                                                                                                                                                                                   AS brand                                 
     , NVL(P.POPULAR,0)                                                                                                                                                                                         AS popular                               
     , NVL(P.POPULAR,0)                                                                                                                                                                                         AS popular2                              
     , sale_cnt                                                                                                                                                                                                 AS sale_cnt                              
     , ''                                                                                                                                                                                                       AS model_factory                         
     , P.price                                                                                                                                                                                                  AS minprice                   --수정필요 
     , P.price                                                                                                                                                                                                  AS maxprice                              
     , P.price || ' '                                                                                                                                                                                           AS minprices                  --수정필요 
     , TO_CHAR(P.U_DATE,'YYYYMMDDHH24MISS')                                                                                                                                                                     AS C_DATE                                
     , 1                                                                                                                                                                                                        AS mallcnt                               
     , ' '                                                                                                                                                                                                      AS spec                                  
     , '0'                                                                                                                                                                                                      AS openexpectflag                        
     , ' '                                                                                                                                                                                                      AS condiname                  --수정필요 
     , ' '                                                                                                                                                                                                      AS KEYWORD                    --수정필요 
     , ' '                                                                                                                                                                                                      AS keyword2                   --수정필요 
     , ' '                                                                                                                                                                                                      AS BRANDCODE1                            
     , ' '                                                                                                                                                                                                      AS BRANDCODE2                            
     , ' '                                                                                                                                                                                                      AS SPECOPT                    --수정필요 
     , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' then '1' else '0' end                                                                                                                                             AS bookflag                              
     , CASE WHEN SUBSTR(P.CA_CODE,0,2) = '93' then '0' else '1' end                                                                                                                                             AS useflag                               
     , 0                                                                                                                                                                                                        AS weight                                
     , 0                                                                                                                                                                                                        AS socialprice                           
     , (case when NVL(instance_price,0) = 0 then price else case when instance_price < price then instance_price else price end end)                                                                            AS minprice3                             
     , CASE WHEN deliverytype2=0 THEN (price + 2500) ELSE (price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END                                                                           AS minprice2                             
     , NVL(instance_price,0)                                                                                                                                                                                    AS maxprice3                             
     , CASE WHEN NVL(instance_price,0) = 0 then '0' else '1' end                                                                                                                                                AS mobile_flag                           
     , CASE WHEN NVL(store_flag,'0')='1' THEN price ELSE 0 END                                                                                                                                                  AS minprice4                             
     , NVL(store_flag,'0')                                                                                                                                                                                      AS store_flag                            
     , 0                                                                                                                                                                                                        AS bbs_num                               
   --, UDF_ZUM_CHECK(P.shop_code)                                                                                                                                                                               AS zum_check                             
     , CASE WHEN S.SHOP_TYPE = '4' OR S.SHOP_CODE=7861 THEN '0' ELSE '1' END                                                                                                                                    AS zum_check
     , '2'                                                                                                                                                                                                      AS service_gubun                         
     , P.price                                                                                                                                                                                                  AS minprice5                  --수정필요 
     , '0'                                                                                                                                                                                                      AS ext_condi_flag                        
FROM   TBL_PRICELIST P
  INNER JOIN TBL_SHOPLIST S
  ON P.SHOP_CODE = S.SHOP_CODE
  LEFT OUTER JOIN TBL_GOODS G
  ON P.MODELNO = G.MODELNO AND G.CATEFLAG='0'
WHERE  P.SRVFLAG in ('0','L','R','Z','2','3','6','7','9','O','D','S','P')
--AND  P.PL_NO LIKE '1%'
AND (
      P.modelno<=0
      OR ( G.CONSTRAIN='1' AND G.JOBCODE = '0' )
      OR ( G.CONSTRAIN IS NULL AND G.JOBCODE IS NULL )
      OR G.CONSTRAIN IN ('2','3')
      OR (P.option_flag2='1' AND G.minprice < P.price)
      OR P.SRVFLAG IN ('Z','2','3','6','7','9','O','D','P')
    ) 
;

BEGIN

     REC_CNT := 0;

     OPEN DATA;    
     
     LOOP FETCH DATA INTO  v_ID             
                          ,v_modelno        
                          ,v_pl_no          
                          ,v_modelno_group  
                          ,v_category       
                          ,v_ca_code        
                          ,v_ca_dept_code   
                          ,v_ca_lcode_ran   
                          ,v_ca_mcode_ran   
                          ,v_ca_scode_ran   
                          ,v_ca_dcode_ran   
                          ,v_modelnm        
                          ,v_modelnm2       
                          ,v_shop_code      
                          ,v_shop_name      
                          ,v_shop_name_code 
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
                          ,v_socialprice    
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
                          ;
          EXIT WHEN DATA%NOTFOUND;

          REC_CNT := REC_CNT + 1 ;
          
          INSERT INTO ES_APP.TMP_ES_PRICE_DATA_01
                         ( ID             
                          ,modelno        
                          ,pl_no          
                          ,modelno_group  
                          ,category       
                          ,ca_code        
                          ,ca_dept_code   
                          ,ca_lcode_ran   
                          ,ca_mcode_ran   
                          ,ca_scode_ran   
                          ,ca_dcode_ran   
                          ,modelnm        
                          ,modelnm2       
                          ,shop_code      
                          ,shop_name      
                          ,shop_name_code 
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
                          ,socialprice    
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
                          )
                   VALUES( v_ID             
                          ,v_modelno        
                          ,v_pl_no          
                          ,v_modelno_group  
                          ,v_category       
                          ,v_ca_code        
                          ,v_ca_dept_code   
                          ,v_ca_lcode_ran   
                          ,v_ca_mcode_ran   
                          ,v_ca_scode_ran   
                          ,v_ca_dcode_ran   
                          ,v_modelnm        
                          ,v_modelnm2       
                          ,v_shop_code      
                          ,v_shop_name      
                          ,v_shop_name_code 
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
                          ,v_socialprice    
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
                          )
                          ;
                          
         IF REC_CNT >= 1000 THEN 
            COMMIT;
            REC_CNT := 0;
         END IF;
         
     END LOOP
     
     COMMIT;

EXCEPTION 
WHEN OTHERS THEN
     ROLLBACK;
END;
