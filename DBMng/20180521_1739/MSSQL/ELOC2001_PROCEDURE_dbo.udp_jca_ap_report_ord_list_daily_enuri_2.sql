/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 13:34:32.857
 *        Modify: 2018-05-03 17:23:34.247
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_daily_enuri_2]
	@year	smallint
,	@month	smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : ap 일별 주문액 리스트
	-- 실  행 : udp_jca_ap_report_ord_list_daily 2007, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	-- 일별 리스트
	select
			case g.shop_vcode
				when 1733 then 'G마켓(순)'
				when 5893 then '옥션(순)'
				when 1719 then '인터파크(순)'
				when 6052 then '11번가(순)'
				else g.shop_name
			end as shop_name, sum_sales, avg_sales, cast(pre_fee as int),
			day1,day2,day3,day4,day5,
			day6,day7,day8,day9,day10,
			day11,day12,day13,day14,day15,
			day16,day17,day18,day19,day20,
			day21,day22,day23,day24,day25,
			day26,day27,day28,day29,day30,
			day31
	from	shoplist g
				inner join
			(
			select e.*, isnull(f.order_sum_sales,e.sum_sales) as order_sum_sales
			from
			(
				select	shop_vcode
				,		sum(sales) sum_sales
				,		avg(sales) avg_sales
				,		sum(pre_fee) as pre_fee
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
				from
				(
					select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
					(
						select	*
						from	tbl_ap_sales
						where	sale_date >=cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime)
						and		sale_date<dateadd(mm, 1, cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime))
						--and		shop_vcode in(1733,5893,49,47,55,57,75,90,536,663,806,1289,1878,3539,4027,5217,974,5610,5910,6052,1719, 6588)
						and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
					) a
					left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
					left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
				) d
				group by shop_vcode

			) e
				left outer join
			(
				select	case shop_vcode
						when 536 then 1733
						when 4027 then 5893
						when 5910 then 6052
						when 55 then 1719
						end as shop_vcode, sum(sales) order_sum_sales
				from	tbl_ap_sales
				where	sale_date >=cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime)
				and sale_date<dateadd(mm, 1, cast(cast(@year as varchar(4))+'-'+cast(@month as varchar(2))+'-01' as datetime))
				and		shop_vcode in (536, 4027, 55, 5910)
				group by shop_vcode
			) f
				on e.shop_vcode = f.shop_vcode

		) h
			on g.shop_vcode = h.shop_vcode
	order by h.order_sum_sales desc, h.shop_vcode asc

