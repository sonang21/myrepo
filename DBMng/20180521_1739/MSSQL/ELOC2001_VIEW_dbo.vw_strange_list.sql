/* *************************************************************************
 * NAME : dbo.vw_strange_list
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2017-08-21 10:28:48.343
 *        Modify: 2018-05-02 15:22:19.553
 *        Backup: 20180521_1739
 ************************************************************************* */

create view [dbo].[vw_strange_list]
--with schemabinding
as 
	select  sl_no, sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo
	, sl_factory, sl_freeinterest, sl_date, sl_goodscode, sl_category, sl_modelno, sl_srvflag, p_status, p_date
	, mm_id, assign_mm_id, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile 
	from tbl_strange_list_bak_20170821
	
	union all

	select  sl_no, sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo
	, sl_factory, sl_freeinterest, sl_date, sl_goodscode, sl_category, sl_modelno, sl_srvflag, p_status, p_date
	, mm_id, assign_mm_id, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile 
	from tbl_strange_list