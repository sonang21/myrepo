/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_ROW_INPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 17:05:11
 *        Modify: 2018-05-11 10:51:01
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_ROW_INPRICELIST" AFTER  INSERT ON ASIS_TBL_PRICELIST
FOR EACH ROW
--WHEN (new.srvflag = '0' AND new.status < '3')
BEGIN
	pac_Pricelist_Data.v_Modelno_new :=  0;
	pac_Pricelist_Data.v_Pl_no_new :=  0;
	pac_Pricelist_Data.v_Shop_code_new := 0;
	pac_Pricelist_Data.v_Goodsnm_new := '';
	pac_Pricelist_Data.v_Ca_code_new := '';
	pac_Pricelist_Data.v_Pjobcode_new := '';
	pac_Pricelist_Data.v_Jobtype_new := '';
	pac_Pricelist_Data.v_Price_new := 0;
	pac_Pricelist_Data.v_Url_new := '';
	pac_Pricelist_Data.v_Udate_new := null;
	pac_Pricelist_Data.v_Imgurl_new := '';
	pac_Pricelist_Data.v_Imgurlflag_new := '';
	pac_Pricelist_Data.v_Searchflag_new := '';
	pac_Pricelist_Data.v_Goodsfactory_new := '';
    pac_Pricelist_Data.v_Goodsbrand_new := '';
	pac_Pricelist_Data.v_Instance_price_new := 0;
	pac_Pricelist_Data.v_Srvflag_new := '';
	pac_Pricelist_Data.v_Status_new  := '';
	pac_Pricelist_Data.v_Subside_new := 0;
	pac_Pricelist_Data.v_Popular_new := 0;
    pac_Pricelist_Data.v_Ca_code_dept_new  := '';

	pac_Pricelist_Data.v_Modelno_new := :NEW.modelno;
	pac_Pricelist_Data.v_Pl_no_new := :NEW.pl_no;
	pac_Pricelist_Data.v_Shop_code_new := :new.shop_code;
	pac_Pricelist_Data.v_Goodsnm_new := :new.goodsnm;
	pac_Pricelist_Data.v_Ca_code_new := :new.ca_code;
	pac_Pricelist_Data.v_Pjobcode_new := :new.pjobcode;
	pac_Pricelist_Data.v_Jobtype_new := :new.jobtype;
	pac_Pricelist_Data.v_Price_new := :new.price;
	pac_Pricelist_Data.v_Url_new := :new.url;
	pac_Pricelist_Data.v_Udate_new := :new.u_date;
	pac_Pricelist_Data.v_Imgurl_new := :new.imgurl;
	pac_Pricelist_Data.v_Imgurlflag_new := :new.imgurlflag;
	pac_Pricelist_Data.v_Searchflag_new := :new.searchflag;
	pac_Pricelist_Data.v_Goodsfactory_new := :new.goodsfactory;
    pac_Pricelist_Data.v_Goodsbrand_new := :new.goodsbrand;
	pac_Pricelist_Data.v_Instance_price_new := :new.instance_price;
	pac_Pricelist_Data.v_Srvflag_new := :new.srvflag;
	pac_Pricelist_Data.v_Status_new := :new.status;
	pac_Pricelist_Data.v_Subside_new := :new.subside;
	pac_Pricelist_Data.v_Popular_new := :new.popular;
    pac_Pricelist_Data.v_Option_flag2_new := :new.option_flag2;
    pac_Pricelist_Data.v_Price_flag_new := :new.price_flag;
    pac_Pricelist_Data.v_Store_flag_new := :new.store_flag;
    pac_Pricelist_Data.v_Ca_code_dept_new := :new.ca_code_dept;

END;


ALTER TRIGGER "DBENURI"."ASIS_TRG_ROW_INPRICELIST" DISABLE