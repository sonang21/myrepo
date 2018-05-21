/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_2year_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-22 17:07:00.137
 *        Modify: 2018-05-03 17:23:36.123
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ord_2year_sel
	@sdate datetime
,	@edate datetime
,	@sale_flag char(1)
,	@shop_group int
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2014.07.22
	-- 설  명 : ap 일별 주문액 리스트/전년대비(일별)
	-- 실  행 : udp_jca_ap_report_ord_list_daily 2007, 3
	-- ----------------------------------------------------------------------------------
	select shop_vcode 
	into #shop
	from  (
		select distinct shop_vcode 
		from	tbl_ap_sales
		where	sale_date >=dateadd(yy, -1, @sdate)
		and		sale_date < dateadd(yy, -1, @edate)+1
		union 
		select distinct shop_vcode 
		from	tbl_ap_sales
		where	sale_date >=@sdate
		and		sale_date < @edate+1
	) shop




	if @shop_group = 1 begin
		delete from #shop where shop_vcode not in (536, 5910, 4027, 6641, 6508) -- 오픈마켓 = 4개 오픈마켓
	end else if @shop_group = 2 begin
		delete from #shop where shop_vcode in (536, 5910, 4027, 5893, 6052, 1719, 1733, 6641, 6508) -- 종합몰 = 4개 오픈마켓 이외 업체
	end else if @shop_group = 3 begin
		delete from #shop where shop_vcode in (5893,6052,1719,1733) -- (순) 주문액 삭제
	end


	select c.shop_name, a.yyyy,b.sum_sales, '', avg_sales, seq_day1, seq_day2, seq_day3, seq_day4, seq_day5, seq_day6, seq_day7, seq_day8, seq_day9, seq_day10
		, seq_day11, seq_day12, seq_day13, seq_day14, seq_day15, seq_day16, seq_day17, seq_day18, seq_day19, seq_day20, seq_day21, seq_day22, seq_day23, seq_day24
		, seq_day25, seq_day26, seq_day27, seq_day28, seq_day29, seq_day30, seq_day31
		, display_order
	from 
	(	select shop_vcode, yyyy from #shop cross join (select number  as yyyy from tbl_number where number in (year(@sdate), year(@sdate)-1, 7777)) k	) a
		left outer join 
	(
		select	shop_vcode,  yyyy
		,		sum(sales) sum_sales
		,		avg(sales) avg_sales
		,		sum(case when number = 1 then sales end) as seq_day1
		,		sum(case when number = 2 then sales end) as seq_day2
		,		sum(case when number = 3 then sales end) as seq_day3
		,		sum(case when number = 4 then sales end) as seq_day4
		,		sum(case when number = 5 then sales end) as seq_day5
		,		sum(case when number = 6 then sales end) as seq_day6
		,		sum(case when number = 7 then sales end) as seq_day7
		,		sum(case when number = 8 then sales end) as seq_day8
		,		sum(case when number = 9 then sales end) as seq_day9
		,		sum(case when number = 10 then sales end) as seq_day10
		,		sum(case when number = 11 then sales end) as seq_day11
		,		sum(case when number = 12 then sales end) as seq_day12
		,		sum(case when number = 13 then sales end) as seq_day13
		,		sum(case when number = 14 then sales end) as seq_day14
		,		sum(case when number = 15 then sales end) as seq_day15
		,		sum(case when number = 16 then sales end) as seq_day16
		,		sum(case when number = 17 then sales end) as seq_day17
		,		sum(case when number = 18 then sales end) as seq_day18
		,		sum(case when number = 19 then sales end) as seq_day19
		,		sum(case when number = 20 then sales end) as seq_day20
		,		sum(case when number = 21 then sales end) as seq_day21
		,		sum(case when number = 22 then sales end) as seq_day22
		,		sum(case when number = 23 then sales end) as seq_day23
		,		sum(case when number = 24 then sales end) as seq_day24
		,		sum(case when number = 25 then sales end) as seq_day25
		,		sum(case when number = 26 then sales end) as seq_day26
		,		sum(case when number = 27 then sales end) as seq_day27
		,		sum(case when number = 28 then sales end) as seq_day28
		,		sum(case when number = 29 then sales end) as seq_day29
		,		sum(case when number = 30 then sales end) as seq_day30
		,		sum(case when number = 31 then sales end) as seq_day31
		from
		(

			select shop_vcode, sum(sales) sales, number, yyyy
			from 
			(
				select shop_vcode, sales*result_sign sales, number, y.yyyy
				from
				(
					select	x.*, y.number, year(@sdate) yyyy
					from	tbl_ap_sales x 
							inner join 
							(
								select number+1 as number, @sdate+number as sale_date  from tbl_number where number between 0 and (select datediff(d, @sdate, @edate))
							)  y
						on x.sale_date = y.sale_date
					where	x.sale_date >=@sdate
					and		x.sale_date < @edate+1
					and		sale_flag = @sale_flag
					and		x.shop_vcode in (select shop_vcode from #shop)
				)  x cross join (select year(@sdate) yyyy, 1 as result_sign union all select 7777, 1 as yyyy) y

				union all

				select shop_vcode, sales*result_sign sales, number, y.yyyy
				from 
				(
					select	x.*, y.number--, year(dateadd(ww, -52, @sdate))  yyyy
					from	tbl_ap_sales x 
							inner join 
							(
								select number+1 as number, dateadd(ww, -52, @sdate)+number as sale_date  from tbl_number where number between 0 and (select datediff(d, dateadd(ww, -52, @sdate), dateadd(ww, -52, @edate)))
							)  y
						on x.sale_date = y.sale_date
					where	x.sale_date >=dateadd(ww, -52, @sdate)
					and		x.sale_date < dateadd(ww, -52, @edate)+1
					and		sale_flag = @sale_flag
					and		x.shop_vcode in (select shop_vcode from #shop)
				)  x cross join (select year(dateadd(ww, -52, @sdate)) yyyy, 1 as result_sign union all select 7777, -1 as yyyy) y
			) k
			group by shop_vcode, yyyy, number
		) a
		group by shop_vcode, yyyy
	) b on a.shop_vcode = b.shop_vcode and a.yyyy = b.yyyy
	left outer join ( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) c 
	on a.shop_vcode = c.shop_vcode
	order by 
		c.display_order,
		case a.shop_vcode 
			when 536 then 1 	
			when 4027 then 2
			when 5910 then 3
			when 6508 then 4
			when 6641 then 5
			when 55 then 6
			else
			a.shop_vcode
		end 
	,	a.yyyy asc

