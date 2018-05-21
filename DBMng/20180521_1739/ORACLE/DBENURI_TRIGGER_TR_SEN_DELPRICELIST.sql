/* *************************************************************************
 * NAME : DBENURI.TR_SEN_DELPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-18 18:37:03
 *        Modify: 2018-05-21 17:23:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_SEN_DELPRICELIST" AFTER DELETE ON TBL_PRICELIST
DECLARE
       v_modelno_old             tbl_pricelist.modelno        %TYPE := 0   ;
       v_pl_no_old               tbl_pricelist.pl_no          %TYPE := 0   ;
       v_shop_code_old           tbl_pricelist.shop_code      %TYPE := 0   ;
       v_goodsnm_old             tbl_pricelist.goodsnm        %TYPE := ''  ;
       v_ca_code_old             tbl_pricelist.ca_code        %TYPE := ''  ;
--0418 v_pjobcode_old            tbl_pricelist.pjobcode       %TYPE := '0' ;

       v_jobtype_old             tbl_pricelist.jobtype        %TYPE := '0' ;
       v_price_old               tbl_pricelist.price          %TYPE :=  0  ;
       v_url_old                 tbl_pricelist.url            %TYPE := ''  ;
       v_u_date_old              tbl_pricelist.u_date         %TYPE := null;
       v_imgurl_old              tbl_pricelist.imgurl         %TYPE := ''  ;
       v_imgurlflag_old          tbl_pricelist.imgurlflag     %TYPE := '0' ;
--0418 v_searchflag_old          tbl_pricelist.searchflag     %TYPE := '1' ;
       v_goodsfactory_old        tbl_pricelist.goodsfactory   %TYPE := ''  ;
       v_instance_price_old      tbl_pricelist.instance_price %TYPE := 0   ;
       v_srvflag_old             tbl_pricelist.srvflag        %TYPE := ''  ;
       v_status_old              tbl_pricelist.status         %TYPE := ''  ;

       v_minprice                tbl_goods_sum.minprice       %TYPE := 0   ; --0418 tbl_goods --> tbl_goods_sum
       v_avgprice                tbl_goods_sum.avgprice       %TYPE := 0   ; --0418 tbl_goods --> tbl_goods_sum
       v_maxprice                tbl_goods_sum.maxprice       %TYPE := 0   ; --0418 tbl_goods --> tbl_goods_sum
       v_mallcnt                 tbl_goods_sum.mallcnt        %TYPE := 0   ; --0418 tbl_goods --> tbl_goods_sum
       v_shopname                tbl_shoplist.shop_name       %TYPE := ''  ;
       v_pjobcodecnt             NUMBER                             := 0   ;

       v_rsiflag_tmp             CHAR(1)                            := ''  ;
       m_count_tmp               NUMBER(6)                          := 0   ;

BEGIN
       v_modelno_old             := NVL(pacPricelistData.v_Modelno_old, 0);
       -----------------------------------------------------------------------------------------------------------------------------------------------    
       -- 0505 이주현 : v_pl_no_old : 이전 pl_no값 TR_ROW_DELPRICELIST 수정
       -----------------------------------------------------------------------------------------------------------------------------------------------    
--0505 v_pl_no_old               := pg_Pricelist_Data.v_Pl_no_new;
       v_pl_no_old               := pg_Pricelist_Data.v_Pl_no_old;
       
       v_shop_code_old           := pg_Pricelist_Data.v_Shop_code_new;
       v_goodsnm_old             := pg_Pricelist_Data.v_Goodsnm_new;
       v_ca_code_old             := pg_Pricelist_Data.v_Ca_code_new;
--0418 v_pjobcode_old            := pg_Pricelist_Data.v_Pjobcode_new;
       v_jobtype_old             := pg_Pricelist_Data.v_Jobtype_new;
       v_price_old               := pg_Pricelist_Data.v_Price_new;
       v_url_old                 := pg_Pricelist_Data.v_Url_new;
       v_imgurl_old              := pg_Pricelist_Data.v_Imgurl_new;
       v_imgurlflag_old          := pg_Pricelist_Data.v_Imgurlflag_new;
       v_u_date_old              := pg_Pricelist_Data.v_Udate_new;
--0418 v_searchflag_old          := pg_Pricelist_Data.v_Searchflag_new;
       v_goodsfactory_old        := pg_Pricelist_Data.v_Goodsfactory_new;
       v_instance_price_old      := NVL(pg_Pricelist_Data.v_Instance_price_new,0);
       v_srvflag_old             := pg_Pricelist_Data.v_Srvflag_new;
       v_status_old              := pg_Pricelist_Data.v_Status_new;

       IF v_modelno_old<0 THEN
          v_modelno_old :=0;
       END IF;
   
       -----------------------------------------------------------------------------------------------------------------------------------------------    
       -- 모델번호있음 : 삭제모델에 대한 GOODS정보 변경
       -----------------------------------------------------------------------------------------------------------------------------------------------    

       IF v_modelno_old > 0 
           AND (v_srvflag_old='0' OR v_srvflag_old='L' OR v_srvflag_old='R' OR v_srvflag_old='M') 
           AND (v_status_old='0'  OR v_status_old='8'  OR v_status_old='9') THEN
           
           BEGIN
               SELECT NVL(AVG(p.price), 0)       as v_avgprice
                    ----------------------------------------------------------------------------------------------------------------------------------    
                    -- 0418 한용규 : subside 컬럼 삭제에 따른 변경
                    --               실제 값 0, null 만 있음
                    ----------------------------------------------------------------------------------------------------------------------------------    
                    --, NVL(MIN(p.price+NVL(subside,0)*10000), 0)
                    ----------------------------------------------------------------------------------------------------------------------------------    
                    , NVL(MIN(p.price*10000), 0) as v_minprice -- 0418 수정 
                    , NVL(MAX(p.price), 0)       as v_maxprice
                    , COUNT(p.shop_code)         as v_mallcnt 
                 INTO v_avgprice
                    , v_minprice
                    , v_maxprice
                    , v_mallcnt
                 FROM TBL_PRICELIST p
                    , TBL_SHOPLIST  s
                WHERE p.modelno = v_modelno_old
                  AND p.status  in ('0','8','9')
                  AND p.srvflag in ('0','L','R')
                  AND NVL(p.option_flag2,'0') = '0'
                  AND p.esstockflag = '0'
                  AND p.shop_code   = s.shop_code;
                 
               EXCEPTION WHEN OTHERS THEN
                         v_avgprice :=0;
                         v_minprice :=0;
                         v_maxprice :=0;
                         v_mallcnt  :=0;
           END;
           
           IF substr(v_ca_code_old,0,4)='0304' OR substr(v_ca_code_old,0,4)='0305' THEN
   
              BEGIN
   
                   SELECT NVL(MIN(p.price), 0) 
                     INTO v_minprice
                     FROM TBL_PRICELIST p
                    WHERE p.modelno = v_modelno_old
                      AND p.status  in ('0','8','9')
                      AND p.srvflag in ('0','L','R')
                      AND ( NVL(PRICE_FLAG,'0') = '0' OR NVL(AIRCONFEETYPE,'0') = '3' OR NVL(AIRCONFEETYPE,'0') = '4' )
                      AND NVL(p.option_flag2,'0') = '0';
   
                   EXCEPTION WHEN OTHERS THEN
                             v_minprice := 0;
               
              END;
   
           END IF;

           IF v_price_old <= v_minprice THEN
              ----------------------------------------------------------------------------------------------------------------------------------------    
              -- 최저가인 경우만 처리
              ----------------------------------------------------------------------------------------------------------------------------------------    
              BEGIN
                   SELECT NVL(count(*) ,0)
                     INTO m_count_tmp
                     FROM TBL_PRICELIST
                    WHERE modelno = v_modelno_old
                      AND status  = '0'
                      AND srvflag = 'M'
                      AND price   < v_minprice;
                   
                   IF m_count_tmp > 0 THEN
                      v_rsiflag_tmp :='1';
                   END IF;                                
              END;
           END IF;       
           
           -------------------------------------------------------------------------------------------------------------------------------------------    
           -- 0418 한용규 : 테이블 분리/변경에 따른 수정 
           -------------------------------------------------------------------------------------------------------------------------------------------    
           -- UPDATE TBL_GOODS
           --    SET avgprice = v_avgprice
           --      , minprice = v_minprice
           --      , maxprice = v_maxprice
           --      , mallcnt  = v_mallcnt
           --      , rsiflag  = null
           --      , moddate  = sysdate
           --  WHERE modelno  = v_modelno_old;
           -------------------------------------------------------------------------------------------------------------------------------------------    
           BEGIN
              
              UPDATE TBL_GOODS_SUM                --0418 TBL_GOODS -> TBL_GOODS_SUM 
                 SET avgprice     = v_avgprice
                   , minprice     = v_minprice
                   , maxprice     = v_maxprice
                   , mallcnt      = v_mallcnt
                 --, rsiflag      = null          --0418 rsiflag : TBL_GOODS_SUM 에 없음
                   , moddate      = sysdate
                   , CHK_TRG_DATE = SYSDATE
                   , CHK_TRG_FLAG = 'DP1'
               WHERE modelno      = v_modelno_old;
           END;
            
           -------------------------------------------------------------------------------------------------------------------------------------------    
           -- 0418 한용규 : TBL_GOODS_SUM Update 여부 확인(변경일시만 Update ?)
           -- 0505 이주현 : tbl_goods_sum 데이터가 변경되었음을 판단할수 있는 컬럼 추가 필요?
           -------------------------------------------------------------------------------------------------------------------------------------------    
           BEGIN
              UPDATE TBL_GOODS
                 SET rsiflag      = NULL      
                   , MODDATE      = SYSDATE
                   , SUM_MODDATE  = SYSDATE
                   , CHK_TRG_DATE = SYSDATE
                   , CHK_TRG_FLAG = 'DP1'
               WHERE modelno      = v_modelno_old;
           END;
           -------------------------------------------------------------------------------------------------------------------------------------------    
   
       END IF;
       
       -----------------------------------------------------------------------------------------------------------------------------------------------    
       -- 0505 이주현 : 삭제된 pl_no 추가색인으로 ES에서도 삭제
       -----------------------------------------------------------------------------------------------------------------------------------------------    
       IF v_pl_no_old > 0  THEN  
          INSERT INTO TBL_ES_SEARCH_LOG ( MODELNO
                                         ,STATUS
                                         ,PL_NO) 
                                 VALUES ( 0
                                         ,'D'
                                         ,v_pl_no_old);
       END IF;       

END;

----------------------------------------------------------------------------------------------------- 
-- 0418 원본 백업 
-----------------------------------------------------------------------------------------------------
-- CREATE OR REPLACE TRIGGER 
-- "DBENURI"."TR_SEN_DELPRICELIST" AFTER DELETE ON TBL_PRICELIST
-- DECLARE
--     v_modelno_old      tbl_pricelist.modelno%TYPE :=  0;
--     v_pl_no_old        tbl_pricelist.pl_no%TYPE :=  0;
--     v_shop_code_old   tbl_pricelist.shop_code%TYPE := 0;
--     v_goodsnm_old    tbl_pricelist.goodsnm%TYPE := ' ';
--     v_ca_code_old    tbl_pricelist.ca_code%TYPE := ' ';
--     v_pjobcode_old   tbl_pricelist.pjobcode%TYPE := '0';
-- 
--     v_jobtype_old    tbl_pricelist.jobtype%TYPE := '0';
--     v_price_old     tbl_pricelist.price%TYPE := 0;
--     v_url_old      tbl_pricelist.url%TYPE := ' ';
--     v_u_date_old    tbl_pricelist.u_date%TYPE := null;
--     v_imgurl_old    tbl_pricelist.imgurl%TYPE := ' ';
--     v_imgurlflag_old  tbl_pricelist.imgurlflag%TYPE := '0';
--     v_searchflag_old  tbl_pricelist.searchflag%TYPE := '1';
--     v_goodsfactory_old tbl_pricelist.goodsfactory%TYPE := ' ';
--     v_instance_price_old  tbl_pricelist.instance_price%TYPE := 0;
--     v_srvflag_old          tbl_pricelist.srvflag%TYPE := '';
--     v_status_old         tbl_pricelist.status%TYPE := '';
-- 
--     v_minprice    tbl_goods.minprice%TYPE := 0;
--     v_avgprice    tbl_goods.avgprice%TYPE := 0;
--     v_maxprice    tbl_goods.maxprice%TYPE := 0;
--     v_mallcnt     tbl_goods.mallcnt%TYPE := 0;
--     v_shopname  tbl_shoplist.shop_name%TYPE := ' ';
--     v_pjobcodecnt    NUMBER := 0;
-- 
--     v_rsiflag_tmp      CHAR(1) := '';
--     m_count_tmp NUMBER(6) := 0;
-- 
-- BEGIN
--     v_modelno_old    :=  NVL(pacPricelistData.v_Modelno_old, 0);
--     v_pl_no_old       :=  pac_Pricelist_Data.v_Pl_no_new;
--     v_shop_code_old  :=  pac_Pricelist_Data.v_Shop_code_new;
--     v_goodsnm_old    :=  pac_Pricelist_Data.v_Goodsnm_new;
--     v_ca_code_old    :=  pac_Pricelist_Data.v_Ca_code_new;
--     v_pjobcode_old    :=  pac_Pricelist_Data.v_Pjobcode_new;
--     v_jobtype_old    :=  pac_Pricelist_Data.v_Jobtype_new;
--     v_price_old       :=  pac_Pricelist_Data.v_Price_new;
--     v_url_old      :=  pac_Pricelist_Data.v_Url_new;
--     v_imgurl_old      :=  pac_Pricelist_Data.v_Imgurl_new;
--     v_imgurlflag_old  :=  pac_Pricelist_Data.v_Imgurlflag_new;
--     v_u_date_old    :=  pac_Pricelist_Data.v_Udate_new;
--     v_searchflag_old  :=  pac_Pricelist_Data.v_Searchflag_new;
--     v_goodsfactory_old :=  pac_Pricelist_Data.v_Goodsfactory_new;
--     v_instance_price_old  := NVL(pac_Pricelist_Data.v_Instance_price_new,0);
--     v_srvflag_old    := pac_Pricelist_Data.v_Srvflag_new;
--     v_status_old   := pac_Pricelist_Data.v_Status_new;
-- 
--     IF v_modelno_old<0 THEN
--         v_modelno_old :=0;
--     END IF;
-- 
--     --모델번호있음.-->삭제모델에 대한 GOODS정보 변경
--     IF v_modelno_old > 0 AND (v_srvflag_old='0' OR v_srvflag_old='L' OR v_srvflag_old='R' OR v_srvflag_old='M') 
--         AND (v_status_old='0' OR v_status_old='8' OR v_status_old='9') THEN
--         BEGIN
--             SELECT NVL(AVG(p.price), 0)
--                 --, NVL(MIN((case when (NVL(s.es_use,'0') = '9' or p.jobtype = '2') and NVL(p.instance_price, 0) > 0 then (p.instance_price+NVL(subside,0)*10000) when s.shop_code = 55 then (trunc(p.price, -1)+NVL(subside,0)*10000) else (p.price+NVL(subside,0)*10000) end)), 0)
--                 , NVL(MIN(p.price+NVL(subside,0)*10000), 0)
--                 , NVL(MAX(p.price), 0)
--                 , count(p.shop_code)
--             INTO v_avgprice, v_minprice, v_maxprice, v_mallcnt
--             FROM TBL_PRICELIST p, TBL_SHOPLIST s
--             WHERE p.modelno = v_modelno_old
--                 AND p.status in ('0','8','9')
--                 AND p.srvflag in ('0','L','R')
--                 AND NVL(p.option_flag2,'0') = '0'
--                 AND p.esstockflag = '0'
--                 AND p.shop_code = s.shop_code;
--             EXCEPTION WHEN OTHERS THEN
--                 v_avgprice :=0;
--                 v_minprice :=0;
--                 v_maxprice :=0;
--                 v_mallcnt :=0;
--         END;
--         
--         IF substr(v_ca_code_old,0,4)='0304' OR substr(v_ca_code_old,0,4)='0305' THEN
--                         
--             BEGIN
--             
--                 SELECT NVL(MIN(p.price), 0) INTO v_minprice
--                 FROM TBL_PRICELIST p
--                 WHERE p.modelno = v_modelno_old
--                     AND p.status in ('0','8','9')
--                     AND p.srvflag in ('0','L','R')
--                     AND (NVL(PRICE_FLAG,'0') = '0' OR NVL(AIRCONFEETYPE,'0') = '3' OR NVL(AIRCONFEETYPE,'0') = '4')
--                     AND NVL(p.option_flag2,'0') = '0';
-- 
--                 EXCEPTION WHEN OTHERS THEN
--                     v_minprice := 0;
--             
--             END;
-- 
--         END IF;
--         --=========================================================
--         IF v_price_old <= v_minprice THEN
--            --최저가인 경우만 처리
--             BEGIN
--                 SELECT NVL(count(*) ,0)
--                 INTO m_count_tmp
--                 FROM TBL_PRICELIST
--                 WHERE modelno = v_modelno_old
--                     AND status = '0'
--                     AND srvflag = 'M'
--                     AND price < v_minprice;
--                 
--                 IF m_count_tmp > 0 THEN
--                     v_rsiflag_tmp :='1';
--                 END IF;                                
--             END;
--         END IF;       
--         
--         UPDATE TBL_GOODS SET
--             avgprice = v_avgprice,
--             minprice = v_minprice,
--             maxprice = v_maxprice,
--             mallcnt = v_mallcnt,
--             rsiflag = null,
--             moddate = sysdate
--         WHERE modelno = v_modelno_old;
-- 
--     END IF;
-- 
-- END;
-----------------------------------------------------------------------------------------------------

ALTER TRIGGER "DBENURI"."TR_SEN_DELPRICELIST" ENABLE