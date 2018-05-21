/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI_3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-12 14:09:16.92
 *        Modify: 2018-05-03 17:23:36.03
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI_3]
	@sdate datetime
,	@edate datetime
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : AP 일별 주문액 리스트 합계
	-- 실  행 : UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI 2008, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
		-- 지마켓 예외처리 2012.05.17 정재웅
	/*
	정산 기간이 전월 26일 ~ 당월 25일 이라서.
	정산 기간의 예상수수료로 계산.
	*/
	-- gshop(75), cjmall(806) 예외처리 2012.07.10
	declare @sdate_ex datetime
	declare @edate_ex datetime
	set @sdate_ex = dateadd(d, 25, dateadd(m, -1, @sdate)) -- 전월 26일
	set @edate_ex = dateadd(d, 24, @sdate) -- 당월 25일

	-- 예상합계
	declare @max_date datetime
	select @max_date = max(sale_date) from tbl_ap_sales where sale_date>=@sdate and sale_date < dateadd(m, 1, @sdate)


	-- 수수료 예외처리
	create table #ex_gmarket_pre_fee (shop_vcode int, fee money)
	if day(@sdate_ex) = 26 and day(@edate_ex) = 25 begin
		insert into #ex_gmarket_pre_fee
		select	shop_vcode, cast(pre_fee-sliding_exclude_pre_fee as int) as fee
		from	(

					select e.*,
					case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
					from
					(
						select	shop_vcode, sum(sales) sum_sales, sum(pre_fee) as pre_fee
						from
						(
							select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
							(
								select	x.*
								from	tbl_ap_sales x
								where	x.sale_date >=@sdate_ex
								and		x.sale_date < @edate_ex+1
								and		shop_vcode in(75, 806)
							) a
							left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
							left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
						) d
						group by shop_vcode
					) e
						left outer join
					(
						select shop_vcode, sum_limit, rate 
						from tbl_ap_sales_fee_rate_sliding 
						where @sdate_ex between s_date and  e_date
					) i
						on e.shop_vcode = i.shop_vcode
				) h

		-- 지마켓 예외처리
		if @sdate = cast('2013-02-01' as datetime) begin
			-- 지마켓 예상수수료 고정.. 전월 26일 ~ 당월 말일까지의 수수료로 처리 ==> 보류
			insert into #ex_gmarket_pre_fee
			select	shop_vcode, cast(pre_fee-sliding_exclude_pre_fee as int) as fee
			from	(

						select e.*,
						case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
						from
						(
							select	shop_vcode, sum(sales) sum_sales, sum(pre_fee) as pre_fee
							from
							(
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >='2013-01-26'
									and		x.sale_date < '2013-03-01'
									and		shop_vcode in(1733, 536)
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate 
							from tbl_ap_sales_fee_rate_sliding 
							where @sdate_ex between s_date and  e_date
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end else if @sdate < cast('2013-02-01' as datetime) begin
			-- 지마켓 예상수수료 고정.. 전월 26일 ~ 당월 25일까지의 수수료로 처리
			insert into #ex_gmarket_pre_fee
			select	shop_vcode, cast(pre_fee-sliding_exclude_pre_fee as int) as fee
			from	(

						select e.*,
						case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
						from
						(
							select	shop_vcode, sum(sales) sum_sales, sum(pre_fee) as pre_fee
							from
							(
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >=@sdate_ex
									and		x.sale_date < @edate_ex+1
									and		shop_vcode in(1733, 536)
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate 
							from tbl_ap_sales_fee_rate_sliding 
							where @sdate_ex between s_date and  e_date
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end else if @sdate >= cast('2013-03-01' as datetime) begin
			-- 지마켓 예상수수료 고정.. 전월 26일 ~ 당월 25일까지의 수수료로 처리
			insert into #ex_gmarket_pre_fee
			select	shop_vcode, cast(pre_fee-sliding_exclude_pre_fee as int) as fee
			from	(

						select e.*,
						case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
						from
						(
							select	shop_vcode, sum(sales) sum_sales, sum(pre_fee) as pre_fee
							from
							(
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >=@sdate
									and		x.sale_date < @edate+1
									and		shop_vcode in(1733, 536)
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate 
							from tbl_ap_sales_fee_rate_sliding 
							where @sdate_ex between s_date and  e_date
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end

	end

	-- 일별합계
	select	(CASE WHEN h.NUM = 1 THEN '합계' ELSE '합계(순)' END) AS SHOP_NAME,
			sum(sum_sales), sum(sum_sales)/max(avg_cnt) as avg_sales, cast(sum(fee) as int) as fee,
			sum(day1),sum(day2),sum(day3),sum(day4),sum(day5),
			sum(day6),sum(day7),sum(day8),sum(day9),sum(day10),
			sum(day11),sum(day12),sum(day13),sum(day14),sum(day15),
			sum(day16),sum(day17),sum(day18),sum(day19),sum(day20),
			sum(day21),sum(day22),sum(day23),sum(day24),sum(day25),
			sum(day26),sum(day27),sum(day28),sum(day29),sum(day30),
			sum(day31)
	,		(CASE WHEN h.NUM = 1 THEN '합계' ELSE '합계(순)' END) AS SHOP_NAME
	,		sum(pre_sum_sales * datediff(d, @sdate, dateadd(m, 1, @sdate)))
	from
	(
			select j.*
			, case when j.shop_vcode in (536, 1733, 75, 806) then
				(select fee from #ex_gmarket_pre_fee where shop_vcode = j.shop_vcode)
			 else pre_fee-sliding_exclude_pre_fee end as fee
			, f.num
			from		
			(
				select e.*,
				case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
				, pre_sum_sales
				from
				(
					select	shop_vcode
					,		sum(sales) sum_sales
					,		count(*) avg_cnt
					,		sum(pre_fee) as pre_fee
					,		sum(case when number = 1 then sales end) as day1
					,		sum(case when number = 2 then sales end) as day2
					,		sum(case when number = 3 then sales end) as day3
					,		sum(case when number = 4 then sales end) as day4
					,		sum(case when number = 5 then sales end) as day5
					,		sum(case when number = 6 then sales end) as day6
					,		sum(case when number = 7 then sales end) as day7
					,		sum(case when number = 8 then sales end) as day8
					,		sum(case when number = 9 then sales end) as day9
					,		sum(case when number = 10 then sales end) as day10
					,		sum(case when number = 11 then sales end) as day11
					,		sum(case when number = 12 then sales end) as day12
					,		sum(case when number = 13 then sales end) as day13
					,		sum(case when number = 14 then sales end) as day14
					,		sum(case when number = 15 then sales end) as day15
					,		sum(case when number = 16 then sales end) as day16
					,		sum(case when number = 17 then sales end) as day17
					,		sum(case when number = 18 then sales end) as day18
					,		sum(case when number = 19 then sales end) as day19
					,		sum(case when number = 20 then sales end) as day20
					,		sum(case when number = 21 then sales end) as day21
					,		sum(case when number = 22 then sales end) as day22
					,		sum(case when number = 23 then sales end) as day23
					,		sum(case when number = 24 then sales end) as day24
					,		sum(case when number = 25 then sales end) as day25
					,		sum(case when number = 26 then sales end) as day26
					,		sum(case when number = 27 then sales end) as day27
					,		sum(case when number = 28 then sales end) as day28
					,		sum(case when number = 29 then sales end) as day29
					,		sum(case when number = 30 then sales end) as day30
					,		sum(case when number = 31 then sales end) as day31
					from
					(
						
						select a.*
						-- 수수료
						, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee
						from
						(
							select	x.*, tmp_date_sort.number
							from	tbl_ap_sales x
										inner  join 
									(
									select number+1 as number, @sdate+number as sale_date  from tbl_number where number between 0 and (select datediff(d, @sdate, @edate))
									) tmp_date_sort
										on x.sale_date = tmp_date_sort.sale_date
							where	x.sale_date >=@sdate
							and		x.sale_date < @edate+1
							--and		shop_vcode in (49,47,55,57,75,90,536,663,806,1289,1675,1878,3539,4027,5893,5217,974,5610,5910,1733,1719,6052,6547,6361,374,6588,6508,6620)
							and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)

						) a
						left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
						left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
					) d
					group by shop_vcode
				) e
					left outer join
				(
					select shop_vcode, sum_limit, rate 
					from tbl_ap_sales_fee_rate_sliding 
					where @sdate between s_date and  e_date
				) i
					on e.shop_vcode = i.shop_vcode
					left outer join
				-- 예상합계
				(
					select	shop_vcode
					,	sum(sales)/28 as pre_sum_sales
					from
					(
						select	*
						from	tbl_ap_sales
						where	sale_date >=dateadd(d, -27, @max_date)
						and		sale_date < @max_date +1
						--and		shop_vcode in (49,47,55,57,75,90,536,663,806,1289,1675,1878,3539,4027,5893,5217,974,5610,5910,1733,1719,6052,6547,6361,374,6588,6508,6620)
						and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
					) d
					group by shop_vcode
				) k
					on e.shop_vcode = k.shop_vcode
			) j	
				cross join
			(SELECT 1 AS NUM UNION ALL SELECT 2) f

		) h
		where shop_vcode NOT IN
			(
				CASE WHEN h.NUM = 1 THEN 5893 ELSE 4027 END,
				CASE WHEN h.NUM = 1 THEN 1733 ELSE 536 END,
				CASE WHEN h.NUM = 1 THEN 1719 ELSE 55 END,
				CASE WHEN h.NUM = 1 THEN 6052 ELSE 5910 END
			)
		GROUP BY h.NUM
		HAVING SUM(sum_sales) IS NOT NULL
		ORDER BY h.NUM

