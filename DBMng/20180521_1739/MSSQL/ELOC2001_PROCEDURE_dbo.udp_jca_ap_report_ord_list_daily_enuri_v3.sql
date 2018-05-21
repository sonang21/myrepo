/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-14 11:16:06.83
 *        Modify: 2018-05-03 17:23:35.107
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_daily_enuri_v3]
	@sdate datetime
,	@edate datetime
,	@sale_flag char(1)
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

	declare @max_date datetime
	select @max_date = max(sale_date) from tbl_ap_sales where sale_date>=@sdate and sale_date < dateadd(m, 1, @sdate) and		sale_flag = @sale_flag

	-- 수수료 예외처리 : 입력한 매출액에 대한 수수료로 계산
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
							select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee 
							from
							(
								select	x.*
								from	tbl_ap_sales x
								where	x.sale_date >=@sdate_ex
								and		x.sale_date < @edate_ex+1
								and		shop_vcode in(75, 806)
								and		sale_flag = @sale_flag
							) a
							left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and a.sale_flag = b.sale_flag
							left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and a.sale_flag = c.sale_flag
						) d
						group by shop_vcode
					) e
						left outer join
					(
						select shop_vcode, sum_limit, rate
						from tbl_ap_sales_fee_rate_sliding
						where @sdate_ex between s_date and  e_date
						and		sale_flag = @sale_flag
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
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee 
								from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >='2013-01-26'
									and		x.sale_date < '2013-03-01'
									and		shop_vcode in(1733, 536)
									and		sale_flag = @sale_flag
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and a.sale_flag = b.sale_flag
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and a.sale_flag = c.sale_flag
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate
							from tbl_ap_sales_fee_rate_sliding
							where @sdate_ex between s_date and  e_date
							and		sale_flag = @sale_flag
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end if @sdate < cast('2013-02-01' as datetime) begin
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
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee 
								from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >=@sdate_ex
									and		x.sale_date < @edate_ex+1
									and		shop_vcode in(1733, 536)
									and		sale_flag = @sale_flag
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and a.sale_flag = b.sale_flag
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and a.sale_flag = c.sale_flag
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate
							from tbl_ap_sales_fee_rate_sliding
							where @sdate_ex between s_date and  e_date
							and		sale_flag = @sale_flag
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end if @sdate >= cast('2013-03-01' as datetime) begin
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
								select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee 
								from
								(
									select	x.*
									from	tbl_ap_sales x
									where	x.sale_date >=@sdate
									and		x.sale_date < @edate+1
									and		shop_vcode in(1733, 536)
									and		sale_flag = @sale_flag
								) a
								left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and a.sale_flag = b.sale_flag
								left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and a.sale_flag = c.sale_flag
							) d
							group by shop_vcode
						) e
							left outer join
						(
							select shop_vcode, sum_limit, rate
							from tbl_ap_sales_fee_rate_sliding
							where @sdate_ex between s_date and  e_date
							and		sale_flag = @sale_flag
						) i
							on e.shop_vcode = i.shop_vcode
					) h
		end

	end

	--select * from #ex_gmarket_pre_fee
	

	-- 일별 리스트
	select
			case g.shop_vcode
				when 1733 then 'G마켓(순)'
				when 5893 then '옥션(순)'
				when 1719 then '인터파크(순)'
				when 6052 then '11번가(순)'
				else g.shop_name
			end as shop_name, sum_sales, avg_sales
			, case when g.shop_vcode in (536, 1733, 75, 806) then
				(select fee from #ex_gmarket_pre_fee where shop_vcode = g.shop_vcode)
			 else cast(pre_fee-sliding_exclude_pre_fee as int) end as fee,
			seq_day1,seq_day2,seq_day3,seq_day4,seq_day5,
			seq_day6,seq_day7,seq_day8,seq_day9,seq_day10
,
			seq_day11,seq_day12,seq_day13,seq_day14,seq_day15,
			seq_day16,seq_day17,seq_day18,seq_day19,seq_day20,
			seq_day21,seq_day22,seq_day23,seq_day24,seq_day25,
			seq_day26,seq_day27,seq_day28,seq_day29,seq_day30,
			seq_day31, case g.shop_vcode
				when 1733 then 'G마켓(순)'
				when 5893 then '옥션(순)'
				when 1719 then '인터파크(순)'
				when 6052 then '11번가(순)'
				else g.shop_name
			end as shop_name
			, pre_sum_sales * datediff(d, @sdate, dateadd(m, 1, @sdate))
			, g.display_order
	from	( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) g
				inner join
			(

			select e.*, isnull(f.order_sum_sales,e.sum_sales) as order_sum_sales,
			case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
			, pre_sum_sales
			from
			(

				select	shop_vcode			
				,		sum(sales) sum_sales
				,		avg(sales) avg_sales
				,		sum(pre_fee) as pre_fee
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
					select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee 
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
						and		shop_vcode in(select shop_vcode from tbl_ap_sales_shop) 
						and		sale_flag = @sale_flag
					) a
					left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and a.sale_flag = b.sale_flag
					left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and a.sale_flag = c.sale_flag
				) d
				group by shop_vcode
			) e
				left outer join
			(	-- order by 하기 위해서 order_sum_sales을 구한다.
				select	case shop_vcode
						when 536 then 1733
						when 4027 then 5893
						when 5910 then 6052

						when 55 then 1719
						end as shop_vcode, sum(sales) order_sum_sales
				from	tbl_ap_sales
				where	sale_date >=@sdate
				and		sale_date < @edate+1
				and		shop_vcode in (536, 4027, 55, 5910)
				and		sale_flag = @sale_flag
				group by shop_vcode
			) f
				on e.shop_vcode = f.shop_vcode
				left outer join
			(
				select shop_vcode, sum_limit, rate 
				from tbl_ap_sales_fee_rate_sliding 
				where @sdate between s_date and  e_date
				and		sale_flag = @sale_flag
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
					and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
					and		sale_flag = @sale_flag
				) d
				group by shop_vcode
			) k
			on e.shop_vcode = k.shop_vcode

		) h
			on g.shop_vcode = h.shop_vcode

	order by g.display_order, h.order_sum_sales desc, h.shop_vcode asc









