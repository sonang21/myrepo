/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ebay_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-16 07:50:51.093
 *        Modify: 2018-05-03 17:23:35.4
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_jca_ap_report_ebay_del
	@shopcode int
,	@sale_date smalldatetime
,	@data_opt char(1) = '1'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-16
	-- 설  명 : 이베이 노출,클릭 조회
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	delete tbl_ap_sales_ebay 
	where sale_date = @sale_date and shop_vcode = @shopcode
	and		data_opt = @data_opt
