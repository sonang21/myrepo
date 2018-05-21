/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_ROW_UPPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 17:05:11
 *        Modify: 2018-05-11 10:51:08
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_ROW_UPPRICELIST" BEFORE UPDATE ON ASIS_TBL_PRICELIST
FOR EACH ROW
BEGIN

    --DBMS_OUTPUT.ENABLE;
 	--DBMS_OUTPUT.PUT_LINE('start ......' || pac_Pricelist_DataLoop.p_index);

	pac_Pricelist_DataLoop.p_index	:= pac_Pricelist_DataLoop.p_index + 1;
    
	pac_Pricelist_DataLoop.v_Modelno_old(pac_Pricelist_DataLoop.p_index)		:= nvl(:old.modelno, 0);
	pac_Pricelist_DataLoop.v_Modelno_new(pac_Pricelist_DataLoop.p_index)		:= nvl(:new.modelno, 0);
	pac_Pricelist_DataLoop.v_Pl_no_old(pac_Pricelist_DataLoop.p_index)		:= nvl(:old.pl_no, 0);
	pac_Pricelist_DataLoop.v_Pl_no_new(pac_Pricelist_DataLoop.p_index)		:= nvl(:new.pl_no, 0);
	pac_Pricelist_DataLoop.v_Shop_code_old(pac_Pricelist_DataLoop.p_index)		:= nvl(:old.shop_code, 0);
	pac_Pricelist_DataLoop.v_Shop_code_new(pac_Pricelist_DataLoop.p_index)		:= nvl(:new.shop_code, 0);
	pac_Pricelist_DataLoop.v_Price_old(pac_Pricelist_DataLoop.p_index)				:= nvl(:old.price, 0);
	pac_Pricelist_DataLoop.v_Price_new(pac_Pricelist_DataLoop.p_index)				:= nvl(:new.price, 0);
	pac_Pricelist_DataLoop.v_Srvflag_old(pac_Pricelist_DataLoop.p_index)			:= nvl(:old.srvflag, '');
	pac_Pricelist_DataLoop.v_Srvflag_new(pac_Pricelist_DataLoop.p_index)			:= nvl(:new.srvflag, '');
	pac_Pricelist_DataLoop.v_Status_old(pac_Pricelist_DataLoop.p_index)				:= nvl(:old.status, '');
	pac_Pricelist_DataLoop.v_Status_new(pac_Pricelist_DataLoop.p_index)				:= nvl(:new.status, '');
	pac_Pricelist_DataLoop.v_Esstockflag_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.esstockflag, '');
	pac_Pricelist_DataLoop.v_Esstockflag_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.esstockflag, '');
	pac_Pricelist_DataLoop.v_Coupon_old(pac_Pricelist_DataLoop.p_index)				:= nvl(:old.coupon, 0);
	pac_Pricelist_DataLoop.v_Coupon_new(pac_Pricelist_DataLoop.p_index)				:= nvl(:new.coupon, 0);
	pac_Pricelist_DataLoop.v_Jobtype_old(pac_Pricelist_DataLoop.p_index)			:= nvl(:old.jobtype, '');
	pac_Pricelist_DataLoop.v_Jobtype_new(pac_Pricelist_DataLoop.p_index)			:= nvl(:new.jobtype, '');
	pac_Pricelist_DataLoop.v_Instance_price_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.instance_price, 0);
	pac_Pricelist_DataLoop.v_Instance_price_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.instance_price, 0);
	pac_Pricelist_DataLoop.v_Pjobcode_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.pjobcode, '');
	pac_Pricelist_DataLoop.v_Pjobcode_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.pjobcode, '');
	pac_Pricelist_DataLoop.v_Ca_code_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.ca_code, '');
	pac_Pricelist_DataLoop.v_Ca_code_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.ca_code, '');
	pac_Pricelist_DataLoop.v_Goodsnm_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.goodsnm, '');
	pac_Pricelist_DataLoop.v_Goodsnm_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.goodsnm, '');
	pac_Pricelist_DataLoop.v_Url_old(pac_Pricelist_DataLoop.p_index)  := nvl(:old.url, '');
	pac_Pricelist_DataLoop.v_Url_new(pac_Pricelist_DataLoop.p_index)  := nvl(:new.url, '');
	pac_Pricelist_DataLoop.v_Imgurl_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.imgurl, '');
	pac_Pricelist_DataLoop.v_Imgurl_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.imgurl, '');
	pac_Pricelist_DataLoop.v_Imgurlflag_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.imgurlflag, '');
	pac_Pricelist_DataLoop.v_Imgurlflag_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.imgurlflag, '');
	pac_Pricelist_DataLoop.v_U_date_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.u_date, null);
	pac_Pricelist_DataLoop.v_U_date_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.u_date, null);
	pac_Pricelist_DataLoop.v_Searchflag_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.searchflag, '');
	pac_Pricelist_DataLoop.v_Searchflag_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.searchflag, '');
	pac_Pricelist_DataLoop.v_Goodsfactory_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.goodsfactory, '');
	pac_Pricelist_DataLoop.v_Goodsfactory_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.goodsfactory, '');
    
    pac_Pricelist_DataLoop.v_Goodsbrand_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.goodsbrand, '');
	pac_Pricelist_DataLoop.v_Goodsbrand_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.goodsbrand, '');
    
	pac_Pricelist_DataLoop.v_Subside_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.subside, 0);
	pac_Pricelist_DataLoop.v_Subside_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.subside, 0);
	pac_Pricelist_DataLoop.v_Popular_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.popular, 0);
	pac_Pricelist_DataLoop.v_Popular_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.popular, 0);
    
    pac_Pricelist_DataLoop.v_Option_flag2_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.option_flag2, '0');
	pac_Pricelist_DataLoop.v_Option_flag2_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.option_flag2, '0');
    
    pac_Pricelist_DataLoop.v_Price_flag_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.price_flag, '0');
	pac_Pricelist_DataLoop.v_Price_flag_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.price_flag, '0');
    
    pac_Pricelist_DataLoop.v_Store_flag_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.store_flag, '0');
	pac_Pricelist_DataLoop.v_Store_flag_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.store_flag, '0');
    
    pac_Pricelist_DataLoop.v_Ca_code_dept_old(pac_Pricelist_DataLoop.p_index)	:= nvl(:old.ca_code_dept, '');
	pac_Pricelist_DataLoop.v_Ca_code_dept_new(pac_Pricelist_DataLoop.p_index)	:= nvl(:new.ca_code_dept, '');
       
    --DBMS_OUTPUT.PUT_LINE('==222==' || pac_Pricelist_DataLoop.p_index);

END;






ALTER TRIGGER "DBENURI"."ASIS_TRG_ROW_UPPRICELIST" DISABLE