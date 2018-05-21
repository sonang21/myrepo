/* *************************************************************************
 * NAME : DBENURI.TR_ROW_UPGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-05-11 11:16:18
 *        Modify: 2018-05-11 11:21:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_UPGOODS" AFTER UPDATE ON TBL_GOODS
FOR EACH ROW
------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 0502 확인 필요, 실제값은 0,1 만 있음(TBL_CATE_GOODS 확인시) 
------------------------------------------------------------------------------------------------------------------------------------------------------    
-- 0418 WHEN(new.cateflag in ('0','1'))
------------------------------------------------------------------------------------------------------------------------------------------------------    
BEGIN
        pg_Goods_DataLoop.g_index                                            := pg_Goods_DataLoop.g_index + 1;
        pg_Goods_DataLoop.v_Modelno_old          (pg_Goods_DataLoop.g_index) := NVL(:old.modelno, 0);
        pg_Goods_DataLoop.v_Modelno_new          (pg_Goods_DataLoop.g_index) := NVL(:new.modelno, 0);
        pg_Goods_DataLoop.v_Modelnm_old          (pg_Goods_DataLoop.g_index) := NVL(:old.modelnm, '');
        pg_Goods_DataLoop.v_Modelnm_new          (pg_Goods_DataLoop.g_index) := NVL(:new.modelnm, '');
        pg_Goods_DataLoop.v_Factory_old          (pg_Goods_DataLoop.g_index) := NVL(:old.factory, '');
        pg_Goods_DataLoop.v_Factory_new          (pg_Goods_DataLoop.g_index) := NVL(:new.factory, '');
        pg_Goods_DataLoop.v_Spec_old             (pg_Goods_DataLoop.g_index) := NVL(:old.spec, '');
        pg_Goods_DataLoop.v_Spec_new             (pg_Goods_DataLoop.g_index) := NVL(:new.spec, '');
        pg_Goods_DataLoop.v_Cdate_old            (pg_Goods_DataLoop.g_index) := :old.c_date;
        pg_Goods_DataLoop.v_Cdate_new            (pg_Goods_DataLoop.g_index) := :new.c_date;
        pg_Goods_DataLoop.v_Imgchk_old           (pg_Goods_DataLoop.g_index) := NVL(:old.imgchk, '');
        pg_Goods_DataLoop.v_Imgchk_new           (pg_Goods_DataLoop.g_index) := NVL(:new.imgchk, '');
-- 0418 pg_Goods_DataLoop.v_Minprice_old         (pg_Goods_DataLoop.g_index) := NVL(:old.minprice, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice_new         (pg_Goods_DataLoop.g_index) := NVL(:new.minprice, 0);
-- 0418 pg_Goods_DataLoop.v_Mallcnt_old          (pg_Goods_DataLoop.g_index) := NVL(:old.mallcnt, 0);
-- 0418 pg_Goods_DataLoop.v_Mallcnt_new          (pg_Goods_DataLoop.g_index) := NVL(:new.mallcnt, 0);
-- 0418 pg_Goods_DataLoop.v_Kbnum_old            (pg_Goods_DataLoop.g_index) := NVL(:old.kb_num, 0);
-- 0418 pg_Goods_DataLoop.v_Kbnum_new            (pg_Goods_DataLoop.g_index) := NVL(:new.kb_num, 0);
        pg_Goods_DataLoop.v_Openexpectflag_old   (pg_Goods_DataLoop.g_index) := NVL(:old.openexpectflag, '');
        pg_Goods_DataLoop.v_Openexpectflag_new   (pg_Goods_DataLoop.g_index) := NVL(:new.openexpectflag, '');
        pg_Goods_DataLoop.v_Recommend_old        (pg_Goods_DataLoop.g_index) := NVL(:old.recommend, '');
        pg_Goods_DataLoop.v_Recommend_new        (pg_Goods_DataLoop.g_index) := NVL(:new.recommend, '');
-- 0418 pg_Goods_DataLoop.v_Popular_old          (pg_Goods_DataLoop.g_index) := NVL(:old.popular, 0);
-- 0418 pg_Goods_DataLoop.v_Popular_new          (pg_Goods_DataLoop.g_index) := NVL(:new.popular, 0);
-- 0418 pg_Goods_DataLoop.v_Sum_popular_old      (pg_Goods_DataLoop.g_index) := NVL(:old.sum_popular, 0);
-- 0418 pg_Goods_DataLoop.v_Sum_popular_new      (pg_Goods_DataLoop.g_index) := NVL(:new.sum_popular, 0);
        
-- 0418 pg_Goods_DataLoop.v_Sale_cnt_old         (pg_Goods_DataLoop.g_index) := NVL(:old.sale_cnt, 0);
-- 0418 pg_Goods_DataLoop.v_Sale_cnt_new         (pg_Goods_DataLoop.g_index) := NVL(:new.sale_cnt, 0);
-- 0418 pg_Goods_DataLoop.v_Gbcnt_old            (pg_Goods_DataLoop.g_index) := NVL(:old.gbcnt, 0);
-- 0418 pg_Goods_DataLoop.v_Gbcnt_new            (pg_Goods_DataLoop.g_index) := NVL(:new.gbcnt, 0);

-- 0418 pg_Goods_DataLoop.v_Ca_code_old          (pg_Goods_DataLoop.g_index) := NVL(:old.ca_code, '');
-- 0418 pg_Goods_DataLoop.v_Ca_code_new          (pg_Goods_DataLoop.g_index) := NVL(:new.ca_code, '');
        pg_Goods_DataLoop.v_Modelnogroup_old     (pg_Goods_DataLoop.g_index) := NVL(:old.modelno_group, 0);
        pg_Goods_DataLoop.v_Modelnogroup_new     (pg_Goods_DataLoop.g_index) := NVL(:new.modelno_group, 0);
        pg_Goods_DataLoop.v_Keyword_old          (pg_Goods_DataLoop.g_index) := NVL(:old.keyword, '');
        pg_Goods_DataLoop.v_Keyword_new          (pg_Goods_DataLoop.g_index) := NVL(:new.keyword, '');
        pg_Goods_DataLoop.v_Keyword2_old         (pg_Goods_DataLoop.g_index) := NVL(:old.keyword2, '');
        pg_Goods_DataLoop.v_Keyword2_new         (pg_Goods_DataLoop.g_index) := NVL(:new.keyword2, '');
        pg_Goods_DataLoop.v_Brand_old            (pg_Goods_DataLoop.g_index) := NVL(:old.brand, '');
        pg_Goods_DataLoop.v_Brand_new            (pg_Goods_DataLoop.g_index) := NVL(:new.brand, '');
        pg_Goods_DataLoop.v_Jobcode_old          (pg_Goods_DataLoop.g_index) := NVL(:old.jobcode, '');
        pg_Goods_DataLoop.v_Jobcode_new          (pg_Goods_DataLoop.g_index) := NVL(:new.jobcode, '');
-- 0418 pg_Goods_DataLoop.v_Cateflag_old         (pg_Goods_DataLoop.g_index) := NVL(:old.cateflag, '');
-- 0418 pg_Goods_DataLoop.v_Cateflag_new         (pg_Goods_DataLoop.g_index) := NVL(:new.cateflag, '');
        pg_Goods_DataLoop.v_Constrain_old        (pg_Goods_DataLoop.g_index) := NVL(:old.constrain, '');
        pg_Goods_DataLoop.v_Constrain_new        (pg_Goods_DataLoop.g_index) := NVL(:new.constrain, '');
        pg_Goods_DataLoop.v_Moddate_old          (pg_Goods_DataLoop.g_index) := :old.moddate;
        pg_Goods_DataLoop.v_Moddate_new          (pg_Goods_DataLoop.g_index) := :new.moddate;
        pg_Goods_DataLoop.v_Pl_no_old            (pg_Goods_DataLoop.g_index) := :old.p_pl_no;
        pg_Goods_DataLoop.v_Pl_no_new            (pg_Goods_DataLoop.g_index) := :new.p_pl_no;
        pg_Goods_DataLoop.v_Imgurl_new           (pg_Goods_DataLoop.g_index) := :new.p_imgurl;
        pg_Goods_DataLoop.v_Imgurlflag_new       (pg_Goods_DataLoop.g_index) := :new.p_imgurlflag;
        ----------------------------------------------------------------------------------------------------------------------------------------------    
        -- 0502 수정 :old.rsiflag2 -> :old.rsiflag 확인 필요
        ----------------------------------------------------------------------------------------------------------------------------------------------    
        pg_Goods_DataLoop.v_Rsiflag_old          (pg_Goods_DataLoop.g_index) := NVL(:old.rsiflag, '0'); 
        pg_Goods_DataLoop.v_Rsiflag_new          (pg_Goods_DataLoop.g_index) := NVL(:new.rsiflag, '0'); 
        ----------------------------------------------------------------------------------------------------------------------------------------------    
        pg_Goods_DataLoop.v_Refshop_old          (pg_Goods_DataLoop.g_index) := NVL(:old.refshop, '0');
        pg_Goods_DataLoop.v_Refshop_new          (pg_Goods_DataLoop.g_index) := NVL(:new.refshop, '0');
-- 0418 pg_Goods_DataLoop.v_Boxmodelnm_old       (pg_Goods_DataLoop.g_index) := NVL(:old.box_modelnm, '');
-- 0418 pg_Goods_DataLoop.v_Boxmodelnm_new       (pg_Goods_DataLoop.g_index) := NVL(:new.box_modelnm, '');
        pg_Goods_DataLoop.v_Weight_old           (pg_Goods_DataLoop.g_index) := :old.weight;
        pg_Goods_DataLoop.v_Weight_new           (pg_Goods_DataLoop.g_index) := :new.weight;
-- 0418 pg_Goods_DataLoop.v_Info_sum_point_old   (pg_Goods_DataLoop.g_index) := :old.info_sum_point;
-- 0418 pg_Goods_DataLoop.v_Info_sum_point_new   (pg_Goods_DataLoop.g_index) := :new.info_sum_point;
        pg_Goods_DataLoop.v_P_pl_no_old          (pg_Goods_DataLoop.g_index) := :old.p_pl_no;
        pg_Goods_DataLoop.v_P_pl_no_new          (pg_Goods_DataLoop.g_index) := :new.p_pl_no;
        pg_Goods_DataLoop.v_P_imgurl_old         (pg_Goods_DataLoop.g_index) := :old.p_imgurl;
        pg_Goods_DataLoop.v_P_imgurl_new         (pg_Goods_DataLoop.g_index) := :new.p_imgurl;
        pg_Goods_DataLoop.v_P_imgurlflag_old     (pg_Goods_DataLoop.g_index) := :old.p_imgurlflag;
        pg_Goods_DataLoop.v_P_imgurlflag_new     (pg_Goods_DataLoop.g_index) := :new.p_imgurlflag;
        pg_Goods_DataLoop.v_Condiname_old        (pg_Goods_DataLoop.g_index) := :old.condiname;
        pg_Goods_DataLoop.v_Condiname_new        (pg_Goods_DataLoop.g_index) := :new.condiname;
        pg_Goods_DataLoop.v_Flag_old             (pg_Goods_DataLoop.g_index) := :old.flag;
        pg_Goods_DataLoop.v_Flag_new             (pg_Goods_DataLoop.g_index) := :new.flag;

-- 0418 pg_Goods_DataLoop.v_Minprice2_old        (pg_Goods_DataLoop.g_index) := NVL(:old.minprice2, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice2_new        (pg_Goods_DataLoop.g_index) := NVL(:new.minprice2, 0);
  
-- 0418 pg_Goods_DataLoop.v_Minprice3_old        (pg_Goods_DataLoop.g_index) := NVL(:old.minprice3, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice3_new        (pg_Goods_DataLoop.g_index) := NVL(:new.minprice3, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice4_old        (pg_Goods_DataLoop.g_index) := NVL(:old.minprice4, 0);
-- 0418 pg_Goods_DataLoop.v_Minprice4_new        (pg_Goods_DataLoop.g_index) := NVL(:new.minprice4, 0);
    
-- 0418 pg_Goods_DataLoop.v_Bbs_Num_old          (pg_Goods_DataLoop.g_index) := NVL(:old.bbs_num, 0);
-- 0418 pg_Goods_DataLoop.v_Bbs_Num_new          (pg_Goods_DataLoop.g_index) := NVL(:new.bbs_num, 0);

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
-- CREATE OR REPLACE TRIGGER                                                                             
-- "DBENURI"."ASIS_TRG_ROW_UPGOODS" AFTER UPDATE ON ASIS_TBL_GOODS                                       
-- FOR EACH ROW                                                                                          
-- --WHEN (new.cateflag = '0')                                                                           
--                                                                                                       
-- WHEN(new.cateflag in ('0','1'))                                                                       
-- BEGIN                                                                                                 
--                                                                                                       
--  pac_Goods_DataLoop.g_index  := pac_Goods_DataLoop.g_index + 1;                                      
--  pac_Goods_DataLoop.v_Modelno_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelno, 0);               
--  pac_Goods_DataLoop.v_Modelno_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelno, 0);               
--  pac_Goods_DataLoop.v_Modelnm_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelnm, '');              
--  pac_Goods_DataLoop.v_Modelnm_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelnm, '');              
--  pac_Goods_DataLoop.v_Factory_old(pac_Goods_DataLoop.g_index) := NVL(:old.factory, '');              
--  pac_Goods_DataLoop.v_Factory_new(pac_Goods_DataLoop.g_index) := NVL(:new.factory, '');              
--  pac_Goods_DataLoop.v_Spec_old(pac_Goods_DataLoop.g_index) := NVL(:old.spec, '');                    
--  pac_Goods_DataLoop.v_Spec_new(pac_Goods_DataLoop.g_index) := NVL(:new.spec, '');                    
--  pac_Goods_DataLoop.v_Cdate_old(pac_Goods_DataLoop.g_index) := :old.c_date;                          
--  pac_Goods_DataLoop.v_Cdate_new(pac_Goods_DataLoop.g_index) := :new.c_date;                          
--  pac_Goods_DataLoop.v_Imgchk_old(pac_Goods_DataLoop.g_index) := NVL(:old.imgchk, '');                
--  pac_Goods_DataLoop.v_Imgchk_new(pac_Goods_DataLoop.g_index) := NVL(:new.imgchk, '');                
--  pac_Goods_DataLoop.v_Minprice_old(pac_Goods_DataLoop.g_index) := NVL(:old.minprice, 0);             
--  pac_Goods_DataLoop.v_Minprice_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice, 0);             
--  pac_Goods_DataLoop.v_Mallcnt_old(pac_Goods_DataLoop.g_index) := NVL(:old.mallcnt, 0);               
--  pac_Goods_DataLoop.v_Mallcnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.mallcnt, 0);               
--  pac_Goods_DataLoop.v_Kbnum_old(pac_Goods_DataLoop.g_index) := NVL(:old.kb_num, 0);                  
--  pac_Goods_DataLoop.v_Kbnum_new(pac_Goods_DataLoop.g_index) := NVL(:new.kb_num, 0);                  
--  pac_Goods_DataLoop.v_Openexpectflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.openexpectflag, '');
--  pac_Goods_DataLoop.v_Openexpectflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.openexpectflag, '');
--  pac_Goods_DataLoop.v_Recommend_old(pac_Goods_DataLoop.g_index) := NVL(:old.recommend, '');          
--  pac_Goods_DataLoop.v_Recommend_new(pac_Goods_DataLoop.g_index) := NVL(:new.recommend, '');          
--  pac_Goods_DataLoop.v_Popular_old(pac_Goods_DataLoop.g_index) := NVL(:old.popular, 0);               
--  pac_Goods_DataLoop.v_Popular_new(pac_Goods_DataLoop.g_index) := NVL(:new.popular, 0);               
--     pac_Goods_DataLoop.v_Sum_popular_old(pac_Goods_DataLoop.g_index) := NVL(:old.sum_popular, 0);     
--  pac_Goods_DataLoop.v_Sum_popular_new(pac_Goods_DataLoop.g_index) := NVL(:new.sum_popular, 0);       
--                                                                                                       
--  pac_Goods_DataLoop.v_Sale_cnt_old(pac_Goods_DataLoop.g_index) := NVL(:old.sale_cnt, 0);             
--  pac_Goods_DataLoop.v_Sale_cnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.sale_cnt, 0);             
--  pac_Goods_DataLoop.v_Gbcnt_old(pac_Goods_DataLoop.g_index) := NVL(:old.gbcnt, 0);                   
--  pac_Goods_DataLoop.v_Gbcnt_new(pac_Goods_DataLoop.g_index) := NVL(:new.gbcnt, 0);                   
--  pac_Goods_DataLoop.v_Ca_code_old(pac_Goods_DataLoop.g_index) := NVL(:old.ca_code, '');              
--  pac_Goods_DataLoop.v_Ca_code_new(pac_Goods_DataLoop.g_index) := NVL(:new.ca_code, '');              
--  pac_Goods_DataLoop.v_Modelnogroup_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelno_group, 0);    
--  pac_Goods_DataLoop.v_Modelnogroup_new(pac_Goods_DataLoop.g_index) := NVL(:new.modelno_group, 0);    
--  pac_Goods_DataLoop.v_Keyword_old(pac_Goods_DataLoop.g_index) := NVL(:old.keyword, '');              
--  pac_Goods_DataLoop.v_Keyword_new(pac_Goods_DataLoop.g_index) := NVL(:new.keyword, '');              
--  pac_Goods_DataLoop.v_Keyword2_old(pac_Goods_DataLoop.g_index) := NVL(:old.keyword2, '');            
--  pac_Goods_DataLoop.v_Keyword2_new(pac_Goods_DataLoop.g_index) := NVL(:new.keyword2, '');            
--  pac_Goods_DataLoop.v_Brand_old(pac_Goods_DataLoop.g_index) := NVL(:old.brand, '');                  
--  pac_Goods_DataLoop.v_Brand_new(pac_Goods_DataLoop.g_index) := NVL(:new.brand, '');                  
--  pac_Goods_DataLoop.v_Jobcode_old(pac_Goods_DataLoop.g_index) := NVL(:old.jobcode, '');              
--  pac_Goods_DataLoop.v_Jobcode_new(pac_Goods_DataLoop.g_index) := NVL(:new.jobcode, '');              
--  pac_Goods_DataLoop.v_Cateflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.cateflag, '');            
--  pac_Goods_DataLoop.v_Cateflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.cateflag, '');            
--  pac_Goods_DataLoop.v_Constrain_old(pac_Goods_DataLoop.g_index) := NVL(:old.constrain, '');          
--  pac_Goods_DataLoop.v_Constrain_new(pac_Goods_DataLoop.g_index) := NVL(:new.constrain, '');          
--  pac_Goods_DataLoop.v_Moddate_old(pac_Goods_DataLoop.g_index) := :old.moddate;                       
--  pac_Goods_DataLoop.v_Moddate_new(pac_Goods_DataLoop.g_index) := :new.moddate;                       
--  pac_Goods_DataLoop.v_Pl_no_old(pac_Goods_DataLoop.g_index) := :old.p_pl_no;                         
--  pac_Goods_DataLoop.v_Pl_no_new(pac_Goods_DataLoop.g_index) := :new.p_pl_no;                         
--  pac_Goods_DataLoop.v_Imgurl_new(pac_Goods_DataLoop.g_index) := :new.p_imgurl;                       
--  pac_Goods_DataLoop.v_Imgurlflag_new(pac_Goods_DataLoop.g_index) := :new.p_imgurlflag;               
--  pac_Goods_DataLoop.v_Rsiflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.rsiflag2, '0');            
--  pac_Goods_DataLoop.v_Rsiflag_new(pac_Goods_DataLoop.g_index) := NVL(:new.rsiflag2, '0');            
--  pac_Goods_DataLoop.v_Refshop_old(pac_Goods_DataLoop.g_index) := NVL(:old.refshop, '0');             
--  pac_Goods_DataLoop.v_Refshop_new(pac_Goods_DataLoop.g_index) := NVL(:new.refshop, '0');             
--  pac_Goods_DataLoop.v_Boxmodelnm_old(pac_Goods_DataLoop.g_index) := NVL(:old.box_modelnm, '');       
--  pac_Goods_DataLoop.v_Boxmodelnm_new(pac_Goods_DataLoop.g_index) := NVL(:new.box_modelnm, '');       
--     pac_Goods_DataLoop.v_Weight_old(pac_Goods_DataLoop.g_index) := :old.weight;                       
--     pac_Goods_DataLoop.v_Weight_new(pac_Goods_DataLoop.g_index) := :new.weight;                       
--     pac_Goods_DataLoop.v_Info_sum_point_old(pac_Goods_DataLoop.g_index) := :old.info_sum_point;       
--     pac_Goods_DataLoop.v_Info_sum_point_new(pac_Goods_DataLoop.g_index) := :new.info_sum_point;       
--     pac_Goods_DataLoop.v_P_pl_no_old(pac_Goods_DataLoop.g_index) := :old.p_pl_no;                     
--     pac_Goods_DataLoop.v_P_pl_no_new(pac_Goods_DataLoop.g_index) := :new.p_pl_no;                     
--     pac_Goods_DataLoop.v_P_imgurl_old(pac_Goods_DataLoop.g_index) := :old.p_imgurl;                   
--     pac_Goods_DataLoop.v_P_imgurl_new(pac_Goods_DataLoop.g_index) := :new.p_imgurl;                   
--     pac_Goods_DataLoop.v_P_imgurlflag_old(pac_Goods_DataLoop.g_index) := :old.p_imgurlflag;           
--     pac_Goods_DataLoop.v_P_imgurlflag_new(pac_Goods_DataLoop.g_index) := :new.p_imgurlflag;           
--     pac_Goods_DataLoop.v_Condiname_old(pac_Goods_DataLoop.g_index) := :old.condiname;                 
--     pac_Goods_DataLoop.v_Condiname_new(pac_Goods_DataLoop.g_index) := :new.condiname;                 
--     pac_Goods_DataLoop.v_Flag_old(pac_Goods_DataLoop.g_index) := :old.flag;                           
--     pac_Goods_DataLoop.v_Flag_new(pac_Goods_DataLoop.g_index) := :new.flag;                           
--     /* 배송비 포함 최저가 nova23 2016.06.21*/                                                         
--     pac_Goods_DataLoop.v_Minprice2_old(pac_Goods_DataLoop.g_index) := NVL(:old.minprice2, 0);         
--  pac_Goods_DataLoop.v_Minprice2_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice2, 0);           
--                                                                                                       
--     pac_Goods_DataLoop.v_Minprice3_old(pac_Goods_DataLoop.g_index) := NVL(:old.minprice3, 0);         
--  pac_Goods_DataLoop.v_Minprice3_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice3, 0);           
--     pac_Goods_DataLoop.v_Minprice4_old(pac_Goods_DataLoop.g_index) := NVL(:old.minprice4, 0);         
--  pac_Goods_DataLoop.v_Minprice4_new(pac_Goods_DataLoop.g_index) := NVL(:new.minprice4, 0);           
--                                                                                                       
--     pac_Goods_DataLoop.v_Bbs_Num_old(pac_Goods_DataLoop.g_index) := NVL(:old.bbs_num, 0);             
--     pac_Goods_DataLoop.v_Bbs_Num_new(pac_Goods_DataLoop.g_index) := NVL(:new.bbs_num, 0);             
--                                                                                                       
--                                                                                                       
-- END;                                                                                                  
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------ 


ALTER TRIGGER "DBENURI"."TR_ROW_UPGOODS" ENABLE