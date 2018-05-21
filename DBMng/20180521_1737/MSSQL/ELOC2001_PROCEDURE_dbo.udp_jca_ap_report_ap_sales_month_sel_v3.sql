/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ap_sales_month_sel_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-22 11:06:27.403
 *        Modify: 2018-05-03 17:23:36.053
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ap_sales_month_sel_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2014.07.22
	-- 설  명 : ap 월별 수수료 리스트
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	select	a.shop_name,
			[1월],[2월], [3월], [4월], [5월], [6월], [7월], [8월], [9월], [10월],[11월],[12월],
			sum_sales, avg_sales
			, a.display_order
	from	( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) a
				inner join
			(
				select	shop_vcode,
						sum(case month(sale_date) when 1 then sales end) as '1월',
						sum(case month(sale_date) when 2 then sales end) as '2월',
						sum(case month(sale_date) when 3 then sales end) as '3월',
						sum(case month(sale_date) when 4 then sales end) as '4월',
						sum(case month(sale_date) when 5 then sales end) as '5월',
						sum(case month(sale_date) when 6 then sales end) as '6월',
						sum(case month(sale_date) when 7 then sales end) as '7월',
						sum(case month(sale_date) when 8 then sales end) as '8월',
						sum(case month(sale_date) when 9 then sales end) as '9월',
						sum(case month(sale_date) when 10 then sales end) as '10월',
						sum(case month(sale_date) when 11 then sales end) as '11월',
						sum(case month(sale_date) when 12 then sales end) as '12월',
						sum(sales) as sum_sales,  avg(sales) avg_sales
				from	tbl_ap_sales_month
				where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		sale_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				and		sale_flag = @sale_flag
				group by shop_vcode

			) b
				on a.shop_vcode = b.shop_vcode
	where	sum_sales is not null
	order by a.display_order, sum_sales desc



