/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_SEN_UPPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 17:05:11
 *        Modify: 2018-05-11 10:51:28
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_SEN_UPPRICELIST" AFTER UPDATE ON dbenuri.ASIS_TBL_PRICELIST
REFERENCING NEW AS NEW OLD AS OLD
DECLARE
  v_pl_no_old               NUMBER := 0;
  v_pl_no_new               NUMBER := 0;
  v_modelno_old             NUMBER := 0;
  v_modelno_new             NUMBER := 0;
  v_shop_code_old           NUMBER := 0;
  v_shop_code_new           NUMBER := 0;
  v_price_old               NUMBER := 0;
  v_price_new               NUMBER := 0;
  v_srvflag_old             CHAR(1) := '';
  v_srvflag_new             CHAR(1) := '';
  v_status_old              CHAR(1) := '';
  v_status_new              CHAR(1) := '';
  v_esstockflag_old         CHAR(1) := '';
  v_esstockflag_new         CHAR(1) := '';
  v_coupon_old              NUMBER := 0;
  v_coupon_new              NUMBER := 0;
  v_jobtype_old             CHAR(1) := '';
  v_jobtype_new             CHAR(1) := '';
  v_instance_price_old      NUMBER := 0;
  v_instance_price_new      NUMBER := 0;
  v_pjobcode_old            CHAR(1) := '';
  v_pjobcode_new            CHAR(1) := '';
  
  v_avgprice_new            tbl_goods.avgprice%TYPE := 0;
  v_minprice_new            tbl_goods.minprice%TYPE := 0;  
  /* 배송비 포함 최저가 nova23 2016.06.21*/
  v_minprice2_new           tbl_goods.minprice2%TYPE := 0;
  v_minprice3_new           tbl_goods.minprice3%TYPE := 0;
  v_minprice4_new           tbl_goods.minprice4%TYPE := 0;
  
  v_ap_minprice_new         tbl_goods.minprice%TYPE := 0;  
  
  v_socialprice_new         tbl_goods.socialprice%TYPE := 0;
  v_maxprice_new            tbl_goods.maxprice%TYPE := 0;
  v_mallcnt_new             tbl_goods.mallcnt%TYPE := 0;
  v_mallcnt3_new            tbl_goods.mallcnt3%TYPE := 0;
  v_avgprice_old            tbl_goods.avgprice%TYPE := 0;
  v_minprice_old            tbl_goods.minprice%TYPE := 0;
  /* 배송비 포함 최저가 nova23 2016.06.21*/
  v_minprice2_old           tbl_goods.minprice2%TYPE := 0;  
  v_minprice3_old           tbl_goods.minprice3%TYPE := 0;  
  v_minprice4_old           tbl_goods.minprice4%TYPE := 0;  
  
  v_maxprice_old            tbl_goods.maxprice%TYPE := 0;
  v_mallcnt_old             tbl_goods.mallcnt%TYPE := 0;
  v_mallcnt3_old            tbl_goods.mallcnt3%TYPE := 0;
  v_plno			        tbl_pricelist.pl_no%TYPE := 0;
  v_ca_code_old             tbl_pricelist.ca_code%TYPE := '';
  v_ca_code_new             tbl_pricelist.ca_code%TYPE := '';
  v_goodsnm_old             tbl_pricelist.goodsnm%TYPE := '';
  v_goodsnm_new             tbl_pricelist.goodsnm%TYPE := '';
  v_url_old                 tbl_pricelist.url%TYPE := '';
  v_url_new                 tbl_pricelist.url%TYPE := '';
  v_imgurl_old              tbl_pricelist.imgurl%TYPE := '';
  v_imgurl_new              tbl_pricelist.imgurl%TYPE := '';
  v_imgurlflag_old          tbl_pricelist.imgurlflag%TYPE := '';
  v_imgurlflag_new          tbl_pricelist.imgurlflag%TYPE := '';
  v_u_date_old              tbl_pricelist.u_date%TYPE := null;
  v_u_date_new              tbl_pricelist.u_date%TYPE := null;
  v_searchflag_old          tbl_pricelist.searchflag%TYPE := '';
  v_searchflag_new          tbl_pricelist.searchflag%TYPE := '';
  v_goodsfactory_old        tbl_pricelist.goodsfactory%TYPE := '';
  v_goodsfactory_new        tbl_pricelist.goodsfactory%TYPE := '';
  v_goodsbrand_old          tbl_pricelist.goodsbrand%TYPE := '';
  v_goodsbrand_new          tbl_pricelist.goodsbrand%TYPE := '';  
  
  v_option_flag2_old        tbl_pricelist.option_flag2%TYPE := '';
  v_option_flag2_new        tbl_pricelist.option_flag2%TYPE := '';
  
  v_price_flag_old          tbl_pricelist.price_flag%TYPE := '';
  v_price_flag_new          tbl_pricelist.price_flag%TYPE := '';
  
  v_store_flag_old          tbl_pricelist.store_flag%TYPE := '';
  v_store_flag_new          tbl_pricelist.store_flag%TYPE := '';
  
  v_ca_code_dept_old        tbl_pricelist.ca_code_dept%TYPE := '';
  v_ca_code_dept_new        tbl_pricelist.ca_code_dept%TYPE := '';
  
  v_popular_new             tbl_pricelist.popular%TYPE :=  0;
  v_shopname		        tbl_shoplist.shop_name%TYPE := '';
  
  v_searchflag              CHAR(1) := '';
  v_searchflag2             CHAR(1) := '';
  v_status_tmp              CHAR(1) := '';
  v_subside_old             NUMBER := 0;
  v_subside_new             NUMBER := 0;
  
  v_apflag_new          CHAR(1) := '';
  
  v_modelno_group_new       tbl_pricelist.modelno%TYPE :=  0;
  
  --m_count_tmp               NUMBER(6) := 0;

  i NUMBER(8) := 1;
  v_rsiflag_tmp			    CHAR(1) := '';

    /*=================================*/
    v_search_key 	VARCHAR2(13) := '';
    v_modelno       NUMBER(10) := 0;
    v_group_flag    CHAR(1) := '';
    v_category      VARCHAR2(100) := '';
    v_ca_code       VARCHAR2(12) := '';
    v_modelnm       VARCHAR2(800) := '';
    v_modelnm2      VARCHAR2(800) := '';
    v_shop_code     NUMBER(8) := 0;
    v_shop_name     VARCHAR2(60) := '';    
    v_factory       VARCHAR2(100) := '';
    v_goodsbrand    VARCHAR2(100) := v_goodsbrand_new;
    v_popular       NUMBER(10) := 0;
    v_popular2      NUMBER(10) := 0;
    v_minprice      NUMBER(10) := 0;
    v_minprices     VARCHAR2(2000) := '';
    v_maxprice      NUMBER(10) := 0;
    v_c_date        VARCHAR2(16) := '';
    v_mallcnt       NUMBER(6) := 0;
    v_mallcnt3      NUMBER(6) := 0;
    v_spec          VARCHAR2(4000) := '';
    v_openexpectflag CHAR(1) := '';
    v_condiname     VARCHAR2(2000) := '';    
    v_keyword1      VARCHAR2(2600) := '';
    v_keyword2      VARCHAR2(2600) := '';
    v_brandcode1    VARCHAR2(1000) := '';
    v_brandcode2    VARCHAR2(1000) := '';
    v_specopt       VARCHAR2(200) := '';
    v_service_flag  CHAR(1) := '';
    v_status		CHAR(1) := '';
    v_bookflag      CHAR(1) := '';
    v_useflag       CHAR(1) := '';
    v_brand         VARCHAR2(4) := '기타';
    v_service_count NUMBER(4) := 0;
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2      NUMBER(10) := 0;
    /*=================================*/
    
    v_sc_web CHAR(1) := '';
    v_sc_mobile CHAR(1) := '';

BEGIN
    --set serverout on
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('==1');

  	LOOP
  	    IF i <= pac_Pricelist_DataLoop.p_index THEN

 			v_modelno_old           :=  NVL(pac_Pricelist_DataLoop.v_Modelno_old(i),0);
 			v_modelno_new           :=  NVL(pac_Pricelist_DataLoop.v_Modelno_new(i),0);
      		v_pl_no_old             :=  pac_Pricelist_DataLoop.v_Pl_no_old(i);
      		v_pl_no_new             :=  pac_Pricelist_DataLoop.v_Pl_no_new(i);
 			v_shop_code_old         :=  pac_Pricelist_DataLoop.v_Shop_code_old(i);
			v_shop_code_new         :=  pac_Pricelist_DataLoop.v_Shop_code_new(i);
 			v_price_old             :=  pac_Pricelist_DataLoop.v_Price_old(i);
 			v_price_new             :=  pac_Pricelist_DataLoop.v_Price_new(i);
 			v_srvflag_old           :=  NVL(pac_Pricelist_DataLoop.v_Srvflag_old(i), ' ');
 			v_srvflag_new           :=  NVL(pac_Pricelist_DataLoop.v_Srvflag_new(i), ' ');
 			v_status_old            :=  NVL(pac_Pricelist_DataLoop.v_Status_old(i), ' ');
 			v_status_new            :=  NVL(pac_Pricelist_DataLoop.v_Status_new(i), ' ');
 			v_esstockflag_old       :=  NVL(pac_Pricelist_DataLoop.v_Esstockflag_old(i), ' ');
 			v_esstockflag_new       :=  NVL(pac_Pricelist_DataLoop.v_Esstockflag_new(i), ' ');
 			v_coupon_old            :=  NVL(pac_Pricelist_DataLoop.v_Coupon_old(i),0);
 			v_coupon_new            :=  NVL(pac_Pricelist_DataLoop.v_Coupon_new(i),0);
 			v_jobtype_old           :=  NVL(pac_Pricelist_DataLoop.v_Jobtype_old(i), '0');
 			v_jobtype_new           :=  NVL(pac_Pricelist_DataLoop.v_Jobtype_new(i), '0');
 			v_instance_price_old    :=  NVL(pac_Pricelist_DataLoop.v_Instance_price_old(i),0);
			v_instance_price_new    :=  NVL(pac_Pricelist_DataLoop.v_Instance_price_new(i),0);
 			v_pjobcode_old          :=  pac_Pricelist_DataLoop.v_Pjobcode_old(i);
 			v_pjobcode_new          :=  pac_Pricelist_DataLoop.v_Pjobcode_new(i);
 			v_ca_code_old           :=  NVL(pac_Pricelist_DataLoop.v_Ca_code_old(i), ' ');
 			v_ca_code_new           :=  NVL(pac_Pricelist_DataLoop.v_Ca_code_new(i), ' ');
 			v_goodsnm_old           :=  NVL(pac_Pricelist_DataLoop.v_Goodsnm_old(i), ' ');
 			v_goodsnm_new           :=  NVL(pac_Pricelist_DataLoop.v_Goodsnm_new(i), ' ');
 			v_url_old               :=  NVL(pac_Pricelist_DataLoop.v_Url_old(i), ' ');
			v_url_new               :=  NVL(pac_Pricelist_DataLoop.v_Url_new(i), ' ');
 			v_imgurl_old            :=  NVL(pac_Pricelist_DataLoop.v_Imgurl_old(i), ' ');
 			v_imgurl_new            :=  NVL(pac_Pricelist_DataLoop.v_Imgurl_new(i), ' ');
 			v_imgurlflag_old        :=  NVL(pac_Pricelist_DataLoop.v_Imgurlflag_old(i),'0');
			v_imgurlflag_new        :=  NVL(pac_Pricelist_DataLoop.v_Imgurlflag_new(i),'0');
 			v_u_date_old            :=  pac_Pricelist_DataLoop.v_U_date_old(i);
 			v_u_date_new            :=  pac_Pricelist_DataLoop.v_U_date_new(i);
 			v_searchflag_old        :=  pac_Pricelist_DataLoop.v_Searchflag_old(i);
 			v_searchflag_new        :=  pac_Pricelist_DataLoop.v_Searchflag_new(i);
 			v_goodsfactory_old      :=  NVL(pac_Pricelist_DataLoop.v_Goodsfactory_old(i), ' ');
 			v_goodsfactory_new      :=  NVL(pac_Pricelist_DataLoop.v_Goodsfactory_new(i), ' ');
 			v_goodsbrand_old        :=  NVL(pac_Pricelist_DataLoop.v_Goodsbrand_old(i), ' ');
 			v_goodsbrand_new        :=  NVL(pac_Pricelist_DataLoop.v_Goodsbrand_new(i), ' ');
            
 			v_subside_old           :=  NVL(pac_Pricelist_DataLoop.v_Subside_old(i),0);
 			v_subside_new           :=  NVL(pac_Pricelist_DataLoop.v_Subside_new(i),0);
 			v_popular_new           :=  NVL(pac_Pricelist_DataLoop.v_Popular_new(i),0);
            
            v_option_flag2_old      :=  NVL(pac_Pricelist_DataLoop.v_Option_flag2_old(i),'0');
 			v_option_flag2_new      :=  NVL(pac_Pricelist_DataLoop.v_Option_flag2_new(i),'0');
            
            v_price_flag_old        :=  NVL(pac_Pricelist_DataLoop.v_Price_flag_old(i),'0');
			v_price_flag_new        :=  NVL(pac_Pricelist_DataLoop.v_Price_flag_new(i),'0');
            
            v_store_flag_old        :=  NVL(pac_Pricelist_DataLoop.v_Store_flag_old(i),'0');
			v_store_flag_new        :=  NVL(pac_Pricelist_DataLoop.v_Store_flag_new(i),'0');
            
            v_ca_code_dept_old        :=  NVL(pac_Pricelist_DataLoop.v_Ca_code_dept_old(i),'0');
			v_ca_code_dept_new        :=  NVL(pac_Pricelist_DataLoop.v_Ca_code_dept_new(i),'0');

 			v_status_tmp := '';
 			v_searchflag := '';
 			v_searchflag2 := '';
            
 			--v_pjobcodecnt := 0;
 			IF v_modelno_old<=0 THEN
 			    v_modelno_old:=0;
 			END IF;
 			IF v_modelno_new<=0 THEN
 			    v_modelno_new:=0;
 			END IF;

 		    --신규모델번호있음. -->신규모델에 대한 GOODS정보 변경
            v_modelno_new := NVL(v_modelno_new,0);

 		    IF v_modelno_new > 0 THEN
                --DBMS_OUTPUT.PUT_LINE('==2');
 		        IF v_modelno_old <> v_modelno_new OR v_pl_no_old <> v_pl_no_new OR v_shop_code_old <> v_shop_code_new OR
                    v_price_old <> v_price_new OR v_srvflag_old <> v_srvflag_new OR v_status_old <> v_status_new OR
     			    v_esstockflag_old <> v_esstockflag_new OR v_coupon_old <> v_coupon_new OR v_jobtype_old <> v_jobtype_new OR
                    v_subside_old <> v_subside_new OR v_option_flag2_old <> v_option_flag2_new OR v_price_flag_old <> v_price_flag_new OR
                    v_instance_price_old <> v_instance_price_new OR v_store_flag_old <> v_store_flag_new OR v_goodsbrand_old <> v_goodsbrand_new
                THEN
                    --=========================================================================================
                    --백화점 상품 (모델번호가 변경된 경우)
                    --=========================================================================================
                    IF  v_modelno_new > 0 and v_modelno_old <> v_modelno_new THEN 
                        UPDATE /*+ append NOLOGGING */ TBL_SAD_GOODS SET modelno=v_modelno_new WHERE pl_no=v_pl_no_new AND modelno <> v_modelno_new;
                    END IF;
                    --=========================================================================================
                    --DBMS_OUTPUT.PUT_LINE('==3');                    
                    --=========================================================================================
                    v_minprice4_new := -1;
                    IF v_store_flag_new = '1' OR v_store_flag_old = '1' THEN --백화점 상품
                        
                        BEGIN
                        
                            SELECT NVL(MIN(p.price), 0)
                            INTO v_minprice4_new
                            FROM TBL_PRICELIST p
                            WHERE p.modelno = v_modelno_new
                                AND p.status in ('0','8','9')
                                AND p.srvflag in ('0','L','S')
                                AND NVL(p.option_flag2,'0') = '0'
                                AND NVL(p.store_flag,'0') = '1'
                                AND NVL(p.price, 0) > 0
                                AND p.esstockflag = '0';

                            EXCEPTION WHEN OTHERS THEN
                                v_minprice4_new  := 0;
                        
                        END;
                            
                    END IF;
                    --=========================================================================================
                    
                    BEGIN
                        
                        --SELECT /*+ INDEX(IDX_PRICELIST_LIST2) */ NVL(AVG(p.price), 0)
                        /*
                        SELECT NVL(AVG(p.price), 0)
                            , NVL(MIN(p.price), 0)
                            --, MIN(price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                            ,MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END)
                            , NVL(MAX(p.price), 0)
                            , count(p.shop_code)

                        INTO v_avgprice_new, v_minprice_new, v_minprice2_new, v_maxprice_new, v_mallcnt_new
                        FROM TBL_PRICELIST p
                        WHERE p.modelno = v_modelno_new
                            AND p.status in ('0','8','9')
                            AND p.srvflag in ('0','L','S')
                            AND NVL(p.option_flag2,'0') = '0'
                            AND p.esstockflag = '0';
                        */
                        
                        SELECT NVL(AVG(p.price), 0)
                            , NVL(MIN(p.price), 0)
                            --, MIN(price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                            , MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END)
                            , NVL(MAX(p.price), 0)
                            , count(p.shop_code)
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        INTO v_avgprice_new, v_minprice_new, v_minprice2_new, v_maxprice_new, v_mallcnt_new
                        FROM TBL_PRICELIST p
                        WHERE p.modelno = v_modelno_new
                            AND p.status in ('0','8','9')
                            AND p.srvflag in ('0','L','S')
                            AND NVL(p.option_flag2,'0') = '0'
                            AND p.esstockflag = '0';
                        
                        EXCEPTION WHEN OTHERS THEN
                            v_avgprice_new := 0;
                            v_minprice_new := 0;
                            v_maxprice_new := 0;
                            v_mallcnt_new  := 0;
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            v_minprice2_new  := 0;
                            v_apflag_new := '0';
                    END;
                    
                    --=========================================================================================================================================
                    v_service_count := 0;
                    IF v_mallcnt_new = 0 THEN
                        BEGIN          
                        
                            SELECT NVL(modelno_group,0)                            
                            INTO v_modelno_group_new
                            FROM TBL_GOODS
                            WHERE modelno = v_modelno_new;
                            
                            EXCEPTION WHEN OTHERS THEN
                                v_modelno_group_new := 0;

                        END;
                       
                        BEGIN
                            IF v_modelno_group_new = 0 THEN
                                DELETE tbl_goods_middle_list WHERE modelno=v_modelno_new;
                            ELSE
                                BEGIN
                                    SELECT COUNT(*)                         
                                    INTO v_service_count
                                    FROM TBL_GOODS
                                    WHERE modelno_group = v_modelno_group_new
                                    AND jobcode>'0'
                                    AND cateflag='0'
                                    AND constrain IN ('1','5')
                                    AND mallcnt > 0;
                                    
                                    EXCEPTION WHEN OTHERS THEN
                                        v_service_count := 0;
                                END;
                                
                                IF v_service_count = 0 THEN
                                    DELETE tbl_goods_middle_list WHERE modelno=v_modelno_group_new;
                                END IF;
                                
                            END IF;
                        END;                        
                    END IF;
                    --=======================================================================================================================================================
                    BEGIN
                                                
                        SELECT NVL(MIN(p.price), 0)
                        INTO v_ap_minprice_new
                        FROM TBL_PRICELIST p, tbl_shoplist b
                        WHERE p.modelno = v_modelno_new
                            AND p.shop_code=b.shop_code
                            AND p.status in ('0','8','9')
                            AND p.srvflag in ('0','L','S')
                            AND NVL(p.option_flag2,'0') = '0'
                            AND NVL(b.apflag,'0') = '0'
                            AND p.esstockflag = '0';
                        
                        EXCEPTION WHEN OTHERS THEN
                            v_ap_minprice_new := 0;                           
                    END;
                    
                    IF v_ap_minprice_new > 0 AND v_ap_minprice_new = v_minprice_new THEN
                        v_apflag_new := '0';  --AP 아닌업체가 최저가
                    ELSE
                        v_apflag_new := '1'; 
                    END IF;
                    
                    IF (v_shop_code_new = 536 OR v_shop_code_new = 4027 OR v_shop_code_new = 5910) AND v_price_new = v_price_old THEN                        
                        v_apflag_new := '1'; 
                    END IF;
                    
                    --===============================================================================================================
                    --IF v_shop_code_new=47 OR v_shop_code_new=49 OR v_shop_code_new=57 OR v_shop_code_new=75 OR v_shop_code_new=90 OR v_shop_code_new=663 OR v_shop_code_new=806 OR v_shop_code_new=1878 
                    --    OR v_shop_code_new=5910 OR v_shop_code_new=6588 OR v_shop_code_new=6620 OR v_shop_code_new=6603 OR v_shop_code_new=6389 OR v_shop_code_new=6508 OR v_shop_code_new=6641 THEN
                        BEGIN
                            
                            SELECT NVL(MIN(p.instance_price), 0), NVL(COUNT(p.shop_code),0)
                            INTO v_minprice3_new, v_mallcnt3_new
                            FROM TBL_PRICELIST p
                            WHERE p.modelno = v_modelno_new
                                AND p.status in ('0','8','9')
                                AND p.srvflag in ('0','L','S')
                                AND NVL(p.option_flag2,'0') = '0'    
                                AND NVL(p.instance_price,0) > 0
                                AND p.esstockflag = '0'
                                AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4');
                                --AND (NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4');
                                --AND p.shop_code IN (47, 49, 57, 75, 90, 663, 806, 1878, 5910, 6588, 6620, 6603, 6389, 6508, 6641);

                            EXCEPTION WHEN OTHERS THEN
                                v_minprice3_new  := 0;
                                v_mallcnt3_new := 0;
                        
                        END;
                    --END IF;
                                        
                    
                    --===============================================================================================================
                    IF substr(v_ca_code_new,0,4)='0304' OR substr(v_ca_code_new,0,4)='0305' OR substr(v_ca_code_new,0,6)='020922' THEN
                        
                        BEGIN
                        
                            SELECT NVL(AVG(p.price), 0)
                            , NVL(MIN(p.price), 0)
                            --, MIN(price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                            , MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END)
                            , NVL(MAX(p.price), 0)
                            , count(p.shop_code) -- 16.12.22 lsm v_mallcnt_new 추가
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            INTO v_avgprice_new, v_minprice_new, v_minprice2_new, v_maxprice_new, v_mallcnt_new -- 16.12.22 lsm v_mallcnt_new 추가
                            
                            --SELECT NVL(MIN(p.price), 0) INTO v_minprice_new
                            FROM TBL_PRICELIST p
                            WHERE p.modelno = v_modelno_new
                                AND p.status in ('0','8','9')
                                AND p.srvflag in ('0','L','S')
                                AND (NVL(PRICE_FLAG,'0') = '0' OR NVL(AIRCONFEETYPE,'0') = '3' OR NVL(AIRCONFEETYPE,'0') = '4')
                                AND NVL(p.option_flag2,'0') = '0';
 
                            EXCEPTION WHEN OTHERS THEN
                                v_avgprice_new := 0; 
                                v_minprice_new := 0; 
                                /* 배송비 포함 최저가 nova23 2016.06.21*/
                                v_minprice2_new := 0;
                                v_maxprice_new := 0;
                                v_mallcnt_new := 0; -- 16.12.22 lsm v_mallcnt_new 추가

                        
                        END;

                    END IF;
                    
                    --IF v_minprice_new > 0 AND v_minprice3_new > 0 AND v_minprice_new < v_minprice3_new THEN
                    IF (v_minprice_new > 0 AND v_minprice_new < v_minprice3_new) OR v_minprice3_new = 0 THEN
                        v_minprice3_new := v_minprice_new;
                    END IF; 
                    --==========================================================================================                    
                    --DBMS_OUTPUT.PUT_LINE('---' || v_price_new ||'-' || v_minprice_new ||'-' || v_price_old);
                    --DBMS_OUTPUT.PUT_LINE('--000--');
                    
                    --IF (v_price_new <= v_minprice_new AND v_price_old <= v_minprice_new) 
                    --    OR (v_price_new <= v_minprice_new AND v_price_old >= v_minprice_new) 
                    --    OR (v_price_new >= v_minprice_new AND v_price_old <= v_minprice_new) THEN
                       --최저가 아니었는데 최저가로 바뀐 경우,최저가 이었는데 최저가로 아닌것으로 바뀐 경우
                        /*
                        BEGIN
                            SELECT NVL(count(*) ,0)
                            INTO m_count_tmp
                            FROM TBL_PRICELIST
                            WHERE modelno = v_modelno_new
                                AND status = '0'
                                AND srvflag = 'M'
                                AND price < v_minprice_new;
                            
                            IF m_count_tmp > 0 THEN
                                v_rsiflag_tmp :='1';
                            END IF;
                        END;                            
                        */
                        
                        --DBMS_OUTPUT.PUT_LINE('--1111--');
                        
                        IF v_minprice4_new >=0 THEN
                            IF v_apflag_new = '0' THEN
                                UPDATE /*+ append NOLOGGING */ TBL_GOODS SET
                                    avgprice = v_avgprice_new,
                                    minprice = v_minprice_new,
                                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                                    minprice2 = v_minprice2_new,
                                    minprice3 = v_minprice3_new,
                                    minprice4 = v_minprice4_new,
                                    maxprice = v_maxprice_new,
                                    mallcnt = v_mallcnt_new,
                                    mallcnt3 = v_mallcnt3_new,
                                    rsiflag = v_rsiflag_tmp,
                                    moddate = sysdate
                                WHERE modelno = v_modelno_new;
                                 
                            ELSE
                                UPDATE /*+ append NOLOGGING */ TBL_GOODS SET
                                    avgprice = v_avgprice_new,
                                    minprice = v_minprice_new,
                                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                                    minprice2 = v_minprice2_new,
                                    minprice3 = v_minprice3_new,
                                    minprice4 = v_minprice4_new,
                                    maxprice = v_maxprice_new,
                                    mallcnt = v_mallcnt_new,
                                    mallcnt3 = v_mallcnt3_new,
                                    rsiflag = v_rsiflag_tmp,
                                    moddate = sysdate
                                WHERE modelno = v_modelno_new
                                  AND (minprice <> v_minprice_new 
                                  OR mallcnt <> v_mallcnt_new 
                                  OR mallcnt3 <> v_mallcnt3_new 
                                  OR rsiflag <> v_rsiflag_tmp 
                                  OR minprice=v_price_new 
                                  /* 배송비 포함 최저가 nova23 2016.06.21*/
                                  OR minprice2 <> v_minprice2_new 
                                  OR NVL(minprice3,0) <> v_minprice3_new 
                                  OR NVL(minprice4,0) <> v_minprice4_new 
                                  );
                             END IF;
                              
                        ELSE
                            IF v_apflag_new = '0' THEN
                                UPDATE /*+ append NOLOGGING */ TBL_GOODS SET
                                    avgprice = v_avgprice_new,
                                    minprice = v_minprice_new,
                                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                                    minprice2 = v_minprice2_new,
                                    minprice3 = v_minprice3_new,
                                    maxprice = v_maxprice_new,
                                    mallcnt = v_mallcnt_new,
                                    mallcnt3 = v_mallcnt3_new,
                                    rsiflag = v_rsiflag_tmp,
                                    moddate = sysdate
                                WHERE modelno = v_modelno_new;
                                  
                            ELSE
                                UPDATE /*+ append NOLOGGING */ TBL_GOODS SET
                                    avgprice = v_avgprice_new,
                                    minprice = v_minprice_new,
                                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                                    minprice2 = v_minprice2_new,
                                    minprice3 = v_minprice3_new,
                                    maxprice = v_maxprice_new,
                                    mallcnt = v_mallcnt_new,
                                    mallcnt3 = v_mallcnt3_new,
                                    rsiflag = v_rsiflag_tmp,
                                    moddate = sysdate
                                WHERE modelno = v_modelno_new
                                  AND (minprice <> v_minprice_new 
                                  OR mallcnt <> v_mallcnt_new 
                                  OR mallcnt3 <> v_mallcnt3_new 
                                  OR rsiflag <> v_rsiflag_tmp 
                                  OR minprice = v_price_new 
                                  OR NVL(minprice3,0) <> v_minprice3_new 
                                  OR NVL(minprice4,0) <> v_minprice4_new 
                                  );
                            
                            END IF;
                        
                        END IF;
                    
                    /*
                    ELSE       
                    
                        DBMS_OUTPUT.PUT_LINE('--222--');
                    
                        IF v_minprice4_new >=0 THEN
                            
                            UPDATE TBL_GOODS SET
                                avgprice = v_avgprice_new,
                                minprice = v_minprice_new,
                                minprice2 = v_minprice2_new,                                
                                minprice3 = v_minprice3_new,   
                                minprice4 = v_minprice4_new,
                                maxprice = v_maxprice_new,
                                mallcnt = v_mallcnt_new,
                                mallcnt3 = v_mallcnt3_new,
                                rsiflag = v_rsiflag_tmp,
                                moddate = sysdate
                            WHERE modelno = v_modelno_new
                              AND (minprice <> v_minprice_new 
                              OR mallcnt <> v_mallcnt_new 
                              OR mallcnt3 <> v_mallcnt3_new 
                              OR rsiflag<>v_rsiflag_tmp 
                              OR minprice=v_price_new 
                              OR minprice2 <> v_minprice2_new 
                              OR minprice3 <> v_minprice3_new 
                              OR minprice4 <> v_minprice4_new 
                              );
                              
                              DBMS_OUTPUT.PUT_LINE('--333--');
                        
                        ELSE
                            
                            UPDATE TBL_GOODS SET
                                avgprice = v_avgprice_new,
                                minprice = v_minprice_new,
                                minprice2 = v_minprice2_new,                                
                                minprice3 = v_minprice3_new,   
                                maxprice = v_maxprice_new,
                                mallcnt = v_mallcnt_new,
                                mallcnt3 = v_mallcnt3_new,
                                rsiflag = v_rsiflag_tmp,
                                moddate = sysdate
                            WHERE modelno = v_modelno_new
                              AND (minprice <> v_minprice_new 
                              OR mallcnt <> v_mallcnt_new 
                              OR mallcnt3 <> v_mallcnt3_new 
                              OR rsiflag <> v_rsiflag_tmp 
                              OR minprice=v_price_new 
                              OR minprice2 <> v_minprice2_new 
                              OR minprice3 <> v_minprice3_new 
                              );
                              
                              DBMS_OUTPUT.PUT_LINE('--4444--');
                        
                        END IF;
                        
                    END IF;      
                    */
                    --=============================================================================================                    
                END IF;
 		    END IF;            

 		    --모델번호가 바뀜==> 과거모델번호에 대한 GOODS정보 변경
            v_modelno_old := NVL(v_modelno_old,0);
 		    IF v_modelno_old > 0 AND v_modelno_new <> v_modelno_old  THEN
  			    IF v_modelno_old <> v_modelno_new OR v_pl_no_old <> v_pl_no_new OR v_shop_code_old <> v_shop_code_new OR
                    v_price_old <> v_price_new OR v_srvflag_old <> v_srvflag_new OR v_status_old <> v_status_new OR
     			    v_esstockflag_old <> v_esstockflag_new OR v_coupon_old <> v_coupon_new OR v_jobtype_old <> v_jobtype_new OR
                    v_instance_price_old <> v_instance_price_new OR v_subside_old <> v_subside_new OR v_option_flag2_old <> v_option_flag2_new THEN
     			    
                    BEGIN
                    
                     --=========================================================================================
                    --IF v_store_flag_new = '1' THEN --백화점 상품
                        
                        BEGIN
                        
                            SELECT NVL(MIN(p.price), 0)
                            INTO v_minprice4_old
                            FROM TBL_PRICELIST p
                            WHERE p.modelno = v_modelno_old
                                AND p.status in ('0','8','9')
                                AND p.srvflag in ('0','L','S')
                                AND NVL(p.option_flag2,'0') = '0'
                                AND NVL(p.store_flag,'0') = '1'
                                AND NVL(p.price,0) > 0
                                AND p.esstockflag = '0';

                            EXCEPTION WHEN OTHERS THEN
                                v_minprice4_old  := 0;
                        
                        END;
                            
                    --END IF;
                    --=========================================================================================
                    
				    SELECT NVL(AVG(p.price), 0)
                        , NVL(MIN(p.price), 0)
                        --, MIN(p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                        , MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END)
                        , NVL(MAX(p.price), 0)
                        , count(p.shop_code)
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        INTO v_avgprice_old, v_minprice_old, v_minprice2_old, v_maxprice_old, v_mallcnt_old
                        FROM TBL_PRICELIST p
                        WHERE p.modelno = v_modelno_old
                            AND p.status in ('0','8','9')
                            AND p.srvflag in ('0','L','S')
                            AND NVL(p.option_flag2,'0') = '0'
                            AND p.esstockflag = '0';

                        EXCEPTION WHEN OTHERS THEN
                            v_avgprice_old := 0;
                            v_minprice_old := 0;
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            v_minprice2_old := 0;
                            v_maxprice_old := 0;
                            v_mallcnt_old  := 0;

                    END;
                    
                     
                    BEGIN
                    
                        SELECT NVL(MIN(p.instance_price), 0), NVL(COUNT(p.shop_code),0)
                        INTO v_minprice3_old, v_mallcnt3_old
                        FROM TBL_PRICELIST p
                        WHERE p.modelno = v_modelno_old                            
                            AND p.status IN ('0','8','9')
                            AND p.srvflag in ('0','L','R')
                            AND NVL(p.instance_price,0) > 0
                            AND NVL(p.option_flag2,'0') = '0'
                            AND NVL(p.price,'0') > 0
                            AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4');
                            
                            --AND p.shop_code IN (47, 49, 57, 75, 90, 663, 806, 1878, 5910, 6588, 6620, 6603, 6389, 6508, 6641)

                        EXCEPTION WHEN OTHERS THEN
                            v_minprice3_old  := 0;
                            v_mallcnt3_old := 0;
                    
                    END;                    
                                        
                    --IF v_minprice_old > 0 AND v_minprice3_old > 0 AND v_minprice_old < v_minprice3_old THEN                    
                    IF (v_minprice_old > 0 AND v_minprice_old < v_minprice3_old) OR v_minprice3_old = 0 THEN
                        v_minprice3_old := v_minprice_old;
                    END IF; 
                    --==================================================================================
                    IF substr(v_ca_code_new,0,4)='0304' OR substr(v_ca_code_new,0,4)='0305' OR substr(v_ca_code_new,0,6)='020922' THEN
                        
                        BEGIN
                        
                            SELECT NVL(MIN(p.price), 0),
                                   MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END),
                                   NVL(AVG(p.price), 0),
                                   NVL(MAX(p.price), 0)
                            INTO v_minprice_old,
                                /* 배송비 포함 최저가 nova23 2016.06.21*/
                                 v_minprice2_old,
                                 v_avgprice_old, 
                                 v_maxprice_old
                            FROM TBL_PRICELIST p
                            WHERE p.modelno = v_modelno_old
                                AND p.status in ('0','8','9')
                                AND p.srvflag in ('0','L','S')
                                AND (NVL(PRICE_FLAG,'0') = '0' OR NVL(AIRCONFEETYPE,'0') = '3' OR NVL(AIRCONFEETYPE,'0') = '4')
                                AND NVL(p.option_flag2,'0') = '0';
 
                            EXCEPTION WHEN OTHERS THEN
                                v_minprice_old := 0;
                                /* 배송비 포함 최저가 nova23 2016.06.21*/
                                v_minprice2_old := 0;
                                v_avgprice_old := 0;
                                v_maxprice_old := 0;
                        
                        END;

                    END IF;
                    --==================================================================================
                    IF v_srvflag_new='M' AND v_price_new <= v_minprice_old AND v_status_new='0' THEN
                        v_rsiflag_tmp :='1';
                    END IF;                    

                    UPDATE /*+ append NOLOGGING */ TBL_GOODS SET
                        avgprice = v_avgprice_old,
                        minprice = v_minprice_old,
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        minprice2 = v_minprice2_old,
                        minprice3 = v_minprice3_old,
                        --minprice4 = v_minprice4_old,
                        maxprice = v_maxprice_old,
                        mallcnt = v_mallcnt_old,
                        mallcnt3 = v_mallcnt3_old,
                        rsiflag = v_rsiflag_tmp,
                        moddate = sysdate
                    WHERE modelno = v_modelno_old
                       AND (minprice <> v_minprice_old                            
                            OR mallcnt <> v_mallcnt_old
                            OR mallcnt3 <> v_mallcnt3_old
                            OR rsiflag <> v_rsiflag_tmp 
                            OR minprice=v_price_new
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            OR minprice2 <> v_minprice2_old
                            OR minprice3 <> v_minprice3_old
                            --OR minprice4 <> v_minprice4_old
                            );
                END IF;
     		END IF;

            /*=====================================================================*/
            /*다이퀘스트*/
            /*=====================================================================*/
            v_status := '';
                        
            IF v_modelno_new <= 0 AND v_modelno_old > 0 THEN
                v_status := 'I';
            ELSE
                IF v_modelno_new > 0 AND v_modelno_old <= 0 THEN
                    v_status := 'D';
                END IF;
            END IF;
            
            IF v_modelno_new <= 0 THEN
            
               
                IF v_ca_code_dept_old <> v_ca_code_dept_new THEN
                    v_status := 'I';
                END IF;
                
                IF v_instance_price_old <> v_instance_price_new OR v_price_old <> v_price_new THEN
                    v_status := 'I';
                END IF;
            
                IF (v_status_new='0' OR v_status_new='8' OR v_status_new='9') THEN
                    IF (v_srvflag_new='0'  OR v_srvflag_new='L' OR v_srvflag_new='S' OR v_srvflag_new='Z' OR v_srvflag_new='2' OR v_srvflag_new='3' OR v_srvflag_new='O' OR v_srvflag_new='D' OR v_srvflag_new='9')  THEN
                        IF v_status_old <> v_status_new OR v_srvflag_old <> v_srvflag_new THEN
                            v_status := 'I';
                        END IF;  
                    END IF;
                    
                    IF (v_srvflag_old='0'  OR v_srvflag_old='L' OR v_srvflag_old='S' OR v_srvflag_old='Z' OR v_srvflag_old='2' OR v_srvflag_old='3' OR v_srvflag_old='O' OR v_srvflag_new='D' OR v_srvflag_old='9')  THEN
                        IF v_srvflag_new='1' OR v_srvflag_new='4' THEN
                            v_status := 'D';
                        END IF;  
                    END IF;
                    --DBMS_OUTPUT.PUT_LINE('==2==' || v_status);  
                ELSE
                    --DBMS_OUTPUT.PUT_LINE('==3==' || v_status || '==' || v_status_new || '==' || v_status_old);
                    IF (v_status_old='0' OR v_status_old='8' OR v_status_old='9') AND (v_srvflag_old='0'  OR v_srvflag_old='L' OR v_srvflag_old='S' OR v_srvflag_old='Z' OR v_srvflag_old='2' OR v_srvflag_old='3' OR v_srvflag_old='O' 
                        OR v_srvflag_new='D' OR v_srvflag_old='9') THEN                        
                        IF (v_status_new<>'0' AND v_status_new<>'8' AND v_status_new<>'9') OR (v_srvflag_new<>'0' AND v_srvflag_new<>'L' AND v_srvflag_new<>'S' AND v_srvflag_new<>'Z' AND v_srvflag_new<>'2' 
                            AND v_srvflag_new<>'3' AND v_srvflag_new<>'O' AND v_srvflag_new<>'D' ) THEN
                            v_status := 'D';
                        END IF;
                          
                    END IF;
                    
                END IF;
            END IF;
            
            --DBMS_OUTPUT.PUT_LINE('==v_status==' || v_status || '--' || v_ca_code_dept_old || '--' || v_ca_code_dept_new);
            
            IF (v_status='I' OR v_status='D') 
                AND v_ca_code_new <> ' ' 
                AND RTRIM(v_ca_code_new) IS NOT NUll 
                --AND v_shop_code_new <> 6640 AND v_shop_code_new <> 6641 //20150625 조은정
                --AND substr(v_ca_code_new,0,4) <> '8702'
            THEN
            
                v_search_key := 'P' || v_pl_no_new;
                v_modelno := '0';
                v_group_flag := '0';

                v_category := RTRIM(v_ca_code_new);
                IF v_category = ' ' OR v_category is null THEN
                    v_category := '000000';
                END IF;
                IF LENGTH(RTRIM(v_category))=2 THEN
                    v_category := RTRIM(v_category) || '0000';
                END IF;
                IF LENGTH(RTRIM(v_category))=4 THEN
                    v_category := RTRIM(v_category) || '00';
                END IF;
                
                --DBMS_OUTPUT.ENABLE;
                --DBMS_OUTPUT.PUT_LINE('==' || LENGTH(v_modelnm) || '==');
                                 
                --v_modelnm := replace(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(v_goodsnm_new,'[0-7]%할인',''),'[0-9]{3,6}원',''),'[0-9]{1,3},[0-9]{3}원',''),'_',' ') || ' ' || replace(v_goodsfactory_new,'1004','');
                
                --v_modelnm := UDF_GOODSNM_REMOVE(v_goodsnm_new) || ' ' || replace(v_goodsfactory_new,'1004','');
                v_modelnm := UDF_GOODSNM_REMOVE(v_goodsnm_new);                
                IF SUBSTR(v_category,0,4) = '9501' THEN
                    IF length(v_modelnm) > 180 THEN
                        v_modelnm := substr(v_modelnm,0,180) || ' 음반 앨범';
                    ELSE
                        v_modelnm := v_modelnm || ' 음반 앨범';
                    END IF;
                END IF;
                
                --v_modelnm2 := replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(UDF_GOODSNM_REMOVE(v_modelnm) || ' ' || v_goodsfactory_new,'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' '),',',' ');
                --IF length(v_modelnm2) > 180 THEN
                --    v_modelnm2 := substr(v_modelnm2,0,180);
                --END IF;
                --IF v_store_flag_new='1' THEN
                --    SELECT UDF_GOODSNM_REMOVE(v_goodsnm_new) || ' ' || v_goodsfactory_new INTO v_modelnm2 FROM DUAL;
                --ELSE
                --    v_modelnm2 := '';
                --END IF;
                    
                v_shop_code := v_shop_code_new;
                
                --v_factory := v_goodsfactory_new;
                v_factory := '[추가]';
                --v_popular := v_price_new * -1;
                
                IF NVL(v_popular_new,0) > 0 THEN
                    v_popular := v_popular_new + 30000000;
                ELSE
                    v_popular := (v_price_new * -1) + 30000000;
                END IF;
                
                --v_popular2 := -1000;
                /*일반상품 인기도 수정 2017.1.10*/
                /*v_popular2 := v_popular_new - 1000000;*/
                v_popular2 := v_popular_new;
                v_minprice := v_price_new;
                v_maxprice := v_price_new;
                v_minprices := v_price_new;
                v_c_date := TO_CHAR(v_u_date_new,'YYYYMMDDHH24MISS');                
                v_mallcnt := 1;
                v_spec := '';
                v_openexpectflag := '0';
                v_condiname := '';
                v_keyword1 := '';
                v_keyword2 := '';
                v_brandcode1 := '';
                v_brandcode2 := '';
                v_specopt := '';
                v_service_flag := '2';
                
                IF substr(v_ca_code_new,0,2) = '93' THEN
                    v_bookflag :='1';
                    v_useflag :='0';
                ELSE
                    v_bookflag :='0';
                    v_useflag :='1';
                END IF;
                
                --DELETE TBL_SEARCH_LOG WHERE SEARCH_KEY = v_search_key;
                
                --======================================================================================
                --UDF_SC_CHECK(v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER)
                v_sc_web := UDF_SC_CHECK('0', v_modelno, '1', v_shop_code);
                v_sc_mobile := UDF_SC_CHECK('0', v_modelno, '2', v_shop_code);
                --======================================================================================
                /*
                IF v_shop_code_new=47 OR v_shop_code_new=49 OR v_shop_code_new=57 OR v_shop_code_new=75 OR v_shop_code_new=90 OR v_shop_code_new=663 OR v_shop_code_new=806 OR v_shop_code_new=1878 
                OR v_shop_code_new=5910 OR v_shop_code_new=6588 OR v_shop_code_new=6620 OR v_shop_code_new=6603 OR v_shop_code_new=6389 OR v_shop_code_new=6508 OR v_shop_code_new=6641 THEN
                    IF v_instance_price_new > v_price_new THEN
                        v_instance_price_new := v_price_new;
                    END IF;
                ELSE
                    v_instance_price_new := 0;
                END IF;
                */
                --======================================================================================
                --DBMS_OUTPUT.PUT_LINE('==v_status==' || v_status || '--' || v_ca_code_dept_old || '--' || v_ca_code_dept_new);
                
                IF v_store_flag_new = '1' AND LENGTH(v_ca_code_dept_new) >= 4 THEN
                    v_minprice4_new := v_price_new;
                    --v_ca_code_dept_new := SUBSTR(v_ca_code_dept_new,0,6);
                    v_ca_code_dept_new := v_ca_code_dept_new;
                ELSE
                    v_minprice4_new := '0';
                    v_ca_code_dept_new := '';
                END IF;
                

                /* 배송비 포함 최저가 nova23 2016.06.21*/
                INSERT INTO /*+ append NOLOGGING */ TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
                       openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag,weight,sc_web,sc_mobile,store_flag,minprice3,minprice2,ca_dept_code,minprice4,brand,
                       goodsbrand,maxprice3)
                VALUES(v_search_key,v_modelno,v_pl_no_new,v_group_flag,v_category,v_category,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
                        v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,v_status,0,v_bookflag,v_useflag,0,v_sc_web,v_sc_mobile,
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        v_store_flag_new,v_instance_price_new,v_minprice2_new,v_ca_code_dept_new,v_minprice4_new,v_brand,v_goodsbrand,v_instance_price_new);
            END IF;
            /*======================================================================*/            
 	 	    i := i + 1;
 		ELSE
   		    EXIT;
 		END IF;
        
	END LOOP;

 	pac_Pricelist_DataLoop.p_index := 0;
 	i := 1;

END;

ALTER TRIGGER "DBENURI"."ASIS_TRG_SEN_UPPRICELIST" DISABLE