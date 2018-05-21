/* *************************************************************************
 * NAME : DBENURI.TR_ROW_UPPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-18 18:33:05
 *        Modify: 2018-05-11 11:22:36
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_UPPRICELIST" BEFORE UPDATE ON TBL_PRICELIST
FOR EACH ROW

BEGIN
        pg_Pricelist_DataLoop.p_index := pg_Pricelist_DataLoop.p_index + 1;
    
        pg_Pricelist_DataLoop.v_Modelno_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.modelno, 0);
        pg_Pricelist_DataLoop.v_Modelno_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.modelno, 0);
        pg_Pricelist_DataLoop.v_Pl_no_old           (pg_Pricelist_DataLoop.p_index) := nvl(:old.pl_no, 0);
        pg_Pricelist_DataLoop.v_Pl_no_new           (pg_Pricelist_DataLoop.p_index) := nvl(:new.pl_no, 0);
        pg_Pricelist_DataLoop.v_Shop_code_old       (pg_Pricelist_DataLoop.p_index) := nvl(:old.shop_code, 0);
        pg_Pricelist_DataLoop.v_Shop_code_new       (pg_Pricelist_DataLoop.p_index) := nvl(:new.shop_code, 0);
        pg_Pricelist_DataLoop.v_Price_old           (pg_Pricelist_DataLoop.p_index) := nvl(:old.price, 0);
        pg_Pricelist_DataLoop.v_Price_new           (pg_Pricelist_DataLoop.p_index) := nvl(:new.price, 0);
        pg_Pricelist_DataLoop.v_Srvflag_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.srvflag, '');
        pg_Pricelist_DataLoop.v_Srvflag_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.srvflag, '');
        pg_Pricelist_DataLoop.v_Status_old          (pg_Pricelist_DataLoop.p_index) := nvl(:old.status, '');
        pg_Pricelist_DataLoop.v_Status_new          (pg_Pricelist_DataLoop.p_index) := nvl(:new.status, '');
        pg_Pricelist_DataLoop.v_Esstockflag_old     (pg_Pricelist_DataLoop.p_index) := nvl(:old.esstockflag, '');
        pg_Pricelist_DataLoop.v_Esstockflag_new     (pg_Pricelist_DataLoop.p_index) := nvl(:new.esstockflag, '');
        pg_Pricelist_DataLoop.v_Coupon_old          (pg_Pricelist_DataLoop.p_index) := nvl(:old.coupon, 0);
        pg_Pricelist_DataLoop.v_Coupon_new          (pg_Pricelist_DataLoop.p_index) := nvl(:new.coupon, 0);
        pg_Pricelist_DataLoop.v_Jobtype_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.jobtype, '');
        pg_Pricelist_DataLoop.v_Jobtype_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.jobtype, '');
        pg_Pricelist_DataLoop.v_Instance_price_old  (pg_Pricelist_DataLoop.p_index) := nvl(:old.instance_price, 0);
        pg_Pricelist_DataLoop.v_Instance_price_new  (pg_Pricelist_DataLoop.p_index) := nvl(:new.instance_price, 0);
-- 0418 pg_Pricelist_DataLoop.v_Pjobcode_old        (pg_Pricelist_DataLoop.p_index) := nvl(:old.pjobcode, '');
-- 0418 pg_Pricelist_DataLoop.v_Pjobcode_new        (pg_Pricelist_DataLoop.p_index) := nvl(:new.pjobcode, '');
        pg_Pricelist_DataLoop.v_Ca_code_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.ca_code, '');
        pg_Pricelist_DataLoop.v_Ca_code_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.ca_code, '');
        pg_Pricelist_DataLoop.v_Goodsnm_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.goodsnm, '');
        pg_Pricelist_DataLoop.v_Goodsnm_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.goodsnm, '');
        pg_Pricelist_DataLoop.v_Url_old             (pg_Pricelist_DataLoop.p_index) := nvl(:old.url, '');
        pg_Pricelist_DataLoop.v_Url_new             (pg_Pricelist_DataLoop.p_index) := nvl(:new.url, '');
        pg_Pricelist_DataLoop.v_Imgurl_old          (pg_Pricelist_DataLoop.p_index) := nvl(:old.imgurl, '');
        pg_Pricelist_DataLoop.v_Imgurl_new          (pg_Pricelist_DataLoop.p_index) := nvl(:new.imgurl, '');
        pg_Pricelist_DataLoop.v_Imgurlflag_old      (pg_Pricelist_DataLoop.p_index) := nvl(:old.imgurlflag, '');
        pg_Pricelist_DataLoop.v_Imgurlflag_new      (pg_Pricelist_DataLoop.p_index) := nvl(:new.imgurlflag, '');
        pg_Pricelist_DataLoop.v_U_date_old          (pg_Pricelist_DataLoop.p_index) := nvl(:old.u_date, null);
        pg_Pricelist_DataLoop.v_U_date_new          (pg_Pricelist_DataLoop.p_index) := nvl(:new.u_date, null);
-- 0418 pg_Pricelist_DataLoop.v_Searchflag_old      (pg_Pricelist_DataLoop.p_index) := nvl(:old.searchflag, '');
-- 0418 pg_Pricelist_DataLoop.v_Searchflag_new      (pg_Pricelist_DataLoop.p_index) := nvl(:new.searchflag, '');
        pg_Pricelist_DataLoop.v_Goodsfactory_old    (pg_Pricelist_DataLoop.p_index) := nvl(:old.goodsfactory, '');
        pg_Pricelist_DataLoop.v_Goodsfactory_new    (pg_Pricelist_DataLoop.p_index) := nvl(:new.goodsfactory, '');
    
-- 0418 pg_Pricelist_DataLoop.v_Goodsbrand_old      (pg_Pricelist_DataLoop.p_index) := nvl(:old.goodsbrand, '');
-- 0418 pg_Pricelist_DataLoop.v_Goodsbrand_new      (pg_Pricelist_DataLoop.p_index) := nvl(:new.goodsbrand, '');
    
-- 0418 pg_Pricelist_DataLoop.v_Subside_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.subside, 0);
-- 0418 pg_Pricelist_DataLoop.v_Subside_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.subside, 0);
        pg_Pricelist_DataLoop.v_Popular_old         (pg_Pricelist_DataLoop.p_index) := nvl(:old.popular, 0);
        pg_Pricelist_DataLoop.v_Popular_new         (pg_Pricelist_DataLoop.p_index) := nvl(:new.popular, 0);
    
        pg_Pricelist_DataLoop.v_Option_flag2_old    (pg_Pricelist_DataLoop.p_index) := nvl(:old.option_flag2, '0');
        pg_Pricelist_DataLoop.v_Option_flag2_new    (pg_Pricelist_DataLoop.p_index) := nvl(:new.option_flag2, '0');
    
        pg_Pricelist_DataLoop.v_Price_flag_old      (pg_Pricelist_DataLoop.p_index) := nvl(:old.price_flag, '0');
        pg_Pricelist_DataLoop.v_Price_flag_new      (pg_Pricelist_DataLoop.p_index) := nvl(:new.price_flag, '0');
    
        pg_Pricelist_DataLoop.v_Store_flag_old      (pg_Pricelist_DataLoop.p_index) := nvl(:old.store_flag, '0');
        pg_Pricelist_DataLoop.v_Store_flag_new      (pg_Pricelist_DataLoop.p_index) := nvl(:new.store_flag, '0');
    
        pg_Pricelist_DataLoop.v_Ca_code_dept_old    (pg_Pricelist_DataLoop.p_index) := nvl(:old.ca_code_dept, '');
        pg_Pricelist_DataLoop.v_Ca_code_dept_new    (pg_Pricelist_DataLoop.p_index) := nvl(:new.ca_code_dept, '');

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      CREATE OR REPLACE TRIGGER                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------------ "DBENURI"."ASIS_TRG_ROW_UPPRICELIST" BEFORE UPDATE ON ASIS_TBL_PRICELIST                                     
-- FOR EACH ROW                                                                                                 
-- BEGIN                                                                                                        
--                                                                                                              
--     --DBMS_OUTPUT.ENABLE;                                                                                    
--    --DBMS_OUTPUT.PUT_LINE('start ......' || pac_Pricelist_DataLoop.p_index);                                  
--                                                                                                              
--  pac_Pricelist_DataLoop.p_index  := pac_Pricelist_DataLoop.p_index + 1;                                     
--                                                                                                              
--  pac_Pricelist_DataLoop.v_Modelno_old(pac_Pricelist_DataLoop.p_index)    := nvl(:old.modelno, 0);           
--  pac_Pricelist_DataLoop.v_Modelno_new(pac_Pricelist_DataLoop.p_index)    := nvl(:new.modelno, 0);           
--  pac_Pricelist_DataLoop.v_Pl_no_old(pac_Pricelist_DataLoop.p_index)    := nvl(:old.pl_no, 0);               
--  pac_Pricelist_DataLoop.v_Pl_no_new(pac_Pricelist_DataLoop.p_index)    := nvl(:new.pl_no, 0);               
--  pac_Pricelist_DataLoop.v_Shop_code_old(pac_Pricelist_DataLoop.p_index)    := nvl(:old.shop_code, 0);       
--  pac_Pricelist_DataLoop.v_Shop_code_new(pac_Pricelist_DataLoop.p_index)    := nvl(:new.shop_code, 0);       
--  pac_Pricelist_DataLoop.v_Price_old(pac_Pricelist_DataLoop.p_index)        := nvl(:old.price, 0);           
--  pac_Pricelist_DataLoop.v_Price_new(pac_Pricelist_DataLoop.p_index)        := nvl(:new.price, 0);           
--  pac_Pricelist_DataLoop.v_Srvflag_old(pac_Pricelist_DataLoop.p_index)      := nvl(:old.srvflag, '');        
--  pac_Pricelist_DataLoop.v_Srvflag_new(pac_Pricelist_DataLoop.p_index)      := nvl(:new.srvflag, '');        
--  pac_Pricelist_DataLoop.v_Status_old(pac_Pricelist_DataLoop.p_index)       := nvl(:old.status, '');         
--  pac_Pricelist_DataLoop.v_Status_new(pac_Pricelist_DataLoop.p_index)       := nvl(:new.status, '');         
--  pac_Pricelist_DataLoop.v_Esstockflag_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.esstockflag, '');    
--  pac_Pricelist_DataLoop.v_Esstockflag_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.esstockflag, '');    
--  pac_Pricelist_DataLoop.v_Coupon_old(pac_Pricelist_DataLoop.p_index)       := nvl(:old.coupon, 0);          
--  pac_Pricelist_DataLoop.v_Coupon_new(pac_Pricelist_DataLoop.p_index)       := nvl(:new.coupon, 0);          
--  pac_Pricelist_DataLoop.v_Jobtype_old(pac_Pricelist_DataLoop.p_index)      := nvl(:old.jobtype, '');        
--  pac_Pricelist_DataLoop.v_Jobtype_new(pac_Pricelist_DataLoop.p_index)      := nvl(:new.jobtype, '');        
--  pac_Pricelist_DataLoop.v_Instance_price_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.instance_price, 0);
--  pac_Pricelist_DataLoop.v_Instance_price_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.instance_price, 0);
--  pac_Pricelist_DataLoop.v_Pjobcode_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.pjobcode, '');           
--  pac_Pricelist_DataLoop.v_Pjobcode_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.pjobcode, '');           
--  pac_Pricelist_DataLoop.v_Ca_code_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.ca_code, '');            
--  pac_Pricelist_DataLoop.v_Ca_code_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.ca_code, '');            
--  pac_Pricelist_DataLoop.v_Goodsnm_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.goodsnm, '');            
--  pac_Pricelist_DataLoop.v_Goodsnm_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.goodsnm, '');            
--  pac_Pricelist_DataLoop.v_Url_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.url, '');                    
--  pac_Pricelist_DataLoop.v_Url_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.url, '');                    
--  pac_Pricelist_DataLoop.v_Imgurl_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.imgurl, '');               
--  pac_Pricelist_DataLoop.v_Imgurl_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.imgurl, '');               
--  pac_Pricelist_DataLoop.v_Imgurlflag_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.imgurlflag, '');       
--  pac_Pricelist_DataLoop.v_Imgurlflag_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.imgurlflag, '');       
--  pac_Pricelist_DataLoop.v_U_date_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.u_date, null);             
--  pac_Pricelist_DataLoop.v_U_date_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.u_date, null);             
--  pac_Pricelist_DataLoop.v_Searchflag_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.searchflag, '');       
--  pac_Pricelist_DataLoop.v_Searchflag_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.searchflag, '');       
--  pac_Pricelist_DataLoop.v_Goodsfactory_old(pac_Pricelist_DataLoop.p_index) := nvl(:old.goodsfactory, '');   
--  pac_Pricelist_DataLoop.v_Goodsfactory_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.goodsfactory, '');   
--                                                                                                              
--     pac_Pricelist_DataLoop.v_Goodsbrand_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.goodsbrand, '');     
--  pac_Pricelist_DataLoop.v_Goodsbrand_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.goodsbrand, '');       
--                                                                                                              
--  pac_Pricelist_DataLoop.v_Subside_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.subside, 0);             
--  pac_Pricelist_DataLoop.v_Subside_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.subside, 0);             
--  pac_Pricelist_DataLoop.v_Popular_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.popular, 0);             
--  pac_Pricelist_DataLoop.v_Popular_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.popular, 0);             
--                                                                                                              
--     pac_Pricelist_DataLoop.v_Option_flag2_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.option_flag2, '0');
--  pac_Pricelist_DataLoop.v_Option_flag2_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.option_flag2, '0');  
--                                                                                                              
--     pac_Pricelist_DataLoop.v_Price_flag_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.price_flag, '0');    
--  pac_Pricelist_DataLoop.v_Price_flag_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.price_flag, '0');      
--                                                                                                              
--     pac_Pricelist_DataLoop.v_Store_flag_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.store_flag, '0');    
--  pac_Pricelist_DataLoop.v_Store_flag_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.store_flag, '0');      
--                                                                                                              
--     pac_Pricelist_DataLoop.v_Ca_code_dept_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.ca_code_dept, ''); 
--  pac_Pricelist_DataLoop.v_Ca_code_dept_new(pac_Pricelist_DataLoop.p_index) := nvl(:new.ca_code_dept, '');   
--                                                                                                              
--     --DBMS_OUTPUT.PUT_LINE('==222==' || pac_Pricelist_DataLoop.p_index);                                     
--                                                                                                              
-- END;                                                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------ 

ALTER TRIGGER "DBENURI"."TR_ROW_UPPRICELIST" ENABLE