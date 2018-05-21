/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ins_month_sales_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-22 10:50:26.667
 *        Modify: 2018-05-03 17:23:36.043
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_month_sales_v3]
	@shopcode	int,
	@sale_date	datetime,
	@money		money,
	@sale_flag	char(1)
as begin
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2014.07.22
	-- 설  명 : ap 업체 정산 주문액	
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/

	set @sale_date  = EOMONTH(@sale_date)

	-- 디바이스별 데이터 : delete & insert
	delete from tbl_ap_sales_month where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = @sale_flag
	if @money > 0 begin
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		values (@shopcode, @sale_date, @money, @sale_flag)	
	end


	-- 디바이스 통합데이터 : delete & insert
	delete from tbl_ap_sales_month	where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = 'w'
	if @shopcode = 55 and @sale_date < '2015-01-16' begin
		--인팍은 '2015-01-15'일 이전에는 모바일 제휴 안되어 있어 전체에 모바일 제외
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales_month 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p')
		having sum(sales) > 0
	end else begin
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales_month 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p','m')
		having sum(sales) > 0
	end
end

