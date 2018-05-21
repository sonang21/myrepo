/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_sum_monthly_enuri_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 18:13:53.35
 *        Modify: 2018-05-03 17:23:34.857
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_sum_monthly_enuri_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : AP 월별 주문액 리스트 합계
	-- 실  행 : UDP_JCA_AP_REPORT_MONTHLY_ORD_SUM 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	2010.06.04		wookki25		and AS_DATE_MONTH < datepart(mm, getdate())  추가
									현재 진행중인 월의 데이터는 보여주지 않는다.
	*/
	select	(case when num = 1 then '합계' else '합계(순)' end) as shop_name,
			sum(case sale_month when 1 then sum_sales end) as '1월',
			sum(case sale_month when 2 then sum_sales end) as '2월',
			sum(case sale_month when 3 then sum_sales end) as '3월',
			sum(case sale_month when 4 then sum_sales end) as '4월',
			sum(case sale_month when 5 then sum_sales end) as '5월',
			sum(case sale_month when 6 then sum_sales end) as '6월',
			sum(case sale_month when 7 then sum_sales end) as '7월',
			sum(case sale_month when 8 then sum_sales end) as '8월',
			sum(case sale_month when 9 then sum_sales end) as '9월',
			sum(case sale_month when 10 then sum_sales end) as '10월',
			sum(case sale_month when 11 then sum_sales end) as '11월',
			sum(case sale_month when 12 then sum_sales end) as '12월',
			sum(sum_sales) as sum_sales, avg(sum_sales) avg_sales
	from
	(
		select copy_t.num, sale_month, sum(sum_sales) as sum_sales
		from
		(
			select	shop_name, a.shop_vcode, sale_month, sum_sales
			from	(
						select shop_vcode, month(sale_date) as sale_month, sum(sales) as sum_sales
						from tbl_ap_sales
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
					)a
						inner join
					shoplist b
						on a.shop_vcode = b.shop_vcode
			where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop) --(shop_apflag = '1' or a.shop_vcode in (5893,1733,6052,1719,6508))
		) c
				cross join
		(
			select 1 as num union select 2
		) copy_t
		where	c.shop_vcode not in (
			case when copy_t.num = 1 then 5893 else 4027 end,
			case when copy_t.num = 1 then 1733 else 536 end,
			case when copy_t.num = 1 then 6052 else 5910 end,
			case when copy_t.num = 1 then 1719 else 55 end
		)
		group by copy_t.num, sale_month
		having sum(sum_sales) is not null
	) d
	group by num
	having sum(sum_sales) IS NOT NULL
	order by num
