/* *************************************************************************
 * NAME : ASISTEST.PAC_GOODS_DATALOOP
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:38
 *        Modify: 2018-05-04 18:33:38
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."PAC_GOODS_DATALOOP" AS
	TYPE g_modelno_type is table of TBL_GOODS.MODELNO%TYPE
	index by binary_integer;
	TYPE g_modelnm_type is table of TBL_GOODS.MODELNM%TYPE
	index by binary_integer;
	TYPE g_category_type is table of TBL_GOODS_SEARCH_ADD.CATEGORY%TYPE
	index by binary_integer;
	TYPE g_factory_type is table of TBL_GOODS.FACTORY%TYPE
	index by binary_integer;
	TYPE g_spec_type is table of TBL_GOODS.SPEC%TYPE
	index by binary_integer;
	TYPE g_c_date_type is table of TBL_GOODS.C_DATE%TYPE
	index by binary_integer;
	TYPE g_imgchk_type is table of TBL_GOODS.IMGCHK%TYPE
	index by binary_integer;
	TYPE g_minprice_type is table of TBL_GOODS.MINPRICE%TYPE
	index by binary_integer;
	TYPE g_mallcnt_type is table of TBL_GOODS.MALLCNT%TYPE
	index by binary_integer;
	TYPE g_kb_num_type is table of TBL_GOODS.KB_NUM%TYPE
	index by binary_integer;
	TYPE g_openexpectflag_type is table of TBL_GOODS.OPENEXPECTFLAG%TYPE
	index by binary_integer;
	TYPE g_recommend_type is table of TBL_GOODS.RECOMMEND%TYPE
	index by binary_integer;
	TYPE g_popular_type is table of TBL_GOODS.POPULAR%TYPE
	index by binary_integer;
    TYPE g_sum_popular_type is table of TBL_GOODS.SUM_POPULAR%TYPE
	index by binary_integer;
	TYPE g_sale_cnt_type is table of TBL_GOODS.SALE_CNT%TYPE
	index by binary_integer;
	TYPE g_gbcnt_type is table of TBL_GOODS.GBCNT%TYPE
	index by binary_integer;
	TYPE g_ca_code_type is table of TBL_GOODS.CA_CODE%TYPE
	index by binary_integer;
	TYPE g_brandcode1_type is table of TBL_GOODS_SEARCH_ADD.BRANDCODE1%TYPE
	index by binary_integer;
	TYPE g_brandcode2_type is table of TBL_GOODS_SEARCH_ADD.BRANDCODE2%TYPE
	index by binary_integer;
	TYPE g_modelno_group_type is table of TBL_GOODS.MODELNO_GROUP%TYPE
	index by binary_integer;
	TYPE g_keyword_type is table of TBL_GOODS.KEYWORD%TYPE
	index by binary_integer;
	TYPE g_keyword2_type is table of TBL_GOODS.KEYWORD2%TYPE
	index by binary_integer;
	TYPE g_brand_type is table of TBL_GOODS.BRAND%TYPE
	index by binary_integer;
	TYPE g_specopt_type is table of TBL_GOODS_SEARCH_ADD.SPECOPT%TYPE
	index by binary_integer;
	TYPE g_jobcode_type is table of TBL_GOODS.JOBCODE%TYPE
	index by binary_integer;
	TYPE g_cateflag_type is table of TBL_GOODS.CATEFLAG%TYPE
	index by binary_integer;
	TYPE g_constrain_type is table of TBL_GOODS.CONSTRAIN%TYPE
	index by binary_integer;
	TYPE g_moddate_type is table of TBL_GOODS.MODDATE%TYPE
	index by binary_integer;
	TYPE g_pl_no_type is table of TBL_GOODS.P_PL_NO%TYPE
	index by binary_integer;
	TYPE g_imgurl_type is table of TBL_GOODS.P_IMGURL%TYPE
	index by binary_integer;
	TYPE g_imgurlflag_type is table of TBL_GOODS.P_IMGURLFLAG%TYPE
	index by binary_integer;
	TYPE g_rsiflag_type is table of TBL_GOODS.RSIFLAG%TYPE
	index by binary_integer;
	TYPE g_refshop_type is table of TBL_GOODS.REFSHOP%TYPE
	index by binary_integer;
	TYPE g_box_modelnm_type is table of TBL_GOODS.BOX_MODELNM%TYPE
	index by binary_integer;
    TYPE g_weight_type is table of TBL_GOODS.WEIGHT%TYPE
	index by binary_integer;
    TYPE g_info_sum_point_type is table of TBL_GOODS.INFO_SUM_POINT%TYPE
	index by binary_integer;
    TYPE g_p_pl_no_type is table of TBL_GOODS.P_PL_NO%TYPE
	index by binary_integer;
    TYPE g_p_imgurl_type is table of TBL_GOODS.P_IMGURL%TYPE
	index by binary_integer;
    TYPE g_p_imgurlflag_type is table of TBL_GOODS.P_IMGURLFLAG%TYPE
	index by binary_integer;
    TYPE g_condiname_type is table of TBL_GOODS.CONDINAME%TYPE
	index by binary_integer;
    TYPE g_flag_type is table of TBL_GOODS.FLAG%TYPE
	index by binary_integer;
  /* 배송비 포함 최저가 nova23 2016.06.21*/
    TYPE g_minprice2_type is table of TBL_GOODS.MINPRICE2%TYPE    
	index by binary_integer;
    TYPE g_minprice3_type is table of TBL_GOODS.MINPRICE3%TYPE
	index by binary_integer;
    TYPE g_minprice4_type is table of TBL_GOODS.MINPRICE4%TYPE
	index by binary_integer;    
    TYPE g_bbs_num_type is table of TBL_GOODS.BBS_NUM%TYPE
	index by binary_integer;        

	v_Modelno_old g_modelno_type;
	v_Modelno_new g_modelno_type;
	v_Modelnm_old g_modelnm_type;
	v_Modelnm_new g_modelnm_type;
	v_Category_old g_category_type;
	v_Category_new g_category_type;
	v_Factory_old g_factory_type;
	v_Factory_new g_factory_type;
	v_Spec_old g_spec_type;
	v_Spec_new g_spec_type;
	v_Cdate_old g_c_date_type;
	v_Cdate_new g_c_date_type;
	v_Imgchk_old g_imgchk_type;
	v_Imgchk_new g_imgchk_type;
	v_Minprice_old g_minprice_type;
	v_Minprice_new g_minprice_type;
	v_Mallcnt_old g_mallcnt_type;
	v_Mallcnt_new g_mallcnt_type;
	v_Kbnum_old g_kb_num_type;
	v_Kbnum_new g_kb_num_type;
	v_Openexpectflag_old g_openexpectflag_type;
	v_Openexpectflag_new g_openexpectflag_type;
	v_Recommend_old g_recommend_type;
	v_Recommend_new g_recommend_type;
	v_Popular_old g_popular_type;
	v_Popular_new g_popular_type;
    v_Sum_popular_old g_sum_popular_type;
	v_Sum_popular_new g_sum_popular_type;
	v_Sale_cnt_old g_sale_cnt_type;
	v_Sale_cnt_new g_sale_cnt_type;
	v_Gbcnt_old g_gbcnt_type;
	v_Gbcnt_new g_gbcnt_type;
	v_Ca_code_old g_ca_code_type;
	v_Ca_code_new g_ca_code_type;
	v_Brandcode1_old g_brandcode1_type;
	v_Brandcode1_new g_brandcode1_type;
	v_Brandcode2_old g_brandcode2_type;
	v_Brandcode2_new g_brandcode2_type;
	v_Modelnogroup_old g_modelno_group_type;
	v_Modelnogroup_new g_modelno_group_type;
	v_Keyword_old g_keyword_type;
	v_Keyword_new g_keyword_type;
	v_Keyword2_old g_keyword2_type;
	v_Keyword2_new g_keyword2_type;
	v_Brand_old g_brand_type;
	v_Brand_new g_brand_type;
	v_Specopt_old g_specopt_type;
	v_Specopt_new g_specopt_type;
	v_Jobcode_old g_jobcode_type;
	v_Jobcode_new g_jobcode_type;
	v_Cateflag_old g_cateflag_type;
	v_Cateflag_new g_cateflag_type;
	v_Constrain_old g_constrain_type;
	v_Constrain_new g_constrain_type;
	v_Moddate_old g_moddate_type;
	v_Moddate_new g_moddate_type;
	v_Pl_no_old g_pl_no_type;
	v_Pl_no_new g_pl_no_type;
	v_Imgurl_new g_imgurl_type;
	v_Imgurlflag_new g_imgurlflag_type;
	v_Rsiflag_old g_rsiflag_type;
	v_Rsiflag_new g_rsiflag_type;
	v_Refshop_old g_refshop_type;
	v_Refshop_new g_refshop_type;
	v_Boxmodelnm_old g_box_modelnm_type;
	v_Boxmodelnm_new g_box_modelnm_type;
    v_Weight_old    g_weight_type;
	v_Weight_new    g_weight_type;
	v_Info_sum_point_old g_info_sum_point_type;
    v_Info_sum_point_new g_info_sum_point_type;
    v_P_pl_no_old g_p_pl_no_type;
    v_P_pl_no_new g_p_pl_no_type;
    v_P_imgurl_old g_p_imgurl_type;
    v_P_imgurl_new g_p_imgurl_type;
    v_P_imgurlflag_old  g_p_imgurlflag_type;
    v_P_imgurlflag_new  g_p_imgurlflag_type;
    v_Condiname_old     g_condiname_type;
    v_Condiname_new     g_condiname_type;
    v_Flag_old     g_condiname_type;
    v_Flag_new     g_condiname_type;
    /* 배송비 포함 최저가 nova23 2016.06.21*/
    v_Minprice2_old g_minprice2_type;
    v_Minprice2_new g_minprice2_type;    
    v_Minprice3_old g_minprice3_type;
    v_Minprice3_new g_minprice3_type;
    v_Minprice4_old g_minprice4_type;
    v_Minprice4_new g_minprice4_type;
    
    v_Bbs_Num_old g_bbs_num_type;
    v_Bbs_Num_new g_bbs_num_type;

	g_index	NUMBER(8) := 0;

END pac_Goods_DataLoop;
