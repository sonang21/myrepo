/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ebay_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-16 07:50:05.13
 *        Modify: 2018-05-03 17:23:35.383
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ebay_ins
	@shopcode int
,	@sale_date smalldatetime
,	@exp_cnt int
,	@hit_cnt int
,	@sales money
,	@sale_cnt int
,	@data_opt char(1)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-16
	-- 설  명 : 이베이 광고 매출입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	if not exists(select top 1 * 
	from tbl_ap_sales_ebay 
	where shop_vcode=@shopcode and sale_date=@sale_date and data_opt=@data_opt) 
	begin
		-- 입력
		insert into tbl_ap_sales_ebay(shop_vcode, sale_date, exp_cnt, hit_cnt, data_opt, sales ,sale_cnt)
		values (@shopcode, @sale_date, @exp_cnt, @hit_cnt, @data_opt, @sales, @sale_cnt)
	end else begin
		-- 업데이트
		update	tbl_ap_sales_ebay
		set		exp_cnt = case when sign(@exp_cnt) = -1 then exp_cnt else @exp_cnt end
		,		hit_cnt = case when sign(@hit_cnt) = -1 then hit_cnt else @hit_cnt end
		,		sales = case when sign(@sales) = -1 then sales else @sales end
		,		sale_cnt = case when sign(@sale_cnt) = -1 then sale_cnt else @sale_cnt end
		where	shop_vcode = @shopcode and
				sale_date = @sale_date
		and		data_opt = @data_opt
	end
