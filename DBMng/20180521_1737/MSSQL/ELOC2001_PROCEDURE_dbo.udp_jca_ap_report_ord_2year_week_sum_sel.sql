/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_2year_week_sum_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-08-11 21:02:35.867
 *        Modify: 2018-05-03 17:23:35.56
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ord_2year_week_sum_sel
	@sdate datetime
,	@edate datetime
,	@sale_flag char(1)
,	@shop_group char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2014.07.22
	-- 설  명 : ap 주별 주문액 리스트/전년대비(일별)
	-- 실  행 : udp_jca_ap_report_ord_list_daily 2007, 3
	-- ----------------------------------------------------------------------------------
	declare @shop_group_name varchar(10)
	create table #shop(shop_vcode int, shop_ord int)

	insert #shop(shop_vcode)
	select shop_vcode 
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

	update #shop
	set shop_ord = shop_vcode

	if @shop_group = '1' begin
		set @shop_group_name = '오픈마켓'
		delete from #shop where shop_vcode not in (536, 5910, 4027) -- 오픈마켓 = 4개 오픈마켓
	end else if @shop_group = '2' begin
		set @shop_group_name = '종합몰'
		delete from #shop where shop_vcode in (536, 5910, 6641, 6508, 4027, 5893,6052,1719,1733) -- 종합몰 = 4개 오픈마켓 이외 업체
	end else if @shop_group = '3' begin
		set @shop_group_name = '이베이'
		delete from #shop where shop_vcode not in (536, 4027) -- 이베이
	end else if @shop_group = '4' begin
		set @shop_group_name = '소셜'
		delete from #shop where shop_vcode not in (6641, 6508) -- 소셜
	end else begin
		set @shop_group_name = 'AP 합계'
		delete from #shop where shop_vcode in (5893,6052,1719,1733) -- (순) 주문액 삭제
	end


	declare @sdate_this_year datetime
	declare @sdate_last_year datetime
	select @sdate_this_year = @sdate - datepart(dw, @sdate) + 1
	select @sdate_last_year = dateadd(yy, -1, @sdate) - datepart(dw, dateadd(yy, -1, @sdate)) + 1

	declare @edate_this_year datetime
	declare @edate_last_year datetime
	select @edate_this_year = @edate - datepart(dw, @edate) + 7
	select @edate_last_year = (@sdate-1) - datepart(dw, @sdate-1) + 7


	select	shop_vcode, sum(sales) sales, datediff(ww, @sdate_this_year, sale_date)+1 as week_number
	into	#this_year
	from	tbl_ap_sales x 
	where	x.sale_date >=@sdate_this_year
	and		x.sale_date < @edate_this_year+1
	and		sale_flag = @sale_flag
	and		x.shop_vcode in (select shop_vcode from #shop)
	and		sale_date < @edate_this_year
	group by shop_vcode, datediff(ww, @sdate_this_year, sale_date)+1
	having  (datediff(ww, @sdate_this_year, sale_date)+1 ) <= datepart(ww, @edate)	

	select	shop_vcode, sum(sales) sales, datediff(ww, @sdate_last_year, sale_date)+1 as week_number
	into	#last_year
	from	tbl_ap_sales x 
	where	x.sale_date >=@sdate_last_year
	and		x.sale_date < @edate_last_year+1
	and		sale_flag = @sale_flag
	and		x.shop_vcode in (select shop_vcode from #shop)
	group by shop_vcode, datediff(ww, @sdate_last_year, sale_date)+1 
	having  (datediff(ww, @sdate_last_year, sale_date)+1) <= datepart(ww, @edate)	


	select @shop_group_name,a.yyyy,b.sum_sales, '', avg_sales, seq_day1, seq_day2, seq_day3, seq_day4, seq_day5, seq_day6, seq_day7, seq_day8, seq_day9, seq_day10
		, seq_day11, seq_day12, seq_day13, seq_day14, seq_day15, seq_day16, seq_day17, seq_day18, seq_day19, seq_day20, seq_day21, seq_day22, seq_day23, seq_day24
		, seq_day25, seq_day26, seq_day27, seq_day28, seq_day29, seq_day30, seq_day31, seq_day32, seq_day33, seq_day34, seq_day35, seq_day36, seq_day37, seq_day38
		, seq_day39, seq_day40, seq_day41, seq_day42, seq_day43, seq_day44, seq_day45, seq_day46, seq_day47, seq_day48, seq_day49, seq_day50, seq_day51, seq_day52
		, seq_day53
	from 
	(	select number  as yyyy from tbl_number where number in (year(@sdate), year(@sdate)-1, 7777)) a
		left outer join 
	(
		select	yyyy
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
		,		sum(case when number = 32 then sales end) as seq_day32 
		,		sum(case when number = 33 then sales end) as seq_day33 
		,		sum(case when number = 34 then sales end) as seq_day34 
		,		sum(case when number = 35 then sales end) as seq_day35 
		,		sum(case when number = 36 then sales end) as seq_day36 
		,		sum(case when number = 37 then sales end) as seq_day37 
		,		sum(case when number = 38 then sales end) as seq_day38 
		,		sum(case when number = 39 then sales end) as seq_day39 
		,		sum(case when number = 40 then sales end) as seq_day40 
		,		sum(case when number = 41 then sales end) as seq_day41 
		,		sum(case when number = 42 then sales end) as seq_day42 
		,		sum(case when number = 43 then sales end) as seq_day43 
		,		sum(case when number = 44 then sales end) as seq_day44 
		,		sum(case when number = 45 then sales end) as seq_day45 
		,		sum(case when number = 46 then sales end) as seq_day46 
		,		sum(case when number = 47 then sales end) as seq_day47 
		,		sum(case when number = 48 then sales end) as seq_day48 
		,		sum(case when number = 49 then sales end) as seq_day49 
		,		sum(case when number = 50 then sales end) as seq_day50 
		,		sum(case when number = 51 then sales end) as seq_day51 
		,		sum(case when number = 52 then sales end) as seq_day52 
		,		sum(case when number = 53 then sales end) as seq_day53 
		from
		(
				select  sum(sales) sales, number, yyyy
				from
				(
					select sales*result_sign sales, number, y.yyyy
					from
					(
						select	x.*, y.number, year(@sdate) yyyy
						from	#this_year x 
								inner join 
								(
									select number+1 as number from tbl_number where number between 0 and (select datediff(ww, @sdate, @edate))
								)  y
							on x.week_number = y.number
					)  x cross join (select year(@sdate) yyyy, 1 as result_sign union all select 7777, 1 as yyyy) y

					union all

					select sales*result_sign sales, number, y.yyyy
					from 
					(
						select	x.*, y.number--, year(dateadd(ww, -52, @sdate))  yyyy
						from	#last_year x 
								inner join 
								(
									select number+1 as number from tbl_number where number between 0 and (select datediff(ww, @sdate, @edate))
								)  y
							on x.week_number = y.number
					)  x cross join (select year(dateadd(yy, -1, @sdate)) yyyy, 1 as result_sign union all select 7777, -1 as yyyy) y
				) k
				group by  number, yyyy
		) a
		group by yyyy
	) b
	on a.yyyy = b.yyyy
	order by a.yyyy asc




