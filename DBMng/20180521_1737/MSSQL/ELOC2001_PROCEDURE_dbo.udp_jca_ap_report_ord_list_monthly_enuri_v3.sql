/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_monthly_enuri_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 18:12:59.22
 *        Modify: 2018-05-03 17:23:34.843
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_monthly_enuri_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : ap 월별 주문액 리스트
	-- 실  행 : udp_jca_ap_report_monthly_ord_list 2008
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
	select	case b.shop_vcode
					when 1733 then 'G마켓(순)'
					when 5893 then '옥션(순)'
					when 1719 then '인터파크(순)'
					when 6052 then '11번가(순)'
					else a.shop_name
			end as shop_name,
			[1월],[2월], [3월], [4월], [5월], [6월], [7월], [8월], [9월], [10월],[11월],[12월],
			sum_sales, avg_sales
			, a.display_order
	from	( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) a
				inner join
			(
			select c.*, isnull(d.order_sum_sales,c.sum_sales) as order_sum_sales
			from
				(
				select	shop_vcode,
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
					select	shop_vcode, month(sale_date) as sale_month, sum(sales) as sum_sales
					from	tbl_ap_sales
					where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
					and		sale_date <
									case when year(getdate())=@year then
										cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
									else
										dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
									end
					and		shop_vcode not in (4861,3368,724,4859,4856,5137,4857)
					and		sale_flag = @sale_flag
					group by shop_vcode, month(sale_date)
					) e
				group by shop_vcode

				) c
					left outer join
				(
				select
					case shop_vcode
						when 536 then 1733
						when 4027 then 5893
						when 5910 then 6052
						when 55 then 1719
						end as shop_vcode , sum(sales) as order_sum_sales
				from	tbl_ap_sales
				where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		sale_date <
									case when year(getdate())=@year then
										cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
									else
										dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
									end
				and		shop_vcode in (536, 4027, 55, 5910)
				and		sale_flag = @sale_flag
				group by shop_vcode
				) d
					on c.shop_vcode = d.shop_vcode

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)--(a.shop_apflag = '1' or b.shop_vcode in (5893,1733,6052,1719,6508))
	and		sum_sales is not null
	order by a.display_order, b.order_sum_sales desc, b.shop_vcode asc

