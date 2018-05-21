/* *************************************************************************
 * NAME : DBENURI.TR_ROW_INGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-05-11 11:11:27
 *        Modify: 2018-05-11 11:12:10
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_INGOODS" AFTER INSERT ON TBL_GOODS
FOR EACH ROW
 WHEN (to_number(nvl(new.jobcode, '0')) >= 1 OR new.constrain = '5' ) BEGIN

        pg_Goods_DataLoop.g_index                                             := pg_Goods_DataLoop.g_index + 1;
        pg_Goods_DataLoop.v_Modelno_new           (pg_Goods_DataLoop.g_index) := NVL(:new.modelno, 0);
        pg_Goods_DataLoop.v_Modelnm_new           (pg_Goods_DataLoop.g_index) := NVL(:new.modelnm, '');
        pg_Goods_DataLoop.v_Factory_new           (pg_Goods_DataLoop.g_index) := NVL(:new.factory, '');
        pg_Goods_DataLoop.v_Spec_new              (pg_Goods_DataLoop.g_index) := NVL(:new.spec, '');
        pg_Goods_DataLoop.v_Cdate_new             (pg_Goods_DataLoop.g_index) :=     :new.c_date;
        pg_Goods_DataLoop.v_Imgchk_new            (pg_Goods_DataLoop.g_index) := NVL(:new.imgchk, '');
-- 0418 pg_Goods_DataLoop.v_Minprice_new          (pg_Goods_DataLoop.g_index) := NVL(:new.minprice, 0);
-- 0418 pg_Goods_DataLoop.v_Mallcnt_new           (pg_Goods_DataLoop.g_index) := NVL(:new.mallcnt, 0);
-- 0418 pg_Goods_DataLoop.v_Kbnum_new             (pg_Goods_DataLoop.g_index) := NVL(:new.kb_num, 0);
        pg_Goods_DataLoop.v_Openexpectflag_new    (pg_Goods_DataLoop.g_index) := NVL(:new.openexpectflag, '');
        pg_Goods_DataLoop.v_Recommend_new         (pg_Goods_DataLoop.g_index) := NVL(:new.recommend, '');
-- 0418 pg_Goods_DataLoop.v_Popular_new           (pg_Goods_DataLoop.g_index) := NVL(:new.popular, 0);
-- 0418 pg_Goods_DataLoop.v_Sale_cnt_new          (pg_Goods_DataLoop.g_index) := NVL(:new.sale_cnt, 0);
-- 0418 pg_Goods_DataLoop.v_Gbcnt_new             (pg_Goods_DataLoop.g_index) := NVL(:new.gbcnt, 0);
-- 0418 pg_Goods_DataLoop.v_Ca_code_new           (pg_Goods_DataLoop.g_index) := NVL(:new.ca_code, '');
        pg_Goods_DataLoop.v_Modelnogroup_new      (pg_Goods_DataLoop.g_index) := NVL(:new.modelno_group, 0);
        pg_Goods_DataLoop.v_Keyword_new           (pg_Goods_DataLoop.g_index) := NVL(:new.keyword, '');
        pg_Goods_DataLoop.v_Keyword2_new          (pg_Goods_DataLoop.g_index) := NVL(:new.keyword2, '');
        pg_Goods_DataLoop.v_Brand_new             (pg_Goods_DataLoop.g_index) := NVL(:new.brand, '');
        pg_Goods_DataLoop.v_Jobcode_new           (pg_Goods_DataLoop.g_index) := NVL(:new.jobcode, '');
-- 0418 pg_Goods_DataLoop.v_Cateflag_new          (pg_Goods_DataLoop.g_index) := NVL(:new.cateflag, '');
        pg_Goods_DataLoop.v_Constrain_new         (pg_Goods_DataLoop.g_index) := NVL(:new.constrain, '');
        ----------------------------------------------------------------------------------------------------------------------------------------------    
        -- 0502 수정 : rsiflag2 -> rsiflag  확인 필요 
        ----------------------------------------------------------------------------------------------------------------------------------------------    
        pg_Goods_DataLoop.v_Rsiflag_new           (pg_Goods_DataLoop.g_index) := NVL(:new.rsiflag, '0');
        pg_Goods_DataLoop.v_Refshop_new           (pg_Goods_DataLoop.g_index) := NVL(:new.refshop, '0');
-- 0418 pg_Goods_DataLoop.v_Boxmodelnm_new        (pg_Goods_DataLoop.g_index) := NVL(:new.box_modelnm, '');
        pg_Goods_DataLoop.v_Weight_new            (pg_Goods_DataLoop.g_index) :=     :new.weight;
-- 0418 pg_Goods_DataLoop.v_Info_sum_point_new    (pg_Goods_DataLoop.g_index) :=     :new.info_sum_point;
        pg_Goods_DataLoop.v_P_pl_no_new           (pg_Goods_DataLoop.g_index) :=     :new.p_pl_no;
        pg_Goods_DataLoop.v_P_imgurl_new          (pg_Goods_DataLoop.g_index) :=     :new.p_imgurl;
        pg_Goods_DataLoop.v_P_imgurlflag_new      (pg_Goods_DataLoop.g_index) :=     :new.p_imgurlflag;
        pg_Goods_DataLoop.v_Condiname_new         (pg_Goods_DataLoop.g_index) :=     :new.condiname;
-- 0418 pg_Goods_DataLoop.v_Minprice2_new         (pg_Goods_DataLoop.g_index) := NVL(:new.minprice2, 0);  
-- 0418 pg_Goods_DataLoop.v_Minprice3_new         (pg_Goods_DataLoop.g_index) := NVL(:new.minprice3, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice4_new         (pg_Goods_DataLoop.g_index) := NVL(:new.minprice4, 0);
    
-- 0418 pg_Goods_DataLoop.v_Bbs_Num_new           (pg_Goods_DataLoop.g_index) := NVL(:new.bbs_num, 0);

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE TRIGGER 
-- "DBENURI"."TRG_ROW_INGOODS" AFTER INSERT ON TBL_GOODS
-- FOR EACH ROW
--   
-- WHEN(to_number(nvl(new.jobcode, '0')) >= 1 OR new.constrain = '5' OR SUBSTR(new.ca_code,0,4) = '8701') 
-- BEGIN
-- 
--  pac_Goods_DataLoop.g_index  := pac_Goods_DataLoop.g_index + 1;
--  pac_Goods_DataLoop.v_Modelno_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelno, 0);
--  pac_Goods_DataLoop.v_Modelnm_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelnm, '');
--  pac_Goods_DataLoop.v_Factory_new(pac_Goods_DataLoop.g_index) := NVL(:new.factory, '');
--  pac_Goods_DataLoop.v_Spec_new(pac_Goods_DataLoop.g_index) := NVL(:new.spec, '');
--  pac_Goods_DataLoop.v_Cdate_new(pac_Goods_DataLoop.g_index) := :new.c_date;
--  pac_Goods_DataLoop.v_Imgchk_new(pac_Goods_DataLoop.g_index) := NVL(:new.imgchk, '');
--  pac_Goods_DataLoop.v_Minprice_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice, 0);
--  pac_Goods_DataLoop.v_Mallcnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.mallcnt, 0);
--  pac_Goods_DataLoop.v_Kbnum_new(pac_Goods_DataLoop.g_index) := NVL(:new.kb_num, 0);
--  pac_Goods_DataLoop.v_Openexpectflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.openexpectflag, '');
--  pac_Goods_DataLoop.v_Recommend_new(pac_Goods_DataLoop.g_index) := NVL(:new.recommend, '');
--  pac_Goods_DataLoop.v_Popular_new(pac_Goods_DataLoop.g_index) := NVL(:new.popular, 0);
--  pac_Goods_DataLoop.v_Sale_cnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.sale_cnt, 0);
--  pac_Goods_DataLoop.v_Gbcnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.gbcnt, 0);
--  pac_Goods_DataLoop.v_Ca_code_new(pac_Goods_DataLoop.g_index) := NVL(:new.ca_code, '');
--  pac_Goods_DataLoop.v_Modelnogroup_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelno_group, 0);
--  pac_Goods_DataLoop.v_Keyword_new(pac_Goods_DataLoop.g_index) := NVL(:new.keyword, '');
--  pac_Goods_DataLoop.v_Keyword2_new(pac_Goods_DataLoop.g_index) := NVL(:new.keyword2, '');
--  pac_Goods_DataLoop.v_Brand_new(pac_Goods_DataLoop.g_index) := NVL(:new.brand, '');
--  pac_Goods_DataLoop.v_Jobcode_new(pac_Goods_DataLoop.g_index) := NVL(:new.jobcode, '');
--  pac_Goods_DataLoop.v_Cateflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.cateflag, '');
--  pac_Goods_DataLoop.v_Constrain_new(pac_Goods_DataLoop.g_index) := NVL(:new.constrain, '');
--  pac_Goods_DataLoop.v_Rsiflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.rsiflag2, '0');
--  pac_Goods_DataLoop.v_Refshop_new(pac_Goods_DataLoop.g_index) := NVL(:new.refshop, '0');
--  pac_Goods_DataLoop.v_Boxmodelnm_new(pac_Goods_DataLoop.g_index) := NVL(:new.box_modelnm, '');
--     pac_Goods_DataLoop.v_Weight_new(pac_Goods_DataLoop.g_index) := :new.weight;
--     pac_Goods_DataLoop.v_Info_sum_point_new(pac_Goods_DataLoop.g_index) := :new.info_sum_point;
--     pac_Goods_DataLoop.v_P_pl_no_new(pac_Goods_DataLoop.g_index) := :new.p_pl_no;
--     pac_Goods_DataLoop.v_P_imgurl_new(pac_Goods_DataLoop.g_index) := :new.p_imgurl;
--     pac_Goods_DataLoop.v_P_imgurlflag_new(pac_Goods_DataLoop.g_index) := :new.p_imgurlflag;
--     pac_Goods_DataLoop.v_Condiname_new(pac_Goods_DataLoop.g_index) := :new.condiname;
--   pac_Goods_DataLoop.v_Minprice2_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice2, 0);  
--  pac_Goods_DataLoop.v_Minprice3_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice3, 0);
--  pac_Goods_DataLoop.v_Minprice4_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice4, 0);
--     
--     pac_Goods_DataLoop.v_Bbs_Num_new(pac_Goods_DataLoop.g_index) := NVL(:new.bbs_num, 0);
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------ 


ALTER TRIGGER "DBENURI"."TR_ROW_INGOODS" ENABLE