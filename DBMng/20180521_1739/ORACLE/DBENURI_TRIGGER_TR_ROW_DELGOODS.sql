/* *************************************************************************
 * NAME : DBENURI.TR_ROW_DELGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-18 17:58:44
 *        Modify: 2018-05-11 11:02:29
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_DELGOODS" AFTER DELETE ON BAK_TBL_GOODS
FOR EACH ROW
 WHEN (nvl(old.jobcode, '0') <> '0' AND old.constrain = '1') BEGIN

       pg_Goods_DataLoop.g_index                                            := pg_Goods_DataLoop.g_index + 1;
       pg_Goods_DataLoop.v_Modelno_old          (pg_Goods_DataLoop.g_index) := NVL(:old.modelno,         0);
       pg_Goods_DataLoop.v_Modelnm_old          (pg_Goods_DataLoop.g_index) := NVL(:old.modelnm,        '');
       pg_Goods_DataLoop.v_Factory_old          (pg_Goods_DataLoop.g_index) := NVL(:old.factory,        '');
       pg_Goods_DataLoop.v_Spec_old             (pg_Goods_DataLoop.g_index) := NVL(:old.spec,           '');
       pg_Goods_DataLoop.v_Cdate_old            (pg_Goods_DataLoop.g_index) :=     :old.c_date;
       pg_Goods_DataLoop.v_Imgchk_old           (pg_Goods_DataLoop.g_index) := NVL(:old.imgchk,         '');
--0418 pg_Goods_DataLoop.v_Minprice_old         (pg_Goods_DataLoop.g_index) := NVL(:old.minprice,        0);
--0418 pg_Goods_DataLoop.v_Mallcnt_old          (pg_Goods_DataLoop.g_index) := NVL(:old.mallcnt,         0);
--0418 pg_Goods_DataLoop.v_Kbnum_old            (pg_Goods_DataLoop.g_index) := NVL(:old.kb_num,          0);
       pg_Goods_DataLoop.v_Openexpectflag_old   (pg_Goods_DataLoop.g_index) := NVL(:old.openexpectflag, '');
       pg_Goods_DataLoop.v_Recommend_old        (pg_Goods_DataLoop.g_index) := NVL(:old.recommend,      '');
--0418 pg_Goods_DataLoop.v_Popular_old          (pg_Goods_DataLoop.g_index) := NVL(:old.popular,         0);
--0418 pg_Goods_DataLoop.v_Gbcnt_old            (pg_Goods_DataLoop.g_index) := NVL(:old.gbcnt,           0);
--0418 pg_Goods_DataLoop.v_Ca_code_old          (pg_Goods_DataLoop.g_index) := NVL(:old.ca_code,        '');
       pg_Goods_DataLoop.v_Modelnogroup_old     (pg_Goods_DataLoop.g_index) := NVL(:old.modelno_group,   0);
       pg_Goods_DataLoop.v_Keyword_old          (pg_Goods_DataLoop.g_index) := NVL(:old.keyword,        '');
       pg_Goods_DataLoop.v_Jobcode_old          (pg_Goods_DataLoop.g_index) := NVL(:old.jobcode,        '');
--0418 pg_Goods_DataLoop.v_Cateflag_old         (pg_Goods_DataLoop.g_index) := NVL(:old.cateflag,       '');
       pg_Goods_DataLoop.v_Constrain_old        (pg_Goods_DataLoop.g_index) := NVL(:old.constrain,      '');
       pg_Goods_DataLoop.v_Rsiflag_old          (pg_Goods_DataLoop.g_index) := NVL(:old.rsiflag,       '0');
       pg_Goods_DataLoop.v_Refshop_old          (pg_Goods_DataLoop.g_index) := NVL(:old.refshop,       '0');
--0418 pg_Goods_DataLoop.v_Boxmodelnm_old       (pg_Goods_DataLoop.g_index) := NVL(:old.box_modelnm,    '');
--0418 pg_Goods_DataLoop.v_Bbs_Num_old          (pg_Goods_DataLoop.g_index) := NVL(:old.bbs_num,         0);

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

ALTER TRIGGER "DBENURI"."TR_ROW_DELGOODS" ENABLE