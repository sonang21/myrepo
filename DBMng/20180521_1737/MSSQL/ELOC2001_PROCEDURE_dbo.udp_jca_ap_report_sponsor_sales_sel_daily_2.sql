/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sales_sel_daily_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 15:47:09.79
 *        Modify: 2018-05-03 17:23:34.513
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_sponsor_sales_sel_daily_2]
	@year	smallint
,	@month	smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.18
	-- 설  명 : ap 일별 주문액 리스트
	-- 실  행 : udp_jca_ap_report_ord_list_daily_ad 2007, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	-- 일별 리스트
	select	shop_name, '매출액' as data_name
	,		sum(case when day(sale_date) = 1 then sales end) as day1
	,		sum(case when day(sale_date) = 2 then sales end) as day2
	,		sum(case when day(sale_date) = 3 then sales end) as day3
	,		sum(case when day(sale_date) = 4 then sales end) as day4
	,		sum(case when day(sale_date) = 5 then sales end) as day5
	,		sum(case when day(sale_date) = 6 then sales end) as day6
	,		sum(case when day(sale_date) = 7 then sales end) as day7
	,		sum(case when day(sale_date) = 8 then sales end) as day8
	,		sum(case when day(sale_date) = 9 then sales end) as day9
	,		sum(case when day(sale_date) = 10 then sales end) as day10
	,		sum(case when day(sale_date) = 11 then sales end) as day11
	,		sum(case when day(sale_date) = 12 then sales end) as day12
	,		sum(case when day(sale_date) = 13 then sales end) as day13
	,		sum(case when day(sale_date) = 14 then sales end) as day14
	,		sum(case when day(sale_date) = 15 then sales end) as day15
	,		sum(case when day(sale_date) = 16 then sales end) as day16
	,		sum(case when day(sale_date) = 17 then sales end) as day17
	,		sum(case when day(sale_date) = 18 then sales end) as day18
	,		sum(case when day(sale_date) = 19 then sales end) as day19
	,		sum(case when day(sale_date) = 20 then sales end) as day20
	,		sum(case when day(sale_date) = 21 then sales end) as day21
	,		sum(case when day(sale_date) = 22 then sales end) as day22
	,		sum(case when day(sale_date) = 23 then sales end) as day23
	,		sum(case when day(sale_date) = 24 then sales end) as day24
	,		sum(case when day(sale_date) = 25 then sales end) as day25
	,		sum(case when day(sale_date) = 26 then sales end) as day26
	,		sum(case when day(sale_date) = 27 then sales end) as day27
	,		sum(case when day(sale_date) = 28 then sales end) as day28
	,		sum(case when day(sale_date) = 29 then sales end) as day29
	,		sum(case when day(sale_date) = 30 then sales end) as day30
	,		sum(case when day(sale_date) = 31 then sales end) as day31
	,		sum(sales) sum_sales
	,		avg(sales) avg_sales
	from
	(
		select	a.*, b.shop_name
		from	tbl_ap_sales a inner join  shoplist b on a.shop_vcode = b.shop_vcode
		where	sale_date >=cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime)
		and		sale_date<dateadd(mm, 1, cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime))
		and		shop_apflag = '5'
	) d
	group by shop_name
	order by sum(sales)
