/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_SEN_INPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 17:05:11
 *        Modify: 2018-05-11 10:51:21
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_SEN_INPRICELIST" AFTER INSERT ON dbenuri.ASIS_TBL_PRICELIST
REFERENCING NEW AS NEW OLD AS OLD
DECLARE
    v_modelno_new           tbl_pricelist.modelno%TYPE :=  0;
    v_pl_no_new             tbl_pricelist.pl_no%TYPE :=  0;
    v_shop_code_new         tbl_pricelist.shop_code%TYPE := 0;
    v_goodsnm_new           tbl_pricelist.goodsnm%TYPE := '';
    v_ca_code_new           tbl_pricelist.ca_code%TYPE := '';
    v_pjobcode_new          tbl_pricelist.pjobcode%TYPE := '';
    v_jobtype_new           tbl_pricelist.jobtype%TYPE := '';
    v_price_new             tbl_pricelist.price%TYPE := 0;
    v_url_new               tbl_pricelist.url%TYPE := '';
    v_u_date_new            tbl_pricelist.u_date%TYPE := null;
    v_imgurl_new            tbl_pricelist.imgurl%TYPE := '';
    v_imgurlflag_new        tbl_pricelist.imgurlflag%TYPE := '';
    v_searchflag_new        tbl_pricelist.searchflag%TYPE := '';
    v_goodsfactory_new      tbl_pricelist.goodsfactory%TYPE := '';
    v_goodsbrand_new        tbl_pricelist.goodsbrand%TYPE := '';
    
    v_instance_price_new    tbl_pricelist.instance_price%TYPE := 0;
    v_srvflag_new			tbl_pricelist.srvflag%TYPE := '';
    v_status_new			tbl_pricelist.status%TYPE := '';
    v_popular_new           tbl_pricelist.popular%TYPE :=  0;    
    
    v_option_flag2_new      tbl_pricelist.option_flag2%TYPE := '0';
    v_store_flag_new        tbl_pricelist.store_flag%TYPE := '0';
    v_ca_code_dept_new      tbl_pricelist.ca_code_dept%TYPE := '0';

    v_minprice              tbl_goods.minprice%TYPE := 0;
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2             tbl_goods.minprice2%TYPE := 0;
    v_minprice3             tbl_goods.minprice3%TYPE := 0;
    v_socialprice           tbl_goods.socialprice%TYPE := 0;
    v_avgprice              tbl_goods.avgprice%TYPE := 0;
    v_maxprice              tbl_goods.maxprice%TYPE := 0;
    v_mallcnt               tbl_goods.mallcnt%TYPE := 0;
    v_mallcnt3              tbl_goods.mallcnt3%TYPE := 0;
    
    v_minprice4_new           tbl_goods.minprice4%TYPE := 0;

    v_rsiflag_tmp			CHAR(1) := '';
    m_count_tmp             NUMBER(6) := 0;
          
    /*=================================*/
    v_search_key 	        VARCHAR2(13) := '';
    v_modelno               NUMBER(10) := 0;
    v_group_flag            CHAR(1) := '';
    v_category              VARCHAR2(100) := '';
    v_modelnm               VARCHAR2(400) := '';
    v_modelnm2              VARCHAR2(400) := '';
    v_shop_code             NUMBER(8) := 0;
    v_shop_name             VARCHAR2(60) := '';    
    v_factory               VARCHAR2(100) := '';
    v_goodsbrand            VARCHAR2(100) := '';
    v_popular               NUMBER(10) := 0;
    v_popular2              NUMBER(10) := 0;
    --v_minprice            NUMBER(10) := 0;
    v_minprices             VARCHAR2(2000) := '';
    --v_maxprice            NUMBER(10) := 0;
    v_c_date                VARCHAR2(16) := '';
    --v_mallcnt             NUMBER(6) := 0;
    v_spec                  VARCHAR2(4000) := '';
    v_openexpectflag        CHAR(1) := '';
    v_condiname             VARCHAR2(2000) := '';    
    v_keyword1              VARCHAR2(2600) := '';
    v_keyword2              VARCHAR2(2600) := '';
    v_brandcode1            VARCHAR2(1000) := '';
    v_brandcode2            VARCHAR2(1000) := '';
    v_specopt               VARCHAR2(200) := '';
    v_service_flag          CHAR(1) := '';
    v_status		        CHAR(1) := '';
    v_bookflag              CHAR(1) := '';
    v_useflag               CHAR(1) := '';    
    v_brand                 VARCHAR2(4) := '기타';
    
    /*=================================*/    
    v_sc_web CHAR(1) := '';
    v_sc_mobile CHAR(1) := '';

BEGIN
    v_modelno_new           :=  NVL(pac_Pricelist_Data.v_Modelno_new, 0);
    v_pl_no_new             :=  pac_Pricelist_Data.v_Pl_no_new;
    v_shop_code_new         :=  pac_Pricelist_Data.v_Shop_code_new;
    v_goodsnm_new           :=  NVL(pac_Pricelist_Data.v_Goodsnm_new, ' ');
    v_ca_code_new           :=  NVL(pac_Pricelist_Data.v_Ca_code_new, ' ');
    v_pjobcode_new          :=  pac_Pricelist_Data.v_Pjobcode_new;
    v_jobtype_new           :=  pac_Pricelist_Data.v_Jobtype_new;
    v_price_new             :=  pac_Pricelist_Data.v_Price_new;
    v_url_new               :=  NVL(pac_Pricelist_Data.v_Url_new, ' ');
    v_imgurl_new            :=  NVL(pac_Pricelist_Data.v_Imgurl_new, ' ');
    v_imgurlflag_new        :=  pac_Pricelist_Data.v_Imgurlflag_new;
    v_u_date_new            :=  pac_Pricelist_Data.v_Udate_new;
    v_searchflag_new        :=  pac_Pricelist_Data.v_Searchflag_new;
    v_goodsfactory_new      :=  NVL(pac_Pricelist_Data.v_Goodsfactory_new, ' ');
    v_goodsbrand_new      :=  NVL(pac_Pricelist_Data.v_Goodsbrand_new, ' ');
    
    v_instance_price_new    :=  NVL(pac_Pricelist_Data.v_Instance_price_new,0);
    v_srvflag_new		    :=  pac_Pricelist_Data.v_Srvflag_new;
    v_status_new		    :=  pac_Pricelist_Data.v_Status_new;
    v_popular_new           :=  NVL(pac_Pricelist_Data.v_Popular_new,0);
    v_option_flag2_new      :=  NVL(pac_Pricelist_Data.v_option_flag2_new, '0');

    IF v_modelno_new<0 THEN
        v_modelno_new :=0;
    END IF;

    --모델번호있음.-->신규모델에 대한 GOODS정보 변경
    v_modelno_new := NVL(v_modelno_new,0);
    
    IF v_modelno_new > 0 AND (v_srvflag_new='0'  OR v_srvflag_new='L' OR v_srvflag_new='R' OR v_srvflag_new='M') 
        AND (v_status_new='0' OR v_status_new='8' OR v_status_new='9') THEN
        
        IF v_option_flag2_new = '0' THEN --정상상품
            
            BEGIN
                SELECT NVL(AVG(p.price), 0)
                    , NVL(MIN(p.price), 0)
                    --, MIN(p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500)))
                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                    , MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END)
                    , NVL(MAX(p.price), 0)
                    , count(p.shop_code)
                INTO v_avgprice, v_minprice, v_minprice2, v_maxprice, v_mallcnt
                FROM TBL_PRICELIST p
                WHERE p.modelno = v_modelno_new
                    AND p.status IN ('0','8','9')
                    AND p.srvflag IN ('0','L','R')
                    AND NVL(p.option_flag2,'0') = '0'
                    AND p.esstockflag = '0';
                    
                EXCEPTION WHEN OTHERS THEN
                    v_avgprice :=0;
                    v_minprice :=0;
                    v_maxprice :=0;
                    v_mallcnt  :=0;
            END;
            
            --=======================================================================================================================
            --IF v_shop_code_new=47 OR v_shop_code_new=49 OR v_shop_code_new=57 OR v_shop_code_new=75 OR v_shop_code_new=90 OR v_shop_code_new=663 OR v_shop_code_new=806 OR v_shop_code_new=1878 
            --    OR v_shop_code_new=5910 OR v_shop_code_new=6588 OR v_shop_code_new=6620 OR v_shop_code_new=6603 OR v_shop_code_new=6389 OR v_shop_code_new=6508 OR v_shop_code_new=6641 THEN
                
                BEGIN
                
                    SELECT NVL(MIN(p.instance_price),0), NVL(COUNT(p.shop_code),0)
                      INTO v_minprice3 , v_mallcnt3
                    FROM TBL_PRICELIST p
                     WHERE p.modelno = v_modelno_new
                       AND p.status IN ('0','8','9')
                       AND p.srvflag IN ('0','L','R')
                       AND NVL(p.instance_price,0) > 0
                       AND NVL(p.option_flag2,'0') = '0'
                       AND NVL(p.price,'0') > 0
                       AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4');
                       --AND p.shop_code IN (47, 49, 57, 75, 90, 663, 806, 1878, 5910, 6588, 6620, 6603, 6389, 6508, 6641);

                    EXCEPTION WHEN OTHERS THEN
                        v_minprice3 := 0;  
                        v_mallcnt3 := 0;                        
                END;                    
                
            --END IF;
            
            --IF v_minprice > 0 AND v_minprice3 > 0 AND v_minprice < v_minprice3 THEN
            IF (v_minprice > 0 AND v_minprice < v_minprice3) OR v_minprice3 = 0 THEN
                v_minprice3 := v_minprice;
            END IF; 
            --=======================================================================================================================
            
            IF substr(v_ca_code_new,0,4)='0304' OR substr(v_ca_code_new,0,4)='0305' OR substr(v_ca_code_new,0,6)='020932'THEN
                            
                BEGIN
                
                    SELECT NVL(MIN(p.price), 0),
                           --MIN(price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))),
                           MIN(CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(deliveryinfo, '무료배송', 0, NVL(deliveryinfo2, 2500))) END),
                           NVL(AVG(p.price), 0),                           
                           NVL(MAX(p.price), 0)  
                           , count(p.shop_code) -- 16.12.22 lsm v_mallcnt 추가
                    INTO v_minprice,
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                         v_minprice2,
                         v_avgprice,
                         v_maxprice      
                         , v_mallcnt -- 16.12.22 lsm v_mallcnt_new 추가
                    FROM TBL_PRICELIST p
                    WHERE p.modelno = v_modelno_new
                        AND p.status in ('0','8','9')
                        AND p.srvflag in ('0','L','R')
                        AND (NVL(PRICE_FLAG,'0') = '0' OR NVL(AIRCONFEETYPE,'0') = '3' OR NVL(AIRCONFEETYPE,'0') = '4')
                        AND NVL(p.option_flag2,'0') = '0';

                    EXCEPTION WHEN OTHERS THEN
                         v_avgprice :=0;
                            v_minprice :=0;
                            v_maxprice :=0;
                            v_mallcnt  :=0;
                            

        
                                
                END;

            END IF;
            --======================================================================================

            IF v_price_new < v_minprice THEN
               --최저가이거나 작은(M)인 경우만 처리
                BEGIN
                    SELECT NVL(count(*) ,0)
                    INTO m_count_tmp
                    FROM TBL_PRICELIST
                    WHERE modelno = v_modelno_new
                        AND status = '0'
                        AND srvflag = 'M'
                        AND price < v_minprice;
                    
                    IF m_count_tmp > 0 THEN
                        v_rsiflag_tmp :='1';
                    END IF;                                
                END;
                
                --IF v_minprice3 > 0 THEN
                    UPDATE TBL_GOODS SET
                        avgprice = v_avgprice,
                        minprice = v_minprice,
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        minprice2 = v_minprice2,
                        minprice3 = v_minprice3,
                        maxprice = v_maxprice,
                        mallcnt = v_mallcnt,
                        mallcnt3 = v_mallcnt3,
                        rsiflag = v_rsiflag_tmp,
                        moddate = sysdate
                    WHERE modelno = v_modelno_new;
                /*
                ELSE
                    UPDATE TBL_GOODS SET
                        avgprice = v_avgprice,
                        minprice = v_minprice,
                        minprice2 = v_minprice2,
                        maxprice = v_maxprice,
                        mallcnt = v_mallcnt,
                        mallcnt3 = v_mallcnt3,
                        rsiflag = v_rsiflag_tmp,
                        moddate = sysdate
                    WHERE modelno = v_modelno_new;
               END IF;
               */
                
            ELSE
            
                --IF v_minprice3 > 0 THEN
                    UPDATE TBL_GOODS SET
                        avgprice = v_avgprice,
                        minprice = v_minprice,
                        /* 배송비 포함 최저가 nova23 2016.06.21*/
                        minprice2 = v_minprice2,
                        minprice3 = v_minprice3,
                        maxprice = v_maxprice,
                        mallcnt = v_mallcnt,
                        mallcnt3 = v_mallcnt3,
                        moddate = sysdate
                    WHERE modelno = v_modelno_new;
                /*
                ELSE
                    UPDATE TBL_GOODS SET
                        avgprice = v_avgprice,
                        minprice = v_minprice,
                        minprice2 = v_minprice2,
                        maxprice = v_maxprice,
                        mallcnt = v_mallcnt,
                        moddate = sysdate
                    WHERE modelno = v_modelno_new;
                    
                END IF;
                */
            
            END IF;
        /*
        ELSE
             
            IF v_option_flag2_new = '2' THEN --소셜상품
            
                BEGIN
                
                    SELECT 
                        NVL(MIN(p.price), 0)                                
                    INTO v_socialprice
                    FROM TBL_PRICELIST p
                    WHERE p.modelno = v_modelno_new
                        AND p.status IN ('0','8','9')
                        AND p.srvflag IN ('0','L','S')                        
                        AND NVL(p.option_flag2,'0') = '2'
                        and NVL(p.solddate,sysdate) >= sysdate;

                    EXCEPTION WHEN OTHERS THEN
                        v_socialprice := 0;
                END;
                
                
                UPDATE TBL_GOODS SET
                    socialprice = v_socialprice,
                    moddate = sysdate
                WHERE modelno = v_modelno_new
                AND NVL(socialprice,0) <> v_socialprice;
                          
            
            END IF;
            */
        END IF;
        --======================================================================================
        
    END IF;

    IF v_modelno_new <= 0 AND (v_srvflag_new='0'  OR v_srvflag_new='L' OR v_srvflag_new='R') 
        AND (v_status_new='0' OR v_status_new='8' OR v_status_new='9') 
        AND (
            substr(v_ca_code_new,0,4) <> '1471' 
            AND substr(v_ca_code_new,0,4) <> '1472' 
            AND substr(v_ca_code_new,0,4) <> '1473' 
            AND substr(v_ca_code_new,0,2) <> '93' 
            AND substr(v_ca_code_new,0,2) <> '91' 
            AND substr(v_ca_code_new,0,2) <> '92' 
            AND substr(v_ca_code_new,0,2) <> '80' 
            AND v_ca_code_new <> ' ' 
            AND RTRIM(v_ca_code_new) IS NOT NUll 
        )
        --AND v_shop_code_new <> 6640 AND v_shop_code_new <> 6641
        --AND substr(v_ca_code_new,0,4) <> '8702'
        THEN
        /*
        IF (v_ca_code_new > '00' AND v_ca_code_new < '02') OR (v_ca_code_new >='08' AND v_ca_code_new <'13') OR (v_ca_code_new >='14' AND v_ca_code_new <'21')
            OR (v_ca_code_new >='22' AND v_ca_code_new <'80') OR (v_ca_code_new >='81' AND v_ca_code_new <'9804') OR v_ca_code_new >='9805' THEN
                INSERT INTO tbl_pricelist_search_add(PL_NO,MODELNO,MALLCNT,SEARCHFLAG,CATEGORY,GOODSNM,SHOP_CODE,SHOP_NAME,PRICE,FACTORY,URL,IMGURL,
                IMGURLFLAG,JOBCODE,JOBTYPE,POPULAR,U_DATE,STATUS,REGDATE)
                VALUES(v_pl_no_new,v_modelno_new,0,'1',v_ca_code_new,v_goodsnm_new,v_shop_code_new,' ',v_price_new,' ',v_url_new,v_imgurl_new,
                    v_imgurlflag_new,'1',v_jobtype_new,v_popular_new,v_u_date_new,'I',SYSTIMESTAMP);
        END IF;
        */
        /*=====================================================================*/
        /*다이퀘스트*/     
        
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
        
        --v_modelnm := UDF_GOODSNM_REMOVE(v_goodsnm_new) || ' ' || v_goodsfactory_new;
        v_modelnm := UDF_GOODSNM_REMOVE(v_goodsnm_new);        
        IF SUBSTR(v_category,0,4) = '9501' THEN
            IF length(v_modelnm) > 180 THEN
                v_modelnm := substr(v_modelnm,0,180) || ' 음반 앨범';
            ELSE
                v_modelnm := v_modelnm || ' 음반 앨범';
            END IF;
        END IF;
        
        --v_modelnm2 := replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(UDF_GOODSNM_REMOVE(v_modelnm),'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' ');
        --IF v_store_flag_new='1' THEN
        --    SELECT UDF_GOODSNM_REMOVE(v_goodsnm_new) || ' ' || v_goodsfactory_new INTO v_modelnm2 FROM DUAL;
        --ELSE
        --    v_modelnm2 := '';
        --END IF;
                
        v_shop_code := v_shop_code_new;
       
        --v_factory := v_goodsfactory_new;
        v_factory := '[추가]';
        v_goodsbrand := v_goodsbrand_new;
        --v_popular := v_popular_new;
        --v_popular := v_price_new * -1;
        
        IF NVL(v_popular_new,0) > 0 THEN
            v_popular := v_popular_new + 30000000;
        ELSE
            v_popular := (v_price_new * -1) + 30000000;
        END IF;
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
        v_status := 'I';
        
        IF substr(v_ca_code_new,0,2) = '93' THEN
            v_bookflag :='1';
            v_useflag :='0';
        ELSE
            v_bookflag :='0';
            v_useflag :='1';
        END IF;
        
       -- DELETE TBL_SEARCH_LOG WHERE SEARCH_KEY = v_search_key;
        
        
        --======================================================================================
        --UDF_SC_CHECK(v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER)
        v_sc_web := UDF_SC_CHECK('0', v_modelno, '1', v_shop_code);
        v_sc_mobile := UDF_SC_CHECK('0', v_modelno, '2', v_shop_code);
         --======================================================================================
        --IF v_instance_price_new > v_price_new THEN
        --    v_instance_price_new := v_price_new;
        --END IF;
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
        --v_ca_code_dept_new := SUBSTR(v_ca_code_dept_new,0,6);
        IF v_store_flag_new = '1' AND LENGTH(v_ca_code_dept_new) >= 4 THEN
            v_minprice4_new := v_price_new;
            --v_ca_code_dept_new := SUBSTR(v_ca_code_dept_new,0,6);
            v_ca_code_dept_new := v_ca_code_dept_new;
        ELSE
            v_minprice4_new := '0';
            v_ca_code_dept_new := '';
        END IF;
        /* 배송비 포함 최저가 nova23 2016.06.21*/        
        INSERT INTO TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
                    openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag,weight,sc_web,sc_mobile,minprice3,minprice2,store_flag,ca_dept_code,minprice4,brand,
                    goodsbrand,maxprice3)
        VALUES(v_search_key,v_modelno,v_pl_no_new,v_group_flag,v_category,v_category,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
                v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,v_status,0,v_bookflag,v_useflag,0,v_sc_web,v_sc_mobile,v_instance_price_new,
                /* 배송비 포함 최저가 nova23 2016.06.21*/
                v_store_flag_new,v_minprice2,v_ca_code_dept_new,v_price_new,v_brand,v_goodsbrand,v_instance_price_new);
        
        /*=============================================================================*/
        
    END IF;
END;

ALTER TRIGGER "DBENURI"."ASIS_TRG_SEN_INPRICELIST" DISABLE