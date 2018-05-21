/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_SEN_INGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 15:09:40
 *        Modify: 2018-05-11 10:51:18
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_SEN_INGOODS" AFTER INSERT ON ASIS_TBL_GOODS
DECLARE
 	v_modelno_new 				tbl_goods.modelno%TYPE := 0;
 	v_modelnm_new				tbl_goods.modelnm%TYPE := '';
 	v_factory_new				tbl_goods.factory%TYPE := '';
 	v_spec_new					tbl_goods.spec%TYPE := '';
 	v_c_date_new				tbl_goods.c_date%TYPE := null;
 	v_imgchk_new				tbl_goods.imgchk%TYPE := '';
 	v_minprice_new				tbl_goods.minprice%TYPE := 0;
 	v_mallcnt_new				tbl_goods.mallcnt%TYPE := 0;
 	v_kbnum_new					tbl_goods.kb_num%TYPE := 0;
 	v_openexpectflag_new	    tbl_goods.openexpectflag%TYPE := '';
 	v_recommend_new				tbl_goods.recommend%TYPE := '';
 	v_popular_new				tbl_goods.popular%TYPE := 0;
 	v_sale_cnt_new				tbl_goods.sale_cnt%TYPE := 0;
 	v_gbcnt_new					tbl_goods.gbcnt%TYPE := 0;
 	v_ca_code_new				tbl_goods.ca_code%TYPE := '';
 	v_modelno_group_new 	    tbl_goods.modelno_group%TYPE := 0;
 	v_keyword_new				tbl_goods.keyword%TYPE := '';
 	v_keyword2_new				tbl_goods.keyword2%TYPE := '';
 	v_brand_new					tbl_goods.brand%TYPE := '';
 	v_jobcode_new				tbl_goods.jobcode%TYPE := '';
 	v_cateflag_new				tbl_goods.cateflag%TYPE := '';
 	v_constrain_new				tbl_goods.constrain%TYPE := '';
 	v_rsiflag_new				tbl_goods.rsiflag%TYPE := '';
 	v_refshop_new				tbl_goods.refshop%TYPE := '';
 	v_boxmodelnm_new			tbl_goods.box_modelnm%TYPE := '';
    v_weight_new 	            tbl_goods.weight%TYPE := 0;
    v_info_sum_point_new 	    tbl_goods.info_sum_point%TYPE := 0;
    v_p_pl_no_new 	            tbl_goods.p_pl_no%TYPE := 0;
    v_p_imgurl_new				tbl_goods.p_imgurl%TYPE := '';
    v_p_imgurlflag_new			tbl_goods.p_imgurlflag%TYPE := '';
    v_condiname_new				tbl_goods.condiname%TYPE := '';
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2_new				tbl_goods.minprice2%TYPE := 0;
    v_minprice3_new				tbl_goods.minprice3%TYPE := 0;
    v_minprice4_new				tbl_goods.minprice4%TYPE := 0;

	v_category_tmp		    VARCHAR2(2500) := '';
	v_brand1_tmp			VARCHAR2(1000) := '';
	v_brand2_tmp			VARCHAR2(1000) := '';
	v_specopt_tmp			VARCHAR2(4000) := '';
	v_status_tmp			CHAR(1) := '';
	v_refshop_tmp			CHAR(1) := '';
	v_kbcnt_tmp				NUMBER(6) := 0;
    v_weight_tmp			NUMBER(8,2) := 0;
    v_info_sum_point_tmp	NUMBER(3,1) := 0;
    v_condiname_tmp			VARCHAR2(50) := '';
    v_socialprice           NUMBER(10) := 0;
	i NUMBER(8) := 1;
    
    /*====================================*/
    /* 다이퀘스트 */
    /*====================================*/
	v_search_key 	        VARCHAR2(13) := '';
    v_modelno               NUMBER(10) := 0;
    v_group_flag            CHAR(1) := '';
    v_category              VARCHAR2(100) := '';
    v_ca_dept_code          VARCHAR2(10) := '';
    v_modelnm               VARCHAR2(400) := '';
    v_modelnm2              VARCHAR2(400) := '';
    v_shop_code             NUMBER(8) := 0;
    v_shop_name             VARCHAR2(60) := '';    
    v_factory               VARCHAR2(100) := '';
    v_popular               NUMBER(10) := 0;
    v_popular2              NUMBER(10) := 0;
    v_minprice              NUMBER(10) := 0;
    v_maxprice              NUMBER(10) := 0;
    v_maxprice3             NUMBER(10) := 0;
    v_minprice3             NUMBER(10) := 0;
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2             NUMBER(10) := 0;
    v_minprice4             NUMBER(10) := 0;
    v_minprices             VARCHAR2(2000) := '';
    v_c_date                VARCHAR2(16) := '';
    v_mallcnt               NUMBER(6) := 0;
    v_spec                  VARCHAR2(4000) := '';
    v_openexpectflag        CHAR(1) := '';
    v_condiname             VARCHAR2(2000) := '';
    v_detp_condiname        VARCHAR2(2000) := '';
    v_keyword1              VARCHAR2(2600) := '';
    v_keyword2              VARCHAR2(2600) := '';
    v_brandcode1            VARCHAR2(1000) := '';
    v_brandcode2            VARCHAR2(1000) := '';
    v_specopt               VARCHAR2(200) := '';
    v_service_flag          CHAR(1) := '';
    v_status		        CHAR(1) := '';
    v_sale_cnt              NUMBER(8) := 0;
    v_bookflag              CHAR(1) := '';
    v_useflag               CHAR(1) := '';
    v_brand                 VARCHAR2(100) := '';
    v_weight                NUMBER(8,2) := 0;
    v_store_flag            CHAR(1) := '';
    
    v_exist_cnt             NUMBER(6) := 0;
    /*====================================*/
    
    v_sc_web                CHAR(1) := '';
    v_sc_mobile             CHAR(1) := '';

BEGIN
--DBMS_OUTPUT.ENABLE;

 LOOP
  IF i <= pac_Goods_DataLoop.g_index THEN

  	v_modelno_new 				:=  pac_Goods_DataLoop.v_Modelno_new(i);
  	v_modelnm_new				:=  pac_Goods_DataLoop.v_Modelnm_new(i);
  	v_factory_new				:=  pac_Goods_DataLoop.v_Factory_new(i);
  	v_spec_new					:=  pac_Goods_DataLoop.v_Spec_new(i);
  	v_c_date_new				:=  pac_Goods_DataLoop.v_Cdate_new(i);
  	v_imgchk_new				:=  pac_Goods_DataLoop.v_Imgchk_new(i);
  	v_minprice_new				:=  pac_Goods_DataLoop.v_Minprice_new(i);
  	v_mallcnt_new				:=  NVL(pac_Goods_DataLoop.v_Mallcnt_new(i),0);
  	v_kbnum_new					:=  pac_Goods_DataLoop.v_Kbnum_new(i);
  	v_openexpectflag_new	    :=  pac_Goods_DataLoop.v_Openexpectflag_new(i);
  	v_recommend_new				:=  pac_Goods_DataLoop.v_Recommend_new(i);
  	v_popular_new				:=  pac_Goods_DataLoop.v_Popular_new(i);
  	v_sale_cnt_new				:=  pac_Goods_DataLoop.v_Sale_cnt_new(i);
  	v_gbcnt_new					:=  pac_Goods_DataLoop.v_Gbcnt_new(i);
  	v_ca_code_new				:=  pac_Goods_DataLoop.v_Ca_code_new(i);
  	v_modelno_group_new 	    :=  NVL(pac_Goods_DataLoop.v_Modelnogroup_new(i),0);
  	v_keyword_new				:=  pac_Goods_DataLoop.v_Keyword_new(i);
  	v_keyword2_new				:=  pac_Goods_DataLoop.v_Keyword2_new(i);
  	v_brand_new					:=  pac_Goods_DataLoop.v_Brand_new(i);
  	v_jobcode_new				:=  NVL(pac_Goods_DataLoop.v_Jobcode_new(i),'0');
  	v_cateflag_new				:=  pac_Goods_DataLoop.v_Cateflag_new(i);
  	v_constrain_new				:=  NVL(pac_Goods_DataLoop.v_Constrain_new(i),'1');
  	v_rsiflag_new				:=  pac_Goods_DataLoop.v_Rsiflag_new(i);
  	v_refshop_new				:=  pac_Goods_DataLoop.v_Refshop_new(i);
  	v_boxmodelnm_new			:=  pac_Goods_DataLoop.v_Boxmodelnm_new(i);
    v_weight_new			    :=  pac_Goods_DataLoop.v_Weight_new(i);
    v_info_sum_point_new	    :=  pac_Goods_DataLoop.v_Info_sum_point_new(i);
    v_p_pl_no_new	            :=  pac_Goods_DataLoop.v_P_pl_no_new(i);
    v_p_imgurl_new	            :=  pac_Goods_DataLoop.v_P_imgurl_new(i);
    v_p_imgurlflag_new	        :=  pac_Goods_DataLoop.v_P_imgurlflag_new(i);
    v_condiname_new	            :=  pac_Goods_DataLoop.v_Condiname_new(i);
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2_new				:=  pac_Goods_DataLoop.v_Minprice2_new(i);    
    v_minprice3_new				:=  pac_Goods_DataLoop.v_Minprice3_new(i);
    v_minprice4_new				:=  pac_Goods_DataLoop.v_Minprice4_new(i);

    IF v_cateflag_new = '0' THEN        
        /*==========================================*/
        /* 다이퀘스트
        /*==========================================*/    
        IF v_modelno_new>0 AND v_jobcode_new>'0' AND v_constrain_new='5' AND v_mallcnt_new>0 AND length(NVL(v_modelnm_new,' ')) > 1 THEN
            v_service_flag := '1';
            IF v_modelno_group_new > 0 THEN
                v_search_key := 'G' || v_modelno_group_new;
                v_group_flag := '1';
                v_modelno_new := v_modelno_group_new;
            ELSE
                v_search_key := 'G' || v_modelno_new;                
                v_group_flag := '0';
            END IF;
            
            BEGIN
                            
                select	
                    NVL(modelno_group,MAX(modelno)) modelno,	
                    NVL(dbenuri.UDF_RTN_GET_CATEGORY3(NVL(modelno_group,MAX(modelno))), ' ') AS category,
                    
                    --CASE WHEN INSTR(MAX(factory),MAX(brand)) > 0  THEN MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) ELSE MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) || ' ' ||  MAX(brand) END AS  modelnm,  
                    --MAX(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(modelnm,condiname,''),'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' '),',',' ')) modelnm2, 
                    --MAX(modelnm) modelnm,
                    --UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname)) modelnm,
                    MAX(replace(replace(modelnm,replace(condiname,'.',''),''),'[]','')) modelnm,  
                    UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname)) modelnm2,
                    --MAX(modelnm) modelnm2,

                    0 shop_code,	
                    '' shop_name,	
                    RTRIM(LTRIM(MAX(factory))) factory,	
                    CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END AS popular,
                    CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(popular),0) ELSE NVL(MAX(sum_popular),0) END AS popular2,
                    --MIN(minprice) minprice,	
                    CASE WHEN NVL(MAX(modelno_group),0) = 0 OR NVL(MIN(minprice),0) > 0 THEN MIN(minprice) ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE2(NVL(MAX(modelno_group),0)) END AS minprice,
                    MAX(minprice) maxprice,	
                    CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' ELSE DBENURI.UDF_MODEL_GROUP_MINPRICE(NVL(modelno_group,0)) END AS minprices,	
                    TO_CHAR(MIN(C_DATE),'YYYYMMDDHH24MISS') AS C_DATE,	
                    MAX(mallcnt) mallcnt,	
                    --CASE WHEN MAX(ca_lcode)='14' THEN '' ELSE replace(replace(MAX(spec),'/',' '),',',' ') END AS spec,
                    replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' ') spec,
                    --NVL(MIN(openexpectflag),'0') openexpectflag,                        
                    case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end as openexpectflag, 
                    --CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(modelno_group,0)) END AS condiname,	
                    CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN '' ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0)) END AS condiname, 	
                    CASE WHEN NVL(modelno_group,0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') ELSE DBENURI.UDF_MODEL_GROUP_KEYWORD(NVL(modelno_group,0)) || ' ' || NVL(MAX(BRAND),'') END AS KEYWORD,	
                    
                    --MAX(keyword2) keyword2,	
                    UDF_CATEGORY_KEYWORD_POPULAR2(MAX(modelno)) AS keyword2,
                    
                    NVL(dbenuri.UDF_RTN_GET_BRAND1(NVL(modelno_group,MAX(modelno))), ' ') AS BRANDCODE1,	
                    NVL(dbenuri.UDF_RTN_GET_BRAND2(NVL(modelno_group,MAX(modelno))), ' ') AS BRANDCODE2,	
                    dbenuri.UDF_RTN_GET_SPECOPT(NVL(modelno_group,MAX(modelno))) AS SPECOPT,
                    --'' AS SPECOPT,
                    CASE WHEN MAX(modelno_group) IS NULL THEN NVL(MAX(sale_cnt),0) ELSE NVL(MAX(sum_sale_cnt),0) END AS sale_cnt,
                    
                    CASE WHEN NVL(modelno_group,0) > 0 AND MAX(NVL(minprice3,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(modelno_group,3) ELSE MIN(minprice3) END AS minprice3,
                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                    CASE WHEN NVL(modelno_group,0) > 0 AND MAX(NVL(minprice2,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(modelno_group,2) ELSE MIN(minprice2) END AS minprice2,
                    MAX(minprice3) maxprice3,
                    CASE WHEN NVL(modelno_group,0) > 0 AND MAX(NVL(minprice4,0)) > 0 THEN UDF_MODEL_GROUP_MINPRICE_ETC(modelno_group,4) ELSE MIN(minprice4) END AS minprice4,
                    CASE WHEN MAX(NVL(minprice4,0)) > 0 then '1' else '0' end as store_flag ,
                    --UDF_RTN_GET_DEPT_CA_CODE(MIN(modelno)) v_ca_dept_code,
                    UDF_RTN_GET_DEPT_CA_CODE(NVL(modelno_group,MAX(modelno))) ca_dept_code,
                    
                    CASE WHEN MAX(ca_code) = '93010000' then '1' else '0' end as bookflag ,
                    --CASE WHEN MAX(mallcnt) > 0 and   NVL(MIN(openexpectflag),'0') = '0' and MAX(ca_code) <> '93010000' then '1' else '0' end as useflag
                    CASE WHEN  MAX(mallcnt) > 0 and   (case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end) = '0' and MAX(ca_code) <> '93010000' then '1' else '0' end as useflag,
                    --NVL(MAX(weight),0)*100 weight
                    --CASE WHEN substr(MAX(ca_code),0,4)='0501' THEN NVL(MAX(weight),0)*100 ELSE NVL(MAX(weight),999999) END weight
                    --NVL(MAX(weight)*100,999999) weight
                    SUBSTR(NVL(MAX(brand),''),0,50) brand,
                    CASE WHEN substr(MAX(ca_code),0,4)='0501' then NVL(MAX(weight)*100,0) else NVL(MAX(weight)*100,999999) end as weight
                    
                    INTO
                    
                    v_modelno,
                    v_category,
                    v_modelnm,
                    v_modelnm2,
                    v_shop_code,
                    v_shop_name,
                    v_factory,                        
                    v_popular,
                    v_popular2,
                    v_minprice,
                    v_maxprice,
                    v_minprices,
                    v_c_date,
                    v_mallcnt,
                    v_spec,
                    v_openexpectflag,
                    v_condiname,
                    v_keyword1,
                    v_keyword2,
                    v_brandcode1,
                    v_brandcode2,
                    v_specopt,
                    v_sale_cnt,
                    v_minprice3,
                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                    v_minprice2,
                    v_maxprice3,
                    v_minprice4,
                    v_store_flag,
                    v_ca_dept_code,
                    v_bookflag,
                    v_useflag,
                    v_brand,
                    v_weight
                    
                FROM dbenuri.tbl_goods	
                WHERE (modelno_group = v_modelno_new OR modelno = v_modelno_new)
                AND jobcode > '0'	
                AND constrain in ('1','5')	
                AND cateflag = '0'
                --AND ((NVL(modelno_group,0) = 0 AND mallcnt >=0) OR (NVL(modelno_group,0) > 0 AND mallcnt > 0))                            
                GROUP BY modelno_group;
                    
            EXCEPTION WHEN OTHERS THEN
                v_modelno := v_modelno_new;
                v_status_tmp := 'D';
            END;            
            
            --DBMS_OUTPUT.PUT_LINE(v_search_key || '==' || v_modelno || '==' || v_modelnm || '==' || v_modelnm2);
            
            --====================================================================================
            --소셜상품 상품명 검색에 추가
            --IF substr(v_ca_code_new,0,4)='8701' THEN
            --    v_keyword1 := v_keyword1 || ' ' || UDF_SOCIAL_GOODSNM(v_group_flag,v_modelno);                
            --END IF;
            --====================================================================================
            
            --======================================================================================
            --UDF_SC_CHECK(v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER)
            v_sc_web := UDF_SC_CHECK(v_group_flag, v_modelno, '1', 0);
            v_sc_mobile := UDF_SC_CHECK(v_group_flag, v_modelno, '2', 0);
            --======================================================================================    
            IF (v_minprice3 > 0 AND v_minprice3 > v_minprice) OR v_minprice3 = 0 THEN
                v_minprice3 := v_minprice;
            END IF;
            /* 배송비 포함 최저가 nova23 2016.06.21*/
            IF (v_minprice2 > 0 AND v_minprice2 > v_minprice) OR v_minprice2 = 0 THEN
                v_minprice2 := v_minprice;
            END IF;            
            IF v_maxprice3 = 0 THEN
                v_maxprice3 := v_minprice3;
            END IF;
            --======================================================================================    
            IF v_modelno_group_new > 0 AND v_minprice4 > 0 THEN
                SELECT UDF_MODEL_GROUP_DEPT_CONDINAME(v_modelno_group_new) INTO v_detp_condiname FROM DUAL;
                v_modelnm2 :=  RTRIM(v_modelnm2 || ' ' || v_detp_condiname);
            END IF;
                
            INSERT INTO TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
                /* 배송비 포함 최저가 nova23 2016.06.21*/
                openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag,weight,sc_web,sc_mobile,brand,minprice4,ca_dept_code,minprice3,minprice2,
                goodsbrand,maxprice3)
            VALUES(v_search_key,v_modelno,0,v_group_flag,v_category,v_ca_code_new,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
                v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,'I',v_sale_cnt,v_bookflag,v_useflag,v_weight,v_sc_web,
                /* 배송비 포함 최저가 nova23 2016.06.21*/
                v_sc_mobile,v_brand,v_minprice4,v_ca_dept_code,v_minprice3,v_minprice2,v_factory,v_maxprice3);            
            
        END IF; 
        --=======================================================================================================================================
    END IF;
    
    --Social    
    /*
    IF v_cateflag_new = '1' AND substr(v_ca_code_new,0,4) = '8701' THEN    
    
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
    --==========================================================================
    
  	v_category_tmp	    := '';
  	v_brand1_tmp		:= '';
  	v_brand2_tmp		:= '';
  	v_specopt_tmp		:= '';
  	v_kbcnt_tmp			:= 0;

   	i := i + 1;
    
  ELSE
    EXIT;
  END IF;

 END LOOP;

 pac_Goods_DataLoop.g_index := 0;
 i := 1;
 
END;

ALTER TRIGGER "DBENURI"."ASIS_TRG_SEN_INGOODS" DISABLE