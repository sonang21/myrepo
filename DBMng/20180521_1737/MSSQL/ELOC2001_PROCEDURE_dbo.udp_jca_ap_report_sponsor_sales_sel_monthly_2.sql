/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sales_sel_monthly_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 15:56:42.403
 *        Modify: 2018-05-03 17:23:34.557
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE proc [dbo].[udp_jca_ap_report_sponsor_sales_sel_monthly_2]
	@year	smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.18
	-- 설  명 : ap 월별 주문액 리스트
	-- 실  행 : udp_jca_ap_report_monthly_ord_list_ad 2008
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	2010.06.04		wookki25		and as_date_month < datepart(mm, getdate())  추가
									현재 진행중인 월의 데이터는 보여주지 않는다.
	*/
	select	shop_name, '매출액' as data_name,
			sum(case sale_month when 1 then sum_sales end) as '1월',
			sum(case sale_month  when 2 then sum_sales end) as '2월',
			sum(case sale_month  when 3 then sum_sales end) as '3월',
			sum(case sale_month  when 4 then sum_sales end) as '4월',
			sum(case sale_month  when 5 then sum_sales end) as '5월',
			sum(case sale_month  when 6 then sum_sales end) as '6월',
			sum(case sale_month when 7 then sum_sales end) as '7월',
			sum(case sale_month when 8 then sum_sales end) as '8월',
			sum(case sale_month when 9 then sum_sales end) as '9월',
			sum(case sale_month when 10 then sum_sales end) as '10월',
			sum(case sale_month when 11 then sum_sales end) as '11월',
			sum(case sale_month when 12 then sum_sales end) as '12월',
			sum(sum_sales) as sum_sales, avg(sum_sales) avg_sales
	from
		(
		select	shop_name, month(sale_date) as sale_month, sum(sales) as sum_sales 
		from	tbl_ap_sales a inner join  shoplist b on a.shop_vcode = b.shop_vcode
		where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
		and		sale_date <
						case when year(getdate())=@year then
							cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
						else
							dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
						end
		and		shop_apflag = '5'
		group by shop_name, month(sale_date)
		) e
	group by shop_name
