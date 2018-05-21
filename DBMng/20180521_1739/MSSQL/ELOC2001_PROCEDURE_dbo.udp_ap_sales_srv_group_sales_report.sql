/* *************************************************************************
 * NAME : dbo.udp_ap_sales_srv_group_sales_report
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-12-01 13:39:06.84
 *        Modify: 2018-05-03 17:23:35.603
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_ap_sales_srv_group_sales_report
	@sdate date
,	@edate date
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.11.30
	-- 설  명 : 경영진.메일링.서비스 그룹 리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	
	*/

	-- select * from tbl_ap_sales_srv_group_code -- 코드명

	select b.report_wk, a.group_name, b.sum_sales, b.sum_cost, isnull(b.sum_sales,0) - isnull(b.sum_cost,0) as profit
	from tbl_ap_sales_srv_group_code a
		left outer join 
		(
			-- 99는 합계
			select isnull(group_code, 99) group_code, (case when group_code is null then 99 else report_wk end) report_wk, sum(sales) sum_sales, sum(cost) sum_cost
			from
			(
				-- 서비스별 매출 : select * from tbl_ap_sales_srv_group_code
				select	group_code, datepart(wk, sale_date) report_wk, sales, 0 cost
				from	tbl_ap_sales_srv_group b
				where	sale_date between @sdate and @edate
				and		group_code not in (1, 99) -- 코어, 합계 제외

				
				-- 에누리 코어
				union all
				select	1 group_code, datepart(wk, sale_date) report_wk, (sales * -1), 0 cost
				from	tbl_ap_sales_srv_group b
				where	sale_date between @sdate and @edate
				and		group_code in (3, 6) -- 백화점, 홈쇼핑 제외 : 서비스별 매출에 이미 포함되어 있음
				union all
				select  1 group_code, datepart(wk, sale_date) report_wk, sales, 0 cost
				from	tbl_ap_sales
				where	sale_date between @sdate and @edate
				and shop_vcode not in (6508, 6641) -- 위메프, 티몬 제외 : 서비스별 매출에 이미 포함되어 있음
				and shop_vcode not in (5893,1733,1719,6052) -- (순) 주문 제외
				and sale_flag = 'w' -- 전체주문
				

 				-- 원가
				union all
				select group_code, datepart(wk, cost_date) report_wk, 0 sales, day_cost
				from
				(
					select dateadd(d, number, @sdate) cost_date, convert(char(6), dateadd(d, number, @sdate), 112) cost_yyyymm
					from tbl_number
					where number between 0 and datediff(d, @sdate, @edate)
				) a inner join tbl_ap_sales_srv_group_cost b on a.cost_yyyymm = b.cost_yyyymm

			) tbl_union
			group by group_code, report_wk		
			with rollup
		) b
			on a.group_code = b.group_code
		where report_wk is not null
		order by b.report_wk, a.group_code
