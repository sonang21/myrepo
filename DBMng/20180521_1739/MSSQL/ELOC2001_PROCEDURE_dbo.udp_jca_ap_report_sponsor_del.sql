/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 10:07:25.363
 *        Modify: 2018-05-03 17:23:35.61
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_jca_ap_report_sponsor_del
	@shopcode int
,	@sale_date smalldatetime
,	@data_opt char(1) = '1'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-08-11
	-- 설  명 : 스폰서링크 노출,클릭 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	delete tbl_ap_sales_sponsor 
	where sale_date = @sale_date and shop_vcode = @shopcode
	and		data_opt = @data_opt



