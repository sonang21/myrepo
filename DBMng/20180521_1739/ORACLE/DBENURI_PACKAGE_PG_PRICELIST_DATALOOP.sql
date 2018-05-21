/* *************************************************************************
 * NAME : DBENURI.PG_PRICELIST_DATALOOP
 * TYPE : PACKAGE
 * TIME : Create: 2018-04-18 18:24:35
 *        Modify: 2018-05-11 10:58:31
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBENURI"."PG_PRICELIST_DATALOOP" AS

       TYPE p_modelno_type        is table of TBL_PRICELIST.MODELNO         %TYPE index by binary_integer;
       TYPE p_plno_type           is table of TBL_PRICELIST.PL_NO           %TYPE index by binary_integer;
       TYPE p_shopcode_type       is table of TBL_PRICELIST.SHOP_CODE       %TYPE index by binary_integer;
       TYPE p_price_type          is table of TBL_PRICELIST.PRICE           %TYPE index by binary_integer;
       TYPE p_srvflag_type        is table of TBL_PRICELIST.SRVFLAG         %TYPE index by binary_integer;
       TYPE p_status_type         is table of TBL_PRICELIST.STATUS          %TYPE index by binary_integer;
       TYPE p_esstockflag_type    is table of TBL_PRICELIST.ESSTOCKFLAG     %TYPE index by binary_integer;
       TYPE p_coupon_type         is table of TBL_PRICELIST.COUPON          %TYPE index by binary_integer;
       TYPE p_jobtype_type        is table of TBL_PRICELIST.JOBTYPE         %TYPE index by binary_integer;
       TYPE p_instance_type       is table of TBL_PRICELIST.INSTANCE_PRICE  %TYPE index by binary_integer;
--0418 TYPE p_pjobcode_type       is table of TBL_PRICELIST.PJOBCODE        %TYPE index by binary_integer;
       TYPE p_ca_code_type        is table of TBL_PRICELIST.CA_CODE         %TYPE index by binary_integer;
       TYPE p_goodsnm_type        is table of TBL_PRICELIST.GOODSNM         %TYPE index by binary_integer;
       TYPE p_url_type            is table of TBL_PRICELIST.URL             %TYPE index by binary_integer;
       TYPE p_imgurl_type         is table of TBL_PRICELIST.IMGURL          %TYPE index by binary_integer;
       TYPE p_imgurlflag_type     is table of TBL_PRICELIST.IMGURLFLAG      %TYPE index by binary_integer;
       TYPE p_u_date_type         is table of TBL_PRICELIST.U_DATE          %TYPE index by binary_integer;
--0418 TYPE p_searchflag_type     is table of TBL_PRICELIST.SEARCHFLAG      %TYPE index by binary_integer;
       TYPE p_goodsfactory_type   is table of TBL_PRICELIST.GOODSFACTORY    %TYPE index by binary_integer;
--0418 TYPE p_goodsbrand_type     is table of TBL_PRICELIST.GOODSBRAND      %TYPE index by binary_integer;    
--0418 TYPE p_subside_type        is table of TBL_PRICELIST.SUBSIDE         %TYPE index by binary_integer;
       TYPE p_popular_type        is table of TBL_PRICELIST.POPULAR         %TYPE index by binary_integer;
       TYPE p_option_flag2_type   is table of TBL_PRICELIST.OPTION_FLAG2    %TYPE index by binary_integer;
       TYPE p_price_flag_type     is table of TBL_PRICELIST.PRICE_FLAG      %TYPE index by binary_integer;
       TYPE p_store_flag_type     is table of TBL_PRICELIST.STORE_FLAG      %TYPE index by binary_integer;
       TYPE p_ca_code_dept_type   is table of TBL_PRICELIST.CA_CODE_DEPT    %TYPE index by binary_integer;
    

       v_Modelno_old           p_modelno_type;
       v_Modelno_new           p_modelno_type;
       v_Pl_no_old             p_plno_type;
       v_Pl_no_new             p_plno_type;
       v_Shop_code_old         p_shopcode_type;
       v_Shop_code_new         p_shopcode_type;
       v_Price_old             p_price_type;
       v_Price_new             p_price_type;
       v_Srvflag_old           p_srvflag_type;
       v_Srvflag_new           p_srvflag_type;
       v_Status_old            p_status_type;
       v_Status_new            p_status_type;
       v_Esstockflag_old       p_esstockflag_type;
       v_Esstockflag_new       p_esstockflag_type;
       v_Coupon_old            p_coupon_type;
       v_Coupon_new            p_coupon_type;
       v_Jobtype_old           p_jobtype_type;
       v_Jobtype_new           p_jobtype_type;
       v_Instance_price_old    p_instance_type;
       v_Instance_price_new    p_instance_type;
--0418 v_Pjobcode_old          p_pjobcode_type;
--0418 v_Pjobcode_new          p_pjobcode_type;
       v_Ca_code_old           p_ca_code_type;
       v_Ca_code_new           p_ca_code_type;
       v_Goodsnm_old           p_goodsnm_type;
       v_Goodsnm_new           p_goodsnm_type;
       v_Url_old               p_url_type;
       v_Url_new               p_url_type;
       v_Imgurl_old            p_imgurl_type;
       v_Imgurl_new            p_imgurl_type;
       v_Imgurlflag_old        p_imgurlflag_type;
       v_Imgurlflag_new        p_imgurlflag_type;
       v_U_date_old            p_u_date_type;
       v_U_date_new            p_u_date_type;
--0418 v_Searchflag_old        p_searchflag_type;
--0418 v_Searchflag_new        p_searchflag_type;
       v_Goodsfactory_old      p_goodsfactory_type;
       v_Goodsfactory_new      p_goodsfactory_type;
--0418 v_Goodsbrand_old        p_goodsbrand_type;
--0418 v_Goodsbrand_new        p_goodsbrand_type;    
--0418 v_Subside_old           p_subside_type;
--0418 v_Subside_new           p_subside_type;
       v_Popular_old           p_popular_type;
       v_Popular_new           p_popular_type;
       v_Option_flag2_old      p_option_flag2_type;
       v_Option_flag2_new      p_option_flag2_type;    
       v_Price_flag_old        p_price_flag_type;
       v_Price_flag_new        p_price_flag_type;
       v_Store_flag_old        p_store_flag_type;
       v_Store_flag_new        p_store_flag_type;
    
       v_Ca_code_dept_old      p_ca_code_dept_type;
       v_Ca_code_dept_new      p_ca_code_dept_type;

       p_index                 NUMBER(8) := 0;  --BINARY_INTEGER;

END pg_Pricelist_DataLoop;


------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE PACKAGE "PAC_PRICELIST_DATALOOP" AS                   
--                                                                         
--  TYPE p_modelno_type is table of TBL_PRICELIST.MODELNO%TYPE            
--  index by binary_integer;                                              
--  TYPE p_plno_type is table of TBL_PRICELIST.PL_NO%TYPE                 
--  index by binary_integer;                                              
--  TYPE p_shopcode_type is table of TBL_PRICELIST.SHOP_CODE%TYPE         
--  index by binary_integer;                                              
--  TYPE p_price_type is table of TBL_PRICELIST.PRICE%TYPE                
--  index by binary_integer;                                              
--  TYPE p_srvflag_type is table of TBL_PRICELIST.SRVFLAG%TYPE            
--  index by binary_integer;                                              
--  TYPE p_status_type is table of TBL_PRICELIST.STATUS%TYPE              
--  index by binary_integer;                                              
--  TYPE p_esstockflag_type is table of TBL_PRICELIST.ESSTOCKFLAG%TYPE    
--  index by binary_integer;                                              
--  TYPE p_coupon_type is table of TBL_PRICELIST.COUPON%TYPE              
--  index by binary_integer;                                              
--  TYPE p_jobtype_type is table of TBL_PRICELIST.JOBTYPE%TYPE            
--  index by binary_integer;                                              
--  TYPE p_instance_type is table of TBL_PRICELIST.INSTANCE_PRICE%TYPE    
--  index by binary_integer;                                              
--  TYPE p_pjobcode_type is table of TBL_PRICELIST.PJOBCODE%TYPE          
--  index by binary_integer;                                              
--  TYPE p_ca_code_type is table of TBL_PRICELIST.CA_CODE%TYPE            
--  index by binary_integer;                                              
--  TYPE p_goodsnm_type is table of TBL_PRICELIST.GOODSNM%TYPE            
--  index by binary_integer;                                              
--  TYPE p_url_type is table of TBL_PRICELIST.URL%TYPE                    
--  index by binary_integer;                                              
--  TYPE p_imgurl_type is table of TBL_PRICELIST.IMGURL%TYPE              
--  index by binary_integer;                                              
--  TYPE p_imgurlflag_type is table of TBL_PRICELIST.IMGURLFLAG%TYPE      
--  index by binary_integer;                                              
--  TYPE p_u_date_type is table of TBL_PRICELIST.U_DATE%TYPE              
--  index by binary_integer;                                              
--  TYPE p_searchflag_type is table of TBL_PRICELIST.SEARCHFLAG%TYPE      
--  index by binary_integer;                                              
--  TYPE p_goodsfactory_type is table of TBL_PRICELIST.GOODSFACTORY%TYPE  
--  index by binary_integer;                                              
--  TYPE p_goodsbrand_type is table of TBL_PRICELIST.GOODSBRAND%TYPE      
--  index by binary_integer;                                              
--  TYPE p_subside_type is table of TBL_PRICELIST.SUBSIDE%TYPE            
--  index by binary_integer;                                              
--     TYPE p_popular_type is table of TBL_PRICELIST.POPULAR%TYPE          
--  index by binary_integer;                                              
--     TYPE p_option_flag2_type is table of TBL_PRICELIST.OPTION_FLAG2%TYPE
--  index by binary_integer;                                              
--     TYPE p_price_flag_type is table of TBL_PRICELIST.PRICE_FLAG%TYPE    
--  index by binary_integer;                                              
--     TYPE p_store_flag_type is table of TBL_PRICELIST.STORE_FLAG%TYPE    
--  index by binary_integer;                                              
--     TYPE p_ca_code_dept_type is table of TBL_PRICELIST.CA_CODE_DEPT%TYPE
--  index by binary_integer;                                              
--                                                                         
--                                                                         
--  v_Modelno_old           p_modelno_type;                               
--  v_Modelno_new           p_modelno_type;                               
--  v_Pl_no_old             p_plno_type;                                  
--  v_Pl_no_new             p_plno_type;                                  
--  v_Shop_code_old       p_shopcode_type;                                
--  v_Shop_code_new       p_shopcode_type;                                
--  v_Price_old       p_price_type;                                       
--  v_Price_new       p_price_type;                                       
--  v_Srvflag_old     p_srvflag_type;                                     
--  v_Srvflag_new     p_srvflag_type;                                     
--  v_Status_old      p_status_type;                                      
--  v_Status_new      p_status_type;                                      
--  v_Esstockflag_old     p_esstockflag_type;                             
--  v_Esstockflag_new     p_esstockflag_type;                             
--  v_Coupon_old      p_coupon_type;                                      
--  v_Coupon_new      p_coupon_type;                                      
--  v_Jobtype_old     p_jobtype_type;                                     
--  v_Jobtype_new     p_jobtype_type;                                     
--  v_Instance_price_old  p_instance_type;                                
--  v_Instance_price_new  p_instance_type;                                
--  v_Pjobcode_old          p_pjobcode_type;                              
--  v_Pjobcode_new          p_pjobcode_type;                              
--  v_Ca_code_old           p_ca_code_type;                               
--  v_Ca_code_new           p_ca_code_type;                               
--  v_Goodsnm_old           p_goodsnm_type;                               
--  v_Goodsnm_new           p_goodsnm_type;                               
--  v_Url_old               p_url_type;                                   
--  v_Url_new               p_url_type;                                   
--  v_Imgurl_old            p_imgurl_type;                                
--  v_Imgurl_new            p_imgurl_type;                                
--  v_Imgurlflag_old        p_imgurlflag_type;                            
--  v_Imgurlflag_new        p_imgurlflag_type;                            
--  v_U_date_old            p_u_date_type;                                
--  v_U_date_new            p_u_date_type;                                
--  v_Searchflag_old        p_searchflag_type;                            
--  v_Searchflag_new        p_searchflag_type;                            
--  v_Goodsfactory_old      p_goodsfactory_type;                          
--  v_Goodsfactory_new      p_goodsfactory_type;                          
--  v_Goodsbrand_old        p_goodsbrand_type;                            
--  v_Goodsbrand_new        p_goodsbrand_type;                            
--  v_Subside_old           p_subside_type;                               
--  v_Subside_new           p_subside_type;                               
--  v_Popular_old           p_popular_type;                               
--  v_Popular_new           p_popular_type;                               
--     v_Option_flag2_old      p_option_flag2_type;                        
--     v_Option_flag2_new      p_option_flag2_type;                        
--     v_Price_flag_old        p_price_flag_type;                          
--     v_Price_flag_new        p_price_flag_type;                          
--     v_Store_flag_old        p_store_flag_type;                          
--     v_Store_flag_new        p_store_flag_type;                          
--                                                                         
--     v_Ca_code_dept_old  p_ca_code_dept_type;                            
--     v_Ca_code_dept_new  p_ca_code_dept_type;                            
--                                                                         
--                                                                         
--  p_index   NUMBER(8) := 0;  --BINARY_INTEGER;                          
--                                                                         
-- END pac_Pricelist_DataLoop;                                             
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업                                                                                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------ 

