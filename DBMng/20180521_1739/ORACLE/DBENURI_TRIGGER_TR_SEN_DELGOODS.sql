/* *************************************************************************
 * NAME : DBENURI.TR_SEN_DELGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-05-11 11:23:20
 *        Modify: 2018-05-21 17:24:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_SEN_DELGOODS" AFTER DELETE ON TBL_GOODS

DECLARE
v_modelno_old          tbl_goods.modelno            %TYPE := 0    ;

v_su_no_tmp            tbl_goods_supply.su_no       %TYPE := 0    ;
v_modelno_tmp          tbl_goods_supply.modelno     %TYPE := 0    ;
v_su_modelno_tmp       tbl_goods_supply.su_modelno  %TYPE := 0    ;

i                      NUMBER(8)                          := 1    ;

CURSOR cur_goodssupply IS
SELECT su_no
     , modelno
     , su_modelno
  FROM TBL_GOODS_SUPPLY
 WHERE modelno    = v_modelno_old 
    OR su_modelno = v_modelno_old;      
            
BEGIN

    LOOP

        IF  i <= pg_Goods_DataLoop.g_index THEN
            v_modelno_old         :=  pg_Goods_DataLoop.v_Modelno_old         (i);

            ------------------------------------------------------------------------------------------------------------------------------------------    
            -- 0502 AND v_cateflag_old='0' 제외 : 확인 필요 
            ------------------------------------------------------------------------------------------------------------------------------------------    
            IF v_modelno_old > 0  THEN
            
                OPEN cur_goodssupply;
                
                LOOP FETCH cur_goodssupply INTO v_su_no_tmp
                                              , v_modelno_tmp
                                              , v_su_modelno_tmp;
                    EXIT  WHEN cur_goodssupply%NOTFOUND;
    
                    BEGIN
                        DELETE FROM TBL_GOODS_SUPPLY 
                         WHERE su_no      = v_su_no_tmp 
                           AND modelno    = v_modelno_tmp 
                           AND su_modelno = v_su_modelno_tmp;
                    END;

                END LOOP;
 
                CLOSE cur_goodssupply;

            END IF;
            ------------------------------------------------------------------------------------------------------------------------------------------    
            -- 추가분류 삭제시 
            ------------------------------------------------------------------------------------------------------------------------------------------    
            -- 0502 AND v_cateflag_old='1' 제외 : 확인 필요 
            ------------------------------------------------------------------------------------------------------------------------------------------    
            IF v_modelno_old > 0  THEN 
               INSERT INTO TBL_ES_SEARCH_LOG ( MODELNO
                                              ,STATUS
                                              ,PL_NO) 
                                      VALUES ( v_modelno_old
                                              ,'D'
                                              ,0);
            END IF;
            i := i + 1;

        ELSE    
            EXIT;
        END IF;

    END LOOP;
    pg_Goods_DataLoop.g_index := 0;
    i := 1;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 0505 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------    
-- create or replace TRIGGER 
-- "DBENURI"."TR_SEN_DELGOODS" AFTER DELETE ON TBL_GOODS
-- DECLARE
-- 
--        v_modelno_old          tbl_goods.modelno            %TYPE := 0    ;
--        v_modelnm_old          tbl_goods.modelnm            %TYPE := ''   ;
--        v_factory_old          tbl_goods.factory            %TYPE := ''   ;
--        v_spec_old             tbl_goods.spec               %TYPE := ''   ;
--        v_c_date_old           tbl_goods.c_date             %TYPE := null ;
--        v_imgchk_old           tbl_goods.imgchk             %TYPE := ''   ;
--        v_minprice_old         tbl_goods_sum.minprice       %TYPE := 0    ;
--        v_mallcnt_old          tbl_goods_sum.mallcnt        %TYPE := 0    ;
--        v_kbnum_old            tbl_goods_sum.kb_num         %TYPE := 0    ;
--        v_openexpectflag_old   tbl_goods.openexpectflag     %TYPE := ''   ;
--        v_recommend_old        tbl_goods.recommend          %TYPE := ''   ;
--        v_popular_old          tbl_goods_sum.popular        %TYPE := 0    ;
-- --0418 v_gbcnt_old            tbl_goods_sum.gbcnt          %TYPE := 0    ;
--        v_ca_code_old          tbl_cate_goods.ca_code       %TYPE := ''   ;
--        v_modelno_group_old    tbl_goods.modelno_group      %TYPE := 0    ;
--        v_keyword_old          tbl_goods.keyword            %TYPE := ''   ;
--        v_jobcode_old          tbl_goods.jobcode            %TYPE := ''   ;
--        v_cateflag_old         tbl_cate_goods.cateflag      %TYPE := ''   ;
--        v_constrain_old        tbl_goods.constrain          %TYPE := ''   ;
--        v_rsiflag_old          tbl_goods.rsiflag            %TYPE := ''   ;
--        v_refshop_old          tbl_goods.refshop            %TYPE := ''   ;
-- --0418 v_boxmodelnm_old       tbl_goods_sum.box_modelnm    %TYPE := ''   ;
-- 
--        v_su_no_tmp            tbl_goods_supply.su_no       %TYPE := 0    ;
--        v_modelno_tmp          tbl_goods_supply.modelno     %TYPE := 0    ;
--        v_su_modelno_tmp       tbl_goods_supply.su_modelno  %TYPE := 0    ;
-- 
-- --0418 v_category_tmp         VARCHAR2(2500)                     := ''   ;
-- --0418 v_brand1_tmp           VARCHAR2(1000)                     := ''   ;
-- --0418 v_brand2_tmp           VARCHAR2(1000)                     := ''   ;
-- --0418 v_specopt_tmp          VARCHAR2(4000)                     := ''   ;
-- --0418 v_refshop_tmp          CHAR(1)                            := ''   ;
-- --0418 v_kbcnt_tmp            NUMBER(6)                          := 0    ;
--        i                      NUMBER(8)                          := 1    ;
--     
--        -------------------------------------------------------------------
--        -- 다이퀘스트
--        -------------------------------------------------------------------
-- 
--        v_search_key            VARCHAR2(13)                      := ''   ;
--        v_modelno               NUMBER(10)                        := 0    ;
--        v_group_flag            CHAR(1)                           := ''   ;
--        v_category              VARCHAR2(1000)                    := ''   ;
--        v_modelnm               VARCHAR2(400)                     := ''   ;
--        v_modelnm2              VARCHAR2(400)                     := ''   ;
--        v_shop_code             NUMBER(8)                         := 0    ;
--        v_shop_name             VARCHAR2(60)                      := ''   ;
--        v_factory               VARCHAR2(100)                     := ''   ;
--        v_popular               NUMBER(10)                        := 0    ;
--        v_popular2              NUMBER(10)                        := 0    ;
--        v_minprice              NUMBER(10)                        := 0    ;
--        v_maxprice              NUMBER(10)                        := 0    ;
--        v_minprices             VARCHAR2(2000)                    := ''   ;
--        v_c_date                VARCHAR2(16)                      := ''   ;
--        v_mallcnt               NUMBER(6)                         := 0    ;
--        v_spec                  VARCHAR2(4000)                    := ''   ;
--        v_openexpectflag        CHAR(1)                           := ''   ;
--        v_condiname             VARCHAR2(2000)                    := ''   ;
--        v_keyword1              VARCHAR2(2600)                    := ''   ; 
--        v_keyword2              VARCHAR2(2600)                    := ''   ;
--        v_brandcode1            VARCHAR2(600)                     := ''   ;
--        v_brandcode2            VARCHAR2(600)                     := ''   ;
--        v_specopt               VARCHAR2(200)                     := ''   ;
--        v_service_flag          CHAR(1)                           := '1'  ;
--        v_status                CHAR(1)                           := 'I'  ;
--        v_sale_cnt              NUMBER(8)                         := 0    ;
--        v_bookflag              CHAR(1)                           := ''   ;
--        v_useflag               CHAR(1)                           := ''   ;
-- 
-- CURSOR cur_goodssupply IS
-- SELECT su_no, modelno, su_modelno
--   FROM TBL_GOODS_SUPPLY
--  WHERE modelno = v_modelno_old OR su_modelno = v_modelno_old;
-- 
-- BEGIN
-- 
--   LOOP
--     
--     IF  i <= pg_Goods_DataLoop.g_index THEN
--         v_modelno_old         :=  pg_Goods_DataLoop.v_Modelno_old         (i);
--         v_modelnm_old         :=  pg_Goods_DataLoop.v_Modelnm_old         (i);
--         v_factory_old         :=  pg_Goods_DataLoop.v_Factory_old         (i);
--         v_spec_old            :=  pg_Goods_DataLoop.v_Spec_old            (i);
--         v_c_date_old          :=  pg_Goods_DataLoop.v_Cdate_old           (i);
--         v_imgchk_old          :=  pg_Goods_DataLoop.v_Imgchk_old          (i);
-- --0502  v_minprice_old        :=  pg_Goods_DataLoop.v_Minprice_old        (i);
-- --0502  v_mallcnt_old         :=  pg_Goods_DataLoop.v_Mallcnt_old         (i);
-- --0502  v_kbnum_old           :=  pg_Goods_DataLoop.v_Kbnum_old           (i);
--         v_openexpectflag_old  :=  pg_Goods_DataLoop.v_Openexpectflag_old  (i);
--         v_recommend_old       :=  pg_Goods_DataLoop.v_Recommend_old       (i);
-- --0502  v_popular_old         :=  pg_Goods_DataLoop.v_Popular_old         (i);
-- --0418  v_gbcnt_old           :=  pg_Goods_DataLoop.v_Gbcnt_old           (i);
-- --0502  v_ca_code_old         :=  pg_Goods_DataLoop.v_Ca_code_old         (i);
--         v_modelno_group_old   :=  pg_Goods_DataLoop.v_Modelnogroup_old    (i);
--         v_keyword_old         :=  pg_Goods_DataLoop.v_Keyword_old         (i);
--         v_jobcode_old         :=  pg_Goods_DataLoop.v_Jobcode_old         (i);
-- --0502  v_cateflag_old        :=  pg_Goods_DataLoop.v_Cateflag_old        (i);
--         v_constrain_old       :=  pg_Goods_DataLoop.v_Constrain_old       (i);
--         v_rsiflag_old         :=  pg_Goods_DataLoop.v_Rsiflag_old         (i);
--         v_refshop_old         :=  pg_Goods_DataLoop.v_Refshop_old         (i);
-- --0418  v_boxmodelnm_old      :=  pg_Goods_DataLoop.v_Boxmodelnm_old      (i);
-- 
--         IF v_modelno_old > 0 AND v_cateflag_old='0' THEN  -- 0502 v_cateflag_old 
--         
--            OPEN cur_goodssupply;
--            
--            LOOP FETCH cur_goodssupply INTO v_su_no_tmp
--                                          , v_modelno_tmp
--                                          , v_su_modelno_tmp;
--                 EXIT  WHEN cur_goodssupply%NOTFOUND;
--                 
--                 BEGIN
--                 DELETE FROM TBL_GOODS_SUPPLY 
--                 WHERE  su_no      = v_su_no_tmp 
--                   AND  modelno    = v_modelno_tmp 
--                   AND  su_modelno = v_su_modelno_tmp;
--                 END;
--            
--            END LOOP;
--              
--            CLOSE cur_goodssupply;
--            
--            
--            --IF v_cateflag_old = '0' THEN
--            --   UPDATE TBL_PRICELIST SET PJOBCODE = '0' WHERE MODELNO = v_modelno_old;
--            --END IF;
--            
-- 
--         END IF;
--         
--         -------------------------------------------------------------------------------------------
--         -- 추가분류 삭제시
--         -------------------------------------------------------------------------------------------
--         IF v_modelno_old > 0 AND v_cateflag_old='1' THEN   -- 0502 v_cateflag_old 
--         
--             BEGIN
--             
--                 IF  v_modelno_group_old > 0 THEN
--                     v_search_key := 'G' || v_modelno_group_old;
--                     v_group_flag := '1';
--                     v_modelno_old := v_modelno_group_old;
--                 ELSE
--                     v_search_key := 'G' || v_modelno_old;
--                     v_group_flag := '0';
--                 END IF;
--                 
--                 SELECT NVL(modelno_group,MAX(A.modelno))                                                     AS modelno 
--                       ,NVL(dbenuri.UDF_RTN_GET_CATEGORY3(NVL(modelno_group,MAX(A.modelno))), ' ')            AS category
--                       ,CASE WHEN INSTR(MAX(factory),MAX(brand)) > 0 THEN MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) 
--                             ELSE MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) || ' ' || MAX(brand) 
--                             END                                                                              AS modelnm
--                       ,MAX(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(modelnm,condiname,'')
--                            ,'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' ')) 
--                                                                                                              AS modelnm2
--                       ,0                                                                                     AS shop_code
--                       ,''                                                                                    AS shop_name
--                       ,RTRIM(LTRIM(MAX(factory)))                                                            AS factory
--                       ,CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) 
--                             ELSE NVL(MAX(sum_popular),0) 
--                             END                                                                              AS popular
--                       ,CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) 
--                             ELSE NVL(MAX(sum_popular),0) 
--                             END                                                                              AS popular2
--                       ,CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice)
--                             ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) 
--                             END                                                                              AS minprice
--                       ,MAX(minprice)                                                                         AS maxprice
--                       ,CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' 
--                             ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE(NVL(modelno_group,0)) 
--                             END                                                                              AS minprices
--                       ,TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS')                                               AS C_DATE
--                       ,MAX(mallcnt)                                                                          AS mallcnt
--                       ,replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' ')         AS spec
--                       ,CASE WHEN NVL(MIN(openexpectflag),'0')  = '1' OR  min(c_date) > sysdate THEN '1' 
--                             ELSE '0' 
--                             END                                                                              AS openexpectflag
--                       ,CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' 
--                             ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(modelno_group,0)) 
--                             END                                                                              AS condiname
--                       ,CASE WHEN NVL(modelno_group,0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') 
--                             ELSE DBENURI.UDF_MODEL_GROUP_KEYWORD(NVL(modelno_group,0)) || ' ' || NVL(MAX(BRAND),'')
--                             END                                                                              AS KEYWORD
--                       ,''                                                                                    AS keyword2
--                       ,NVL(dbenuri.UDF_RTN_GET_BRAND1(NVL(modelno_group,MAX(A.modelno))), ' ')               AS BRANDCODE1
--                       ,NVL(dbenuri.UDF_RTN_GET_BRAND2(NVL(modelno_group,MAX(A.modelno))), ' ')               AS BRANDCODE2
--                       ,dbenuri.UDF_RTN_GET_SPECOPT(NVL(A.modelno_group,MAX(A.modelno)))                      AS SPECOPT
--                       ,CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(sale_cnt),0)
--                             ELSE NVL(MAX(sum_sale_cnt),0) 
--                             END                                                                              AS sale_cnt
--                       ,CASE WHEN MAX(C.ca_code) = '93010000' THEN '1' ELSE '0' END                           AS bookflag  
--                       ,CASE WHEN MAX(B.mallcnt) > 0 AND (CASE WHEN NVL(MIN(openexpectflag),'0') = '1' OR min(c_date) > sysdate THEN '1' 
--                                                               ELSE '0' 
--                                                               END) = '0' AND MAX(C.ca_code) <> '93010000' THEN '1' 
--                             ELSE '0' 
--                             END                                                                              AS useflag
--                 
--                 INTO   v_modelno
--                       ,v_category
--                       ,v_modelnm
--                       ,v_modelnm2
--                       ,v_shop_code
--                       ,v_shop_name
--                       ,v_factory
--                       ,v_popular
--                       ,v_popular2
--                       ,v_minprice
--                       ,v_maxprice
--                       ,v_minprices
--                       ,v_c_date
--                       ,v_mallcnt
--                       ,v_spec
--                       ,v_openexpectflag
--                       ,v_condiname
--                       ,v_keyword1
--                       ,v_keyword2
--                       ,v_brandcode1
--                       ,v_brandcode2
--                       ,v_specopt
--                       ,v_sale_cnt
--                       ,v_bookflag
--                       ,v_useflag
--                  FROM  dbenuri.tbl_goods      A
--                       ,dbenuri.TBL_GOODS_SUM  B --0418 추가 
--                       ,dbenuri.TBL_CATE_GOODS C --0418 추가
--                 WHERE (A.modelno_group = v_modelno_old OR A.modelno = v_modelno_old)
--                   AND  jobcode > '0' 
--                   AND  constrain = '1' 
--                   AND  A.modelno = B.MODELNO    --0418 추가  
--                   AND  A.modelno = C.MODELNO    --0418 추가  
--                   AND  C.cateflag = '0'         
--               --  AND ((NVL(modelno_group,0) = 0 AND mallcnt >=0) OR (NVL(modelno_group,0) > 0 AND mallcnt > 0))                            
--                 GROUP BY modelno_group;
--                 
--                 EXCEPTION WHEN OTHERS THEN
--                     v_status := 'D';            
--             END;
--             
--             --업체 상품명 keyword1  필드에 합치기
--             --IF v_modelno_old > 0 AND v_cateflag_old='1' THEN --추가분류시
--             --    SELECT substr(v_keyword1 || ' ' || UDF_SHOP_GOODSNM(v_modelno_old),0,2600) INTO v_keyword1 FROM dual;
--             --END IF;
--                 
--             --DELETE TBL_SEARCH_LOG WHERE SEARCH_KEY = v_search_key;
--             
--             v_keyword1 := replace(replace(v_keyword1,'_',' '),'%',' ');
--                     
--             INSERT INTO TBL_SEARCH_LOG( search_key      
--                                        ,modelno
--                                        ,pl_no
--                                        ,group_flag
--                                        ,category
--                                        ,ca_code
--                                        ,modelnm
--                                        ,modelnm2
--                                        ,shop_code
--                                        ,factory
--                                        ,popular
--                                        ,popular2
--                                        ,minprice
--                                        ,maxprice
--                                        ,minprices
--                                        ,c_date
--                                        ,mallcnt
--                                        ,spec
--                                        ,openexpectflag
--                                        ,condiname
--                                        ,keyword1
--                                        ,keyword2
--                                        ,brandcode1
--                                        ,brandcode2
--                                        ,specopt
--                                        ,service_flag
--                                        ,status
--                                        ,sale_cnt
--                                        ,bookflag
--                                        ,useflag)
--                                 VALUES( v_search_key
--                                        ,v_modelno
--                                        ,0
--                                        ,v_group_flag
--                                        ,v_category
--                                        ,v_ca_code_old
--                                        ,v_modelnm
--                                        ,v_modelnm2
--                                        ,v_shop_code
--                                        ,v_factory
--                                        ,v_popular
--                                        ,v_popular2
--                                        ,v_minprice
--                                        ,v_maxprice
--                                        ,v_minprices
--                                        ,v_c_date
--                                        ,v_mallcnt
--                                        ,v_spec
--                                        ,v_openexpectflag
--                                        ,v_condiname
--                                        ,v_keyword1
--                                        ,v_keyword2
--                                        ,v_brandcode1
--                                        ,v_brandcode2
--                                        ,v_specopt
--                                        ,v_service_flag
--                                        ,v_status
--                                        ,v_sale_cnt
--                                        ,v_bookflag
--                                        ,v_useflag);
-- 
--       END IF;
-- 
--       i := i + 1;
-- 
--     ELSE
--       EXIT;
--     END IF;
-- 
--   END LOOP;
-- 
--   pg_Goods_DataLoop.g_index := 0;
--   
--   i := 1;
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------    



------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------    
-- CREATE OR REPLACE TRIGGER 
-- "DBENURI"."ASIS_TRG_SEN_DELGOODS" AFTER DELETE ON ASIS_TBL_GOODS
-- DECLARE
--    v_modelno_old         tbl_goods.modelno%TYPE := 0;
--    v_modelnm_old         tbl_goods.modelnm%TYPE := '';
--    v_factory_old         tbl_goods.factory%TYPE := '';
--    v_spec_old            tbl_goods.spec%TYPE := '';
--    v_c_date_old          tbl_goods.c_date%TYPE := null;
--    v_imgchk_old          tbl_goods.imgchk%TYPE := '';
--    v_minprice_old        tbl_goods.minprice%TYPE := 0;
--    v_mallcnt_old         tbl_goods.mallcnt%TYPE := 0;
--    v_kbnum_old           tbl_goods.kb_num%TYPE := 0;
--    v_openexpectflag_old  tbl_goods.openexpectflag%TYPE := '';
--    v_recommend_old       tbl_goods.recommend%TYPE := '';
--    v_popular_old         tbl_goods.popular%TYPE := 0;
--    v_gbcnt_old           tbl_goods.gbcnt%TYPE := 0;
--    v_ca_code_old         tbl_goods.ca_code%TYPE := '';
--    v_modelno_group_old   tbl_goods.modelno_group%TYPE := 0;
--    v_keyword_old         tbl_goods.keyword%TYPE := '';
--    v_jobcode_old         tbl_goods.jobcode%TYPE := '';
--    v_cateflag_old        tbl_goods.cateflag%TYPE := '';
--    v_constrain_old       tbl_goods.constrain%TYPE := '';
--    v_rsiflag_old         tbl_goods.rsiflag%TYPE := '';
--  v_refshop_old         tbl_goods.refshop%TYPE := '';
--  v_boxmodelnm_old      tbl_goods.box_modelnm%TYPE := '';
-- 
--  v_su_no_tmp           tbl_goods_supply.su_no%TYPE := 0;
--  v_modelno_tmp         tbl_goods_supply.modelno%TYPE := 0;
--  v_su_modelno_tmp      tbl_goods_supply.su_modelno%TYPE := 0;
-- 
--  v_category_tmp    VARCHAR2(2500) := '';
--  v_brand1_tmp      VARCHAR2(1000) := '';
--  v_brand2_tmp      VARCHAR2(1000) := '';
--  v_specopt_tmp     VARCHAR2(4000) := '';
--  v_refshop_tmp     CHAR(1) := '';
--  v_kbcnt_tmp       NUMBER(6) := 0;
--  i NUMBER(8) := 1;
--     
--     /*====================================*/
--     /* 다이퀘스트 */
--     /*====================================*/
--    v_search_key          VARCHAR2(13) := '';
--     v_modelno               NUMBER(10) := 0;
--     v_group_flag            CHAR(1) := '';
--     v_category              VARCHAR2(1000) := '';
--     v_modelnm               VARCHAR2(400) := '';
--     v_modelnm2              VARCHAR2(400) := '';
--     v_shop_code             NUMBER(8) := 0;
--     v_shop_name             VARCHAR2(60) := '';    
--     v_factory               VARCHAR2(100) := '';
--     v_popular               NUMBER(10) := 0;
--     v_popular2              NUMBER(10) := 0;    
--     v_minprice              NUMBER(10) := 0;
--     v_maxprice              NUMBER(10) := 0;
--     v_minprices             VARCHAR2(2000) := '';
--     v_c_date                VARCHAR2(16) := '';
--     v_mallcnt               NUMBER(6) := 0;
--     v_spec                  VARCHAR2(4000) := '';
--     v_openexpectflag        CHAR(1) := '';
--     v_condiname             VARCHAR2(2000) := '';
--     v_keyword1              VARCHAR2(2600) := '';
--     v_keyword2              VARCHAR2(2600) := '';
--     v_brandcode1            VARCHAR2(600) := '';
--     v_brandcode2            VARCHAR2(600) := '';
--     v_specopt               VARCHAR2(200) := '';
--     v_service_flag          CHAR(1) := '1';
--     v_status           CHAR(1) := 'I';
--     v_sale_cnt              NUMBER(8) := 0;
--     v_bookflag              CHAR(1) := '';
--     v_useflag               CHAR(1) := '';
-- 
--   CURSOR cur_goodssupply IS
--    SELECT su_no, modelno, su_modelno
--       FROM TBL_GOODS_SUPPLY
--      WHERE modelno = v_modelno_old OR su_modelno = v_modelno_old;
-- 
-- BEGIN
-- 
-- 
--  LOOP
--    IF i <= pac_Goods_DataLoop.g_index THEN
--        v_modelno_old         :=  pac_Goods_DataLoop.v_Modelno_old(i);
--        v_modelnm_old         :=  pac_Goods_DataLoop.v_Modelnm_old(i);
--        v_factory_old         :=  pac_Goods_DataLoop.v_Factory_old(i);
--        v_spec_old            :=  pac_Goods_DataLoop.v_Spec_old(i);
--        v_c_date_old          :=  pac_Goods_DataLoop.v_Cdate_old(i);
--        v_imgchk_old          :=  pac_Goods_DataLoop.v_Imgchk_old(i);
--        v_minprice_old        :=  pac_Goods_DataLoop.v_Minprice_old(i);
--        v_mallcnt_old         :=  pac_Goods_DataLoop.v_Mallcnt_old(i);
--        v_kbnum_old           :=  pac_Goods_DataLoop.v_Kbnum_old(i);
--        v_openexpectflag_old  :=  pac_Goods_DataLoop.v_Openexpectflag_old(i);
--        v_recommend_old       :=  pac_Goods_DataLoop.v_Recommend_old(i);
--        v_popular_old         :=  pac_Goods_DataLoop.v_Popular_old(i);
--        v_gbcnt_old           :=  pac_Goods_DataLoop.v_Gbcnt_old(i);
--        v_ca_code_old         :=  pac_Goods_DataLoop.v_Ca_code_old(i);
--        v_modelno_group_old   :=  pac_Goods_DataLoop.v_Modelnogroup_old(i);
--        v_keyword_old         :=  pac_Goods_DataLoop.v_Keyword_old(i);
--        v_jobcode_old         :=  pac_Goods_DataLoop.v_Jobcode_old(i);
--        v_cateflag_old        :=  pac_Goods_DataLoop.v_Cateflag_old(i);
--        v_constrain_old       :=  pac_Goods_DataLoop.v_Constrain_old(i);
--    v_rsiflag_old         :=  pac_Goods_DataLoop.v_Rsiflag_old(i);
--    v_refshop_old         :=  pac_Goods_DataLoop.v_Refshop_old(i);
--    v_boxmodelnm_old      :=  pac_Goods_DataLoop.v_Boxmodelnm_old(i);
-- 
--        IF v_modelno_old > 0 AND v_cateflag_old='0' THEN
--          OPEN cur_goodssupply;
--          LOOP
--            FETCH cur_goodssupply INTO v_su_no_tmp, v_modelno_tmp, v_su_modelno_tmp;
--            EXIT WHEN cur_goodssupply%NOTFOUND;
-- 
--                DELETE FROM TBL_GOODS_SUPPLY WHERE su_no = v_su_no_tmp and modelno = v_modelno_tmp AND su_modelno = v_su_modelno_tmp;
-- 
--             END LOOP;
--             CLOSE cur_goodssupply;
-- 
--          /*
--             IF v_cateflag_old = '0' THEN
--                UPDATE TBL_PRICELIST SET PJOBCODE = '0' WHERE MODELNO = v_modelno_old;
--          END IF;
--          */
-- 
--      END IF;
--         
--         --===========================================================
--         --추가분류 삭제시
--         --===========================================================
--         IF v_modelno_old > 0 AND v_cateflag_old='1' THEN
--         
--             BEGIN
--             
--                 IF v_modelno_group_old > 0 THEN
--                     v_search_key := 'G' || v_modelno_group_old;
--                     v_group_flag := '1';
--                     v_modelno_old := v_modelno_group_old;
--                 ELSE
--                     v_search_key := 'G' || v_modelno_old;
--                     v_group_flag := '0';
--                 END IF;
--                 
--                 select 
--                 NVL(modelno_group,MAX(modelno)) modelno, 
--                 NVL(dbenuri.UDF_RTN_GET_CATEGORY3(NVL(modelno_group,MAX(modelno))), ' ') AS category,  
--                 --MAX(ca_code) category, 
--                 
--                 CASE WHEN INSTR(MAX(factory),MAX(brand)) > 0  THEN MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) ELSE MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) || ' ' ||  MAX(brand) END AS  modelnm,  
--                 MAX(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(modelnm,condiname,''),'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' ')) modelnm2, 
--                 --MAX(modelnm) modelnm,  
-- 
--                 0 shop_code, 
--                 '' shop_name,  
--                 RTRIM(LTRIM(MAX(factory))) factory,  
--                 CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END AS popular,
--                 CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END AS popular2,
--                 --MIN(minprice) minprice,  
--                 CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice) ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) END AS minprice,
--                 MAX(minprice) maxprice,  
--                 CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE(NVL(modelno_group,0)) END AS minprices,  
--                 TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS') AS C_DATE, 
--                 MAX(mallcnt) mallcnt,  
--                 --CASE WHEN MAX(ca_lcode)='14' OR MAX(ca_lcode)='15' THEN '' ELSE MAX(spec) END AS spec,
--                 replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' ') spec,
--                 --NVL(MIN(openexpectflag),'0') openexpectflag,  
--                 case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end as openexpectflag, 
--                 CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(modelno_group,0)) END AS condiname, 
--                 CASE WHEN NVL(modelno_group,0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') ELSE DBENURI.UDF_MODEL_GROUP_KEYWORD(NVL(modelno_group,0)) || ' ' || NVL(MAX(BRAND),'') END AS KEYWORD, 
--                 --MAX(keyword2) keyword2,  
--                 '' keyword2, 
--                 NVL(dbenuri.UDF_RTN_GET_BRAND1(NVL(modelno_group,MAX(modelno))), ' ') AS BRANDCODE1, 
--                 NVL(dbenuri.UDF_RTN_GET_BRAND2(NVL(modelno_group,MAX(modelno))), ' ') AS BRANDCODE2, 
--                 dbenuri.UDF_RTN_GET_SPECOPT(NVL(modelno_group,MAX(modelno))) AS SPECOPT,
--                 --'' AS SPECOPT,
--                 CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(sale_cnt),0) ELSE NVL(MAX(sum_sale_cnt),0) END AS sale_cnt,
--                 CASE WHEN MAX(ca_code) = '93010000' then '1' else '0' end as bookflag ,
--                 --CASE WHEN MAX(mallcnt) > 0 and   NVL(MIN(openexpectflag),'0') = '0' and MAX(ca_code) <> '93010000' then '1' else '0' end as useflag
--                 CASE WHEN  MAX(mallcnt) > 0 and   (case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end) = '0' and MAX(ca_code) <> '93010000' then '1' else '0' end as useflag
-- 
--                 
--                 INTO
--                 
--                 v_modelno,
--                 v_category,
--                 v_modelnm,
--                 v_modelnm2,
--                 v_shop_code,
--                 v_shop_name,
--                 v_factory,                        
--                 v_popular,
--                 v_popular2,
--                 v_minprice,
--                 v_maxprice,
--                 v_minprices,
--                 v_c_date,
--                 v_mallcnt,
--                 v_spec,
--                 v_openexpectflag,
--                 v_condiname,
--                 v_keyword1,
--                 v_keyword2,
--                 v_brandcode1,
--                 v_brandcode2,
--                 v_specopt,
--                 v_sale_cnt,
--                 v_bookflag,
--                 v_useflag
--                 
--                 FROM dbenuri.tbl_goods 
--                 WHERE (modelno_group = v_modelno_old OR modelno = v_modelno_old)
--                 AND jobcode > '0'  
--                 AND constrain = '1'  
--                 AND cateflag = '0' 
--                 --AND ((NVL(modelno_group,0) = 0 AND mallcnt >=0) OR (NVL(modelno_group,0) > 0 AND mallcnt > 0))                            
--                 GROUP BY modelno_group;
--                 
--                 EXCEPTION WHEN OTHERS THEN
--                     v_status := 'D';            
--             END;
--             
--             --업체 상품명 keyword1  필드에 합치기
--             --IF v_modelno_old > 0 AND v_cateflag_old='1' THEN --추가분류시
--             --    SELECT substr(v_keyword1 || ' ' || UDF_SHOP_GOODSNM(v_modelno_old),0,2600) INTO v_keyword1 FROM dual;
--             --END IF;
--                 
--             --DELETE TBL_SEARCH_LOG WHERE SEARCH_KEY = v_search_key;
--             
--             v_keyword1 := replace(replace(v_keyword1,'_',' '),'%',' ');
--                     
--             INSERT INTO TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
--                 openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag)
--             VALUES(v_search_key,v_modelno,0,v_group_flag,v_category,v_ca_code_old,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
--                 v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,v_status,v_sale_cnt,v_bookflag,v_useflag);
-- 
--      END IF;
-- 
-- 
-- 
--        i := i + 1;
--     ELSE
--       EXIT;
--     END IF;
-- 
--  END LOOP;
-- 
--    pac_Goods_DataLoop.g_index := 0;
--    i := 1;
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------    


ALTER TRIGGER "DBENURI"."TR_SEN_DELGOODS" ENABLE