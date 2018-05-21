/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_SEN_UPGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 15:09:40
 *        Modify: 2018-05-11 10:51:24
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_SEN_UPGOODS" AFTER UPDATE ON ASIS_TBL_GOODS
DECLARE
 	v_modelno_old 				tbl_goods.modelno%TYPE := 0;
 	v_modelno_new 				tbl_goods.modelno%TYPE := 0;
 	v_modelnm_old				tbl_goods.modelnm%TYPE := '';
 	v_modelnm_new				tbl_goods.modelnm%TYPE := '';
 	v_factory_old				tbl_goods.factory%TYPE := '';
 	v_factory_new				tbl_goods.factory%TYPE := '';
 	v_spec_old					tbl_goods.spec%TYPE := '';
 	v_spec_new					tbl_goods.spec%TYPE := '';
 	v_c_date_old				tbl_goods.c_date%TYPE := null;
 	v_c_date_new				tbl_goods.c_date%TYPE := null;
 	v_imgchk_old				tbl_goods.imgchk%TYPE := '';
 	v_imgchk_new				tbl_goods.imgchk%TYPE := '';
 	v_minprice_old				tbl_goods.minprice%TYPE := 0;
 	v_minprice_new				tbl_goods.minprice%TYPE := 0;
 	v_mallcnt_old				tbl_goods.mallcnt%TYPE := 0;
 	v_mallcnt_new				tbl_goods.mallcnt%TYPE := 0;
 	v_kbnum_old					tbl_goods.kb_num%TYPE := 0;
 	v_kbnum_new					tbl_goods.kb_num%TYPE := 0;
 	v_openexpectflag_old	    tbl_goods.openexpectflag%TYPE := '';
 	v_openexpectflag_new	    tbl_goods.openexpectflag%TYPE := '';
 	v_recommend_old				tbl_goods.recommend%TYPE := '';
 	v_recommend_new				tbl_goods.recommend%TYPE := '';
 	v_popular_old				tbl_goods.popular%TYPE := 0;
 	v_popular_new				tbl_goods.popular%TYPE := 0;
 	v_sum_popular_old			tbl_goods.sum_popular%TYPE := 0;
 	v_sum_popular_new			tbl_goods.sum_popular%TYPE := 0;    
 	v_sale_cnt_old				tbl_goods.sale_cnt%TYPE := 0;
 	v_sale_cnt_new				tbl_goods.sale_cnt%TYPE := 0;
 	v_gbcnt_old					tbl_goods.gbcnt%TYPE := 0;
 	v_gbcnt_new					tbl_goods.gbcnt%TYPE := 0;
 	v_ca_code_old				tbl_goods.ca_code%TYPE := '';
 	v_ca_code_new				tbl_goods.ca_code%TYPE := '';
 	v_modelno_group_old 	    tbl_goods.modelno_group%TYPE := 0;
 	v_modelno_group_new 	    tbl_goods.modelno_group%TYPE := 0;
 	v_keyword_old				tbl_goods.keyword%TYPE := '';
 	v_keyword_new				tbl_goods.keyword%TYPE := '';
 	v_keyword2_old				tbl_goods.keyword2%TYPE := '';
 	v_keyword2_new				tbl_goods.keyword2%TYPE := '';
 	v_brand_old					tbl_goods.brand%TYPE := '';
 	v_brand_new					tbl_goods.brand%TYPE := '';
 	v_jobcode_old				tbl_goods.jobcode%TYPE := '';
 	v_jobcode_new				tbl_goods.jobcode%TYPE := '';
 	v_cateflag_old				tbl_goods.cateflag%TYPE := '';
 	v_cateflag_new				tbl_goods.cateflag%TYPE := '';
 	v_constrain_old				tbl_goods.constrain%TYPE := '';
 	v_constrain_new				tbl_goods.constrain%TYPE := '';
 	v_moddate_old				tbl_goods.moddate%TYPE := null;
 	v_moddate_new				tbl_goods.moddate%TYPE := null;
	v_pl_no_old   				tbl_goods.p_pl_no%TYPE := 0;
	v_pl_no_new   				tbl_goods.p_pl_no%TYPE := 0;
	v_imgurl_new				tbl_goods.p_imgurl%TYPE := '';
	v_imgurlflag_new			tbl_goods.p_imgurlflag%TYPE := '';
 	v_rsiflag_old				tbl_goods.rsiflag%TYPE := '';
 	v_rsiflag_new				tbl_goods.rsiflag%TYPE := '';
 	v_refshop_old				tbl_goods.refshop%TYPE := '';
 	v_refshop_new				tbl_goods.refshop%TYPE := '';
 	v_boxmodelnm_old			tbl_goods.box_modelnm%TYPE := '';
 	v_boxmodelnm_new			tbl_goods.box_modelnm%TYPE := '';
    v_weight_old   				tbl_goods.weight%TYPE := 0;
	v_weight_new   				tbl_goods.weight%TYPE := 0;
    v_info_sum_point_old   		tbl_goods.info_sum_point%TYPE := 0;
	v_info_sum_point_new   		tbl_goods.info_sum_point%TYPE := 0;
    v_p_pl_no_new 	            tbl_goods.p_pl_no%TYPE := 0;
    v_p_imgurl_new				tbl_goods.p_imgurl%TYPE := '';
    v_p_imgurlflag_new			tbl_goods.p_imgurlflag%TYPE := '';
    v_condiname_new				tbl_goods.condiname%TYPE := '';
    v_condiname_old				tbl_goods.condiname%TYPE := '';
    v_flag_old			        tbl_goods.flag%TYPE := '';
 	v_flag_new			        tbl_goods.flag%TYPE := '';
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2_old				tbl_goods.minprice2%TYPE := 0;
 	v_minprice2_new				tbl_goods.minprice2%TYPE := 0;    
    v_minprice3_old				tbl_goods.minprice3%TYPE := 0;
 	v_minprice3_new				tbl_goods.minprice3%TYPE := 0;
    v_minprice4_old				tbl_goods.minprice4%TYPE := 0;
 	v_minprice4_new				tbl_goods.minprice4%TYPE := 0;
    
    v_bbs_num_old				tbl_goods.bbs_num%TYPE := 0;
 	v_bbs_num_new				tbl_goods.bbs_num%TYPE := 0;

    v_category_tmp		    VARCHAR2(2500) := '';
	v_brand1_tmp			VARCHAR2(1000) := '';
	v_brand2_tmp			VARCHAR2(1000) := '';
	v_specopt_tmp			VARCHAR2(4000) := '';
	v_status_tmp			CHAR(1) := '';
	v_refshop_tmp			CHAR(1) := '';
	v_kbcnt_tmp				NUMBER(6) := 0;
    
    /*====================================*/
    /* 다이퀘스트 */
    /*====================================*/
	v_search_key 	        VARCHAR2(13) := '';
    v_search_key_del        VARCHAR2(13) := '';
    v_modelno               NUMBER(10) := 0;
    v_group_flag            CHAR(1) := '';
    v_category              VARCHAR2(1000) := '';
    v_ca_code               VARCHAR2(12) := '';
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
    v_maxprice2             NUMBER(10) := 0;
    v_maxprice3             NUMBER(10) := 0;
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_minprice2             NUMBER(10) := 0;
    v_minprice3             NUMBER(10) := 0;
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
    v_weight                NUMBER(10,2) := 0;
    v_store_flag            CHAR(1) := '';
    v_bbs_num               NUMBER(8) := 0;
    v_exist_cnt             NUMBER(6) := 0;
    /*====================================*/
    
	i                       NUMBER(8) := 1;
    
    v_sc_web                CHAR(1) := '';
    v_sc_mobile             CHAR(1) := '';
    v_socialprice_new       NUMBER(10) := 0;
    

BEGIN
    --SET SERVEROUTPUT ON
	--DBMS_OUTPUT.ENABLE;
 	--DBMS_OUTPUT.PUT_LINE('trgSenUpGoods start ......' || pacGoodsDataLoop.g_index);
 	LOOP
    IF i <= pac_Goods_DataLoop.g_index THEN

    	v_modelno_old 				:=  pac_Goods_DataLoop.v_Modelno_old(i);
    	v_modelno_new 				:=  pac_Goods_DataLoop.v_Modelno_new(i);
    	v_modelnm_old				:=  pac_Goods_DataLoop.v_Modelnm_old(i);
    	v_modelnm_new				:=  pac_Goods_DataLoop.v_Modelnm_new(i);
    	v_factory_old				:=  pac_Goods_DataLoop.v_Factory_old(i);
    	v_factory_new				:=  pac_Goods_DataLoop.v_Factory_new(i);
    	v_spec_old					:=  NVL(pac_Goods_DataLoop.v_Spec_old(i),'');
    	v_spec_new					:=  NVL(pac_Goods_DataLoop.v_Spec_new(i),'');
    	v_c_date_old				:=  pac_Goods_DataLoop.v_Cdate_old(i);
    	v_c_date_new				:=  pac_Goods_DataLoop.v_Cdate_new(i);
    	v_imgchk_old				:=  pac_Goods_DataLoop.v_Imgchk_old(i);
    	v_imgchk_new				:=  pac_Goods_DataLoop.v_Imgchk_new(i);
    	v_minprice_old				:=  pac_Goods_DataLoop.v_Minprice_old(i);
    	v_minprice_new				:=  pac_Goods_DataLoop.v_Minprice_new(i);
    	v_mallcnt_old				:=  pac_Goods_DataLoop.v_Mallcnt_old(i);
    	v_mallcnt_new				:=  pac_Goods_DataLoop.v_Mallcnt_new(i);
    	v_kbnum_old					:=  pac_Goods_DataLoop.v_Kbnum_old(i);
    	v_kbnum_new					:=  pac_Goods_DataLoop.v_Kbnum_new(i);
    	v_openexpectflag_old	    :=  pac_Goods_DataLoop.v_Openexpectflag_old(i);
    	v_openexpectflag_new	    :=  pac_Goods_DataLoop.v_Openexpectflag_new(i);
    	v_recommend_old				:=  pac_Goods_DataLoop.v_Recommend_old(i);
    	v_recommend_new				:=  pac_Goods_DataLoop.v_Recommend_new(i);
    	v_popular_old				:=  NVL(pac_Goods_DataLoop.v_Popular_old(i),0);
    	v_popular_new				:=  NVL(pac_Goods_DataLoop.v_Popular_new(i),0);
    	v_sum_popular_old			:=  NVL(pac_Goods_DataLoop.v_Sum_popular_old(i),0);
    	v_sum_popular_new			:=  NVL(pac_Goods_DataLoop.v_Sum_popular_new(i),0);        
    	v_sale_cnt_old				:=  pac_Goods_DataLoop.v_Sale_cnt_old(i);
    	v_sale_cnt_new				:=  pac_Goods_DataLoop.v_Sale_cnt_new(i);
    	v_gbcnt_old					:=  pac_Goods_DataLoop.v_Gbcnt_old(i);
    	v_gbcnt_new					:=  pac_Goods_DataLoop.v_Gbcnt_new(i);
    	v_ca_code_old				:=  pac_Goods_DataLoop.v_Ca_code_old(i);
    	v_ca_code_new				:=  pac_Goods_DataLoop.v_Ca_code_new(i);
    	v_modelno_group_old 	    :=  NVL(pac_Goods_DataLoop.v_Modelnogroup_old(i),0);
    	v_modelno_group_new 	    :=  NVL(pac_Goods_DataLoop.v_Modelnogroup_new(i),0);
    	v_keyword_old				:=  pac_Goods_DataLoop.v_Keyword_old(i);
    	v_keyword_new				:=  pac_Goods_DataLoop.v_Keyword_new(i);
    	v_keyword2_old				:=  pac_Goods_DataLoop.v_Keyword2_old(i);
    	v_keyword2_new				:=  pac_Goods_DataLoop.v_Keyword2_new(i);
    	v_brand_old					:=  pac_Goods_DataLoop.v_Brand_old(i);
    	v_brand_new					:=  pac_Goods_DataLoop.v_Brand_new(i);
    	v_jobcode_old				:=  pac_Goods_DataLoop.v_Jobcode_old(i);
    	v_jobcode_new				:=  pac_Goods_DataLoop.v_Jobcode_new(i);
    	v_cateflag_old				:=  pac_Goods_DataLoop.v_Cateflag_old(i);
    	v_cateflag_new				:=  pac_Goods_DataLoop.v_Cateflag_new(i);
    	v_constrain_old				:=  pac_Goods_DataLoop.v_Constrain_old(i);
    	v_constrain_new				:=  pac_Goods_DataLoop.v_Constrain_new(i);
    	v_moddate_old				:=  NVL(pac_Goods_DataLoop.v_Moddate_old(i), sysdate);
    	v_moddate_new				:=  NVL(pac_Goods_DataLoop.v_Moddate_new(i), sysdate);
    	v_pl_no_old   				:=  NVL(pac_Goods_DataLoop.v_Pl_no_old(i), 0);
    	v_pl_no_new   				:=  NVL(pac_Goods_DataLoop.v_Pl_no_new(i), 0);
    	v_imgurl_new				:=  NVL(pac_Goods_DataLoop.v_Imgurl_new(i), '');
    	v_imgurlflag_new			:=  NVL(pac_Goods_DataLoop.v_Imgurlflag_new(i), '');
  		v_rsiflag_old				:=  NVL(pac_Goods_DataLoop.v_Rsiflag_old(i), '');
  		v_rsiflag_new				:=  NVL(pac_Goods_DataLoop.v_Rsiflag_new(i), '');
	  	v_refshop_old				:=  NVL(pac_Goods_DataLoop.v_Refshop_old(i), '');
	  	v_refshop_new				:=  NVL(pac_Goods_DataLoop.v_Refshop_new(i), '');
  		v_boxmodelnm_old			:=  pac_Goods_DataLoop.v_Boxmodelnm_old(i);
  		v_boxmodelnm_new			:=  pac_Goods_DataLoop.v_Boxmodelnm_new(i);
        v_weight_new			    :=  pac_Goods_DataLoop.v_Weight_new(i);
        v_weight_old			    :=  pac_Goods_DataLoop.v_Weight_old(i);
        v_info_sum_point_new	    :=  pac_Goods_DataLoop.v_Info_sum_point_new(i);
        v_info_sum_point_old	    :=  pac_Goods_DataLoop.v_Info_sum_point_old(i);
        v_p_pl_no_new	            :=  pac_Goods_DataLoop.v_P_pl_no_new(i);
        v_p_imgurl_new	            :=  pac_Goods_DataLoop.v_P_imgurl_new(i);
        v_p_imgurlflag_new	        :=  pac_Goods_DataLoop.v_P_imgurlflag_new(i);
        v_condiname_old	            :=  pac_Goods_DataLoop.v_Condiname_old(i);        
        v_condiname_new	            :=  pac_Goods_DataLoop.v_Condiname_new(i);        
        v_flag_old			        :=  pac_Goods_DataLoop.v_flag_old(i);
  		v_flag_new			        :=  pac_Goods_DataLoop.v_flag_new(i);
        /* 배송비 포함 최저가 nova23 2016.06.21*/
        v_minprice2_old				:=  pac_Goods_DataLoop.v_Minprice2_old(i);
    	v_minprice2_new				:=  pac_Goods_DataLoop.v_Minprice2_new(i);        
        v_minprice3_old				:=  pac_Goods_DataLoop.v_Minprice3_old(i);
    	v_minprice3_new				:=  pac_Goods_DataLoop.v_Minprice3_new(i);
        
        v_minprice4_old				:=  pac_Goods_DataLoop.v_Minprice4_old(i);
    	v_minprice4_new				:=  pac_Goods_DataLoop.v_Minprice4_new(i);
        
        v_bbs_num_old				:=  pac_Goods_DataLoop.v_BBs_Num_old(i);
    	v_bbs_num_new				:=  pac_Goods_DataLoop.v_Bbs_Num_new(i);

	    v_status_tmp :='';

	    /*트리거 처리내용 - 원분류의 데이타가 변경됬을때문 트리거 작동
	    1. 상품변경되면 TBL_GOODS_SEARCH_ADD, TBL_GOODS_SEARCH_DIRECT 로그테이블에 추가
	    2. 상품변경되면 TBL_PRICELIST_SEARCH_ADD, TBL_PRICELIST_SEARCH_DIRECT 로그테이블에 추가
	    3. TBL_PRICELIST의 JOBCODE보정
	    */

	    IF v_cateflag_new = '0' THEN
	       
            IF nvl(v_jobcode_old, '0') <> '0' AND (v_constrain_old = '1' OR v_constrain_old = '5') THEN --서비스_OLD
                
                IF nvl(v_jobcode_new, '0') <> '0' AND (v_constrain_new = '1' OR v_constrain_new = '5') THEN --서비스_NEW
                    IF v_cateflag_old = '1' OR (v_mallcnt_old=0 AND v_mallcnt_new>0) OR (v_mallcnt_old>0 AND v_mallcnt_new=0) OR (v_popular_old <> v_popular_new) 
                    OR (v_sum_popular_old <> v_sum_popular_new) OR (v_modelno_group_old <> v_modelno_group_new) OR (v_minprice3_old <> v_minprice3_new) OR (v_minprice4_old <> v_minprice4_new) 
                    OR (v_spec_old <> v_spec_new) OR (v_factory_old <> v_factory_new) OR (v_ca_code_old <> v_ca_code_new) OR (v_modelnm_old <> v_modelnm_new) OR (v_condiname_old <> v_condiname_new)
                    OR (v_bbs_num_old <> v_bbs_num_new)
                    THEN --MP에서 입력후 cateflag를 1->0 으로 업데이트
                        --v_status_tmp := 'U'; --추가
                        v_status_tmp := 'I'; --추가
                        --DBMS_OUTPUT.PUT_LINE('6');
                    END IF;
                ELSE
                    IF v_modelno_group_new > 0 THEN
                        v_status_tmp := 'I'; --삭제
                    ELSE
                        v_status_tmp := 'D'; --삭제
                    END IF;
                    --DBMS_OUTPUT.PUT_LINE('7');
                END IF;
                
                --v_status_tmp := 'I';
            ELSE --비서비스_OLD
                IF nvl(v_jobcode_new, '0') <> '0' AND (v_constrain_new = '1' OR v_constrain_new = '5') THEN --서비스_NEW
                   v_status_tmp := 'I';
                   --DBMS_OUTPUT.PUT_LINE('8');
                ELSE
                   v_status_tmp := 'Z'; --변동있으나 서비스중이 아닌상품이 바뀌었으므로 무시
                  --DBMS_OUTPUT.PUT_LINE('9');
                END IF;
            END IF;
            
        END IF;         
        
        --추가분류 데이타, 소셜상품
        IF (v_flag_old is null AND v_flag_new = '0') OR substr(v_ca_code_new,0,4)='8701' THEN
            v_status_tmp := 'I';
        END IF;
        
        IF v_constrain_new = '5' AND v_mallcnt_new=0 THEN
            v_status_tmp := 'D';
        END IF;
        
        
        /*=================================================================================================*/
        --추가 로그처리
        --DBMS_OUTPUT.PUT_LINE('=1=' || v_status_tmp);
        IF v_status_tmp='U' OR v_status_tmp='I' OR v_status_tmp='X' OR v_status_tmp='D' THEN
           
            /*==========================================*/
            /* 다이퀘스트
            /*==========================================*/
            IF v_status_tmp='I' OR v_status_tmp='D' THEN
                v_service_flag := '1';
                IF v_modelno_group_new > 0 THEN
                    v_search_key := 'G' || v_modelno_group_new;
                    v_group_flag := '1';
                    v_modelno_new := v_modelno_group_new;
                ELSE
                    v_search_key := 'G' || v_modelno_new;
                    v_group_flag := '0';
                END IF;
                
                v_modelno := v_modelno_new;
                
                --DBMS_OUTPUT.PUT_LINE(v_status_tmp || '--' || v_modelno_group_new);
                IF v_status_tmp='I' OR v_status_tmp='D' OR v_modelno_group_new > 0 THEN --입력이거나 그룹모델일 경우만
                
                    BEGIN                    
                    
                    select	
                    NVL(modelno_group,MAX(modelno)) modelno,	
                    NVL(dbenuri.UDF_RTN_GET_CATEGORY3(NVL(modelno_group,MAX(modelno))), ' ') AS category,	
                    MIN(ca_code) ca_code,	
                    
                    --CASE WHEN INSTR(MAX(factory),MAX(brand)) > 0  THEN MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) ELSE MAX(replace(replace(replace(modelnm,condiname,''),'[]',''),'_',' ')) || ' ' ||  MAX(brand) END AS  modelnm,  
                    --UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname)) modelnm,                    
                    MAX(replace(replace(modelnm,replace(condiname,'.',''),''),'[]','')) modelnm,  
                    --MAX(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(modelnm,condiname,''),'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' '),',',' ')) modelnm2, 
                    UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname)) modelnm2,
                    --MAX(modelnm) modelnm2,                    
                    --UDF_MODEL_FACTORY(MAX(factory),MAX(brand), MAX(modelnm || '~!@' || condiname)) modelnm2,
                    --CASE WHEN modelno_group='1' AND store_flag='1' THEN RTRIM(modelnm2 || ' ' || UDF_MODEL_GROUP_DEPT_CONDINAME(modelno)) ELSE modelnm2 END AS modelnm2,

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
                    --CASE WHEN MAX(ca_lcode)='14' THEN '' ELSE replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' ') END AS spec,
                    replace(replace(replace(replace(MAX(spec),'/',' '),',',' '),'(',' '),')',' ') spec,
                    --NVL(MIN(openexpectflag),'0') openexpectflag,                        
                    case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end as openexpectflag, 
                    --CASE WHEN NVL(modelno_group,0) = 0 THEN MIN(minprice) || '' ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(modelno_group,0)) END AS condiname,	
                    CASE WHEN NVL(MAX(modelno_group),0) = 0 THEN '' ELSE DBENURI.UDF_MODEL_GROUP_CONDINAME(NVL(MAX(modelno_group),0)) END AS condiname, 	
                    CASE WHEN NVL(modelno_group,0) = 0 THEN NVL(MAX(KEYWORD), '') || ' ' || NVL(MAX(BRAND),'') ELSE DBENURI.UDF_MODEL_GROUP_KEYWORD(NVL(modelno_group,0)) || ' ' || NVL(MAX(BRAND),'') END AS KEYWORD,	
                    --'' keyword2,	
                    
                    --UDF_CATEGORY_KEYWORD_POPULAR(MIN(ca_code)) AS keyword2,
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
                    
                    --MIN(NVL(minprice3,0)) minprice3,
                    --MIN(NVL(minprice4,0)) minprice4,
                    CASE WHEN MAX(NVL(minprice4,0)) > 0 then '1' else '0' end as store_flag ,
                    --UDF_RTN_GET_DEPT_CA_CODE(MIN(modelno)) v_ca_dept_code,
                    UDF_RTN_GET_DEPT_CA_CODE(NVL(modelno_group,MAX(modelno))) ca_dept_code,
                    
                    
                    CASE WHEN MAX(SUBSTR(ca_code,0,2)) = '93' then '1' else '0' end as bookflag ,
                    --CASE WHEN MAX(mallcnt) > 0 and   NVL(MIN(openexpectflag),'0') = '0' and MAX(ca_code) <> '93010000' then '1' else '0' end as useflag
                    CASE WHEN  MAX(mallcnt) > 0 and   (case when NVL(MIN(openexpectflag),'0')  = '1' or  min(c_date) > sysdate  then '1' else '0' end) = '0' and MAX(SUBSTR(ca_code,0,2)) <> '93' then '1' else '0' end as useflag,
                    --NVL(MAX(weight),0)*100 weight
                    --CASE WHEN substr(MAX(ca_code),0,4)='0501' THEN NVL(MAX(weight),0)*100 ELSE NVL(MAX(weight),999999) END weight
                    SUBSTR(NVL(MAX(brand),''),0,50) brand,
                    CASE WHEN substr(MAX(ca_code),0,4)='0501' then NVL(MAX(weight)*100,0) else NVL(MAX(weight)*100,999999) end as weight,
                    UDF_BBS_NUM_SUM(NVL(modelno_group,MAX(modelno))) bbs_num,
                    'I'
                    
                    INTO
                    
                    v_modelno,
                    v_category,
                    v_ca_code,
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
                    v_weight,
                    v_bbs_num,
                    v_status_tmp
                    
                    FROM dbenuri.tbl_goods	
                    --WHERE (modelno_group = v_modelno_new OR modelno = v_modelno_new)
                    --WHERE ((v_modelno_group_new>0 and modelno_group = v_modelno_new) OR (v_modelno_group_new=0 AND modelno = v_modelno_new))
                    WHERE ((v_modelno_group_new>0 and modelno_group = v_modelno_group_new) OR (v_modelno_group_new=0 AND modelno = v_modelno_new))
                    AND jobcode > '0'	
                    AND constrain IN ('1','5')
                    AND cateflag = '0'	
                    --AND ((NVL(modelno_group,0) = 0 AND mallcnt >=0) OR (NVL(modelno_group,0) > 0 AND mallcnt > 0))                            
                    GROUP BY modelno_group;
                    
                    EXCEPTION WHEN OTHERS THEN
                        v_modelno := v_modelno_new;
                        v_status_tmp := 'D';
                    END;
                    
                    --업체 상품명 keyword1  필드에 합치기
                    --SELECT substr(v_keyword1 || ' ' || UDF_SHOP_GOODSNM(v_modelno_new),0,1000) INTO v_keyword1 FROM dual;
                                    
                END IF;
                
               -- DELETE TBL_SEARCH_LOG WHERE SEARCH_KEY = v_search_key;

                v_keyword1 := replace(replace(v_keyword1,'_',' '),'%',' ');
                
                --====================================================================================
                --소셜상품 상품명 검색에 추가
                IF substr(v_ca_code_new,0,4)='8701' THEN
                    v_keyword1 := v_keyword1 || ' ' || UDF_SOCIAL_GOODSNM(v_group_flag,v_modelno);                
                END IF;
                v_keyword1 := REPLACE(v_keyword1,'[',' ');
                v_keyword1 := REPLACE(v_keyword1,']',' ');
                v_keyword1 := REPLACE(v_keyword1,'_',' ');
                v_keyword1 := REPLACE(v_keyword1,'(',' ');
                v_keyword1 := REPLACE(v_keyword1,')',' ');
                v_keyword1 := RTRIM(LTRIM(v_keyword1));
                --====================================================================================
                --v_modelno := v_modelno_new;
                
                --======================================================================================
                --UDF_SC_CHECK(v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER)
                v_sc_web := UDF_SC_CHECK(v_group_flag, v_modelno, '1', 0);
                v_sc_mobile := UDF_SC_CHECK(v_group_flag, v_modelno, '2', 0);
                --======================================================================================    
                IF (v_minprice3 > 0 AND v_minprice3 > v_minprice) OR v_minprice3 = 0 THEN
                    v_minprice3 := v_minprice;
                END IF;
                
                IF v_maxprice3 = 0 THEN
                    v_maxprice3 := v_minprice3;
                END IF;
                
                --======================================================================================    
                --IF v_modelno_group_new > 0 AND v_minprice4 > 0 THEN
                --    SELECT UDF_MODEL_GROUP_DEPT_CONDINAME(v_modelno_group_new) INTO v_detp_condiname FROM DUAL;
                --    v_modelnm2 :=  RTRIM(v_modelnm2 || ' ' || v_detp_condiname);
                --END IF;
                
                --모델 그룹번호가 변경된 경우 전에 모델그룹번호 삭제
                
                IF v_modelno_group_old <> v_modelno_group_new AND v_modelno_group_old > 0 THEN
                    
                    select	NVL(COUNT(*),0) INTO v_exist_cnt
                    FROM tbl_goods	
                    WHERE (modelno_group = v_modelno_group_old)
                    AND jobcode > '0'	
                    AND constrain = '1'	
                    AND cateflag = '0';
                    
                    IF v_exist_cnt = 0 THEN                
                        v_search_key_del := 'G' || v_modelno_group_old;                        
                        INSERT INTO /*+ append NOLOGGING */ TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
                            openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag,weight,sc_web,sc_mobile,brand,minprice4,ca_dept_code,store_flag,
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            minprice3,minprice2,maxprice3,bbs_num)
                        VALUES(v_search_key_del,v_modelno,0,v_group_flag,v_category,v_ca_code_old,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
                            v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,'D',v_sale_cnt,v_bookflag,v_useflag,v_weight,v_sc_web,
                            /* 배송비 포함 최저가 nova23 2016.06.21*/
                            v_sc_mobile,v_brand,v_minprice4,v_ca_dept_code,v_store_flag,v_minprice3,v_minprice2,v_maxprice3,v_bbs_num);
                    END IF;
                    
                END IF;
                --============================================================================================================================================================================================
                INSERT INTO /*+ append NOLOGGING */ TBL_SEARCH_LOG(search_key,modelno,pl_no,group_flag,category,ca_code,modelnm,modelnm2,shop_code,factory,popular,popular2,minprice,maxprice,minprices,c_date,mallcnt,spec,
                    openexpectflag,condiname,keyword1,keyword2,brandcode1,brandcode2,specopt,service_flag,status,sale_cnt,bookflag,useflag,weight,sc_web,sc_mobile,brand,minprice4,ca_dept_code,store_flag,minprice3,minprice2,
                    goodsbrand,maxprice3,bbs_num)
                VALUES(v_search_key,v_modelno,0,v_group_flag,v_category,v_ca_code,v_modelnm,v_modelnm2,v_shop_code,v_factory,v_popular,v_popular2,v_minprice,v_maxprice,v_minprices,
                    v_c_date,v_mallcnt,v_spec,v_openexpectflag,v_condiname,v_keyword1,v_keyword2,v_brandcode1,v_brandcode2,v_specopt,v_service_flag,v_status_tmp,v_sale_cnt,v_bookflag,v_useflag,v_weight,v_sc_web,
                    /* 배송비 포함 최저가 nova23 2016.06.21*/
                    v_sc_mobile,v_brand,v_minprice4,v_ca_dept_code,v_store_flag,v_minprice3,v_minprice2,v_factory,v_maxprice3,v_bbs_num);
            END IF;
            /*===================================================================================================================*/
        END IF;

    	v_category_tmp	    := '';
    	v_brand1_tmp		:= '';
    	v_brand2_tmp		:= '';
    	v_specopt_tmp		:= '';
    	v_status_tmp		:= '';

     	i := i + 1;
  	ELSE
   		EXIT;
  	END IF;
	END LOOP;

 	pac_Goods_DataLoop.g_index := 0;
 	i := 1;
END;

ALTER TRIGGER "DBENURI"."ASIS_TRG_SEN_UPGOODS" DISABLE