/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_pre_fee_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-14 11:24:17.303
 *        Modify: 2018-05-03 17:23:35.157
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_daily_enuri_pre_fee_v3]
	@YEAR	SMALLINT
,	@MONTH	SMALLINT
,	@sale_flag char(1)
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2011.02.08
	-- 설  명 : AP 월예상수수료
	-- 실  행 : UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI 2008, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	/*
	지마켓 예외처리 2012.05.17 정재웅
	정산 기간이 전월 26일 ~ 당월 25일 이라서.
	정산 기간의 예상수수료로 계산.
	*/
	-- gshop(75), cjmall(806) 예외처리 2012.07.10
	*/

	declare @sdate datetime
	declare @max_date datetime
	set @sdate = cast(@year as varchar(4)) +'-'+ cast(@month as varchar(2)) + '-01'

	select @max_date = max(sale_date) from tbl_ap_sales where sale_date>=@sdate and sale_date < dateadd(m, 1, @sdate) and sale_flag = @sale_flag


	declare @sdate_ex datetime
	declare @edate_ex datetime
	set @sdate_ex = dateadd(d, 25, dateadd(m, -1, @sdate)) -- 전월 26일
	set @edate_ex = dateadd(d, 24, @sdate) -- 당월 25일

	create table #ex_gmarket_pre_fee (shop_vcode int, sales money, sale_date datetime)
	if day(@max_date) >= 25 begin
		-- gshop, cjamll  예외처리
		insert into #ex_gmarket_pre_fee
		select shop_vcode, sales, sale_date
		from	tbl_ap_sales
		where	sale_date >=@sdate_ex
		and		sale_date < @edate_ex +1
		and		shop_vcode in (75, 806)
		and		sale_flag = @sale_flag

		-- 지마켓 예외처리
		if @sdate = cast('2013-02-01' as datetime) begin
			-- 지마켓 예상수수료 고정.. 전월 26일 ~ 당월 말일까지의 수수료로 처리
			insert into #ex_gmarket_pre_fee
			select shop_vcode, sales, sale_date
			from	tbl_ap_sales
			where	sale_date >='2013-01-26'
			and		sale_date < '2013-03-01'
			and		shop_vcode in (1733, 536)
			and		sale_flag = @sale_flag
		end else if @sdate < cast('2013-02-01' as datetime) begin
			-- 지마켓 예상수수료 고정.. 전월 26일 ~ 당월 25일까지의 수수료로 처리
			insert into #ex_gmarket_pre_fee
			select shop_vcode, sales, sale_date
			from	tbl_ap_sales
			where	sale_date >=@sdate_ex
			and		sale_date < @edate_ex +1
			and		shop_vcode in (1733, 536)
			and		sale_flag = @sale_flag
		end else if @sdate >= cast('2013-03-01' as datetime) begin
			-- 지마켓 28일 기준 평균매출액
			insert into #ex_gmarket_pre_fee
			select shop_vcode, avg_sales, @sdate_ex+number as sale_date
			from
			(
				-- 이전 28일 기준 평균매출액
				select	shop_vcode, avg(sales) avg_sales
				from	tbl_ap_sales
				where	sale_date >=dateadd(d, -27, @max_date)
				and		sale_date < @max_date +1
				and		shop_vcode in (1733, 536)
				and		sale_flag = @sale_flag
				group by shop_vcode
			) x
			cross join
			(
				select number from master.dbo.spt_values where type='p' and number between 0 and datediff(d, @sdate_ex, dateadd(m, 1, @sdate_ex))-1
			) y
		end
	end else begin
		insert into #ex_gmarket_pre_fee
		select shop_vcode, avg_sales, @sdate_ex+number as sale_date
		from
		(
			-- 이전 28일 기준 평균매출액
			select	shop_vcode, avg(sales) avg_sales
			from	tbl_ap_sales
			where	sale_date >=dateadd(d, -27, @max_date)
			and		sale_date < @max_date +1
			and		shop_vcode in (1733, 536, 75, 806)
			and		sale_flag = @sale_flag
			group by shop_vcode
		) x
		cross join
		(
			select number from master.dbo.spt_values where type='p' and number between 0 and datediff(d, @sdate_ex, dateadd(m, 1, @sdate_ex))-1
		) y
	end


	--select * from #ex_gmarket_pre_fee


	select	(CASE WHEN h.NUM = 1 THEN '예상수수료합계' ELSE '예상수수료합계(순)' END) AS SHOP_NAME
	,		cast(sum(sum_pre_fee - sliding_exclude_pre_fee) as money)
	,		cast(sum(sum_pre_fee_not_promotion - sliding_exclude_pre_fee) as money)
	from
	(
			select j.*, f.num
			from
			(
				select e.*,
					case when sum_sales > isnull(sum_limit, sum_sales) then (sum_sales - sum_limit)*i.rate else 0 end as sliding_exclude_pre_fee
				from
				(
					select	shop_vcode
					,		sum(pre_fee) as sum_pre_fee
					,		sum(pre_fee_not_promotion) as sum_pre_fee_not_promotion
					,		sum(avg_sales) as sum_sales
					from
					(
						select a.shop_vcode, isnull(isnull(c.rate, b.rate), 0.02/1.1)*avg_sales as pre_fee, isnull(b.rate, 0.02/1.1)*avg_sales as pre_fee_not_promotion,avg_sales
						from
						(
							select shop_vcode, avg_sales, @sdate+number as sale_date
							from
							(
								-- 이전 28일 기준 평균매출액
								select	shop_vcode, avg(sales) avg_sales
								from	tbl_ap_sales
								where	sale_date >=dateadd(d, -27, @max_date)
								and		sale_date < @max_date +1
								--and		shop_vcode in (49,47,55,57,90,663,1289,1675,1878,3539,4027,5893,5217,974,5610,5910,1719,6052,6547,6361,374, 6588, 6508, 6620)
								and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop where shop_vcode not in (1733, 536, 75, 806))
								and		sale_flag = @sale_flag
								group by shop_vcode
							) x
							cross join
							(
								select number from master.dbo.spt_values where type='p' and number between 0 and datediff(d, @sdate, dateadd(m, 1, @sdate))-1
							) y

							union all

							/*
							지마켓 예외처리 2012.05.17 정재웅
							*/
							select shop_vcode, sales, sale_date from #ex_gmarket_pre_fee
						) a
						left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date and b.sale_flag = @sale_flag
						left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date and c.sale_flag = @sale_flag
					) d
					group by shop_vcode
				) e
					left outer join
				(
					select shop_vcode, sum_limit, rate 
					from tbl_ap_sales_fee_rate_sliding 
					where @sdate between s_date and  e_date
					and		sale_flag = @sale_flag
				) i
					on e.shop_vcode = i.shop_vcode
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
		ORDER BY h.NUM



