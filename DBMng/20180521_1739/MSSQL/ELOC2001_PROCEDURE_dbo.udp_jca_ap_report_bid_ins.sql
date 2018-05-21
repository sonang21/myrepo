/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_bid_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-21 09:57:51.34
 *        Modify: 2018-05-03 17:23:35.873
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_jca_ap_report_bid_ins
	@sale_date smalldatetime
,	@exp_cnt int
,	@hit_cnt int
,	@sales money
,	@sale_cnt int
,	@data_opt char(1)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-21
	-- 설  명 : 상위입찰 매출입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	if not exists(select top 1 * 
	from tbl_ap_sales_bid 
	where sale_date=@sale_date and data_opt=@data_opt) 
	begin
		-- 입력
		insert into tbl_ap_sales_bid( sale_date, exp_cnt, hit_cnt, data_opt, sales ,sale_cnt)
		values (@sale_date, @exp_cnt, @hit_cnt, @data_opt, @sales, @sale_cnt)
	end else begin
		-- 업데이트
		update	tbl_ap_sales_bid
		set		exp_cnt = @exp_cnt
		,		hit_cnt = @hit_cnt
		,		sales = @sales
		,		sale_cnt = @sale_cnt
		where	sale_date = @sale_date
		and		data_opt = @data_opt
	end
