/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_bid_sel_monthly_sum
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-21 10:34:35.263
 *        Modify: 2018-05-03 17:23:36.017
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_bid_sel_monthly_sum
	@sale_date smalldatetime
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2013-08-21
	-- 설  명 : 상위입찰 노출,클릭 조회
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------	
	*/	

	select	datepart(mm, sale_date) as mmofyear
	,		sum(sales) as sales
	,		sum(sale_cnt) as sale_cnt
	,		sum(exp_cnt) as exp_cnt
	,		sum(hit_cnt) as hit_cnt
	into	#tbl_groupby_month
	from	tbl_ap_sales_bid
	where	sale_date >=@sale_date
	and		sale_date<dateadd(yy, 1, @sale_date)
	group by datepart(mm, sale_date)
	having sum(sales) is not null


	If year(@sale_date) = year(getdate()) -- 금년을 확인하는 경우, 금월 제외처리
		delete from #tbl_groupby_month where mmofyear > datepart(mm, getdate())-1

	select '', data_opt,
		case num 
				when 1 then '매출액' 
				when 2 then '모델수'
				when 3 then '노출수' 
				when 4 then '클릭수' 
				when 5 then 'CPI' 
				when 6 then 'CPC' 
				when 7 then 'CTR(%)' 
 		end as hit_name 
		, [1월], [2월], [3월], [4월], [5월], [6월], [7월], [8월], [9월]
		, [10월], [11월], [12월]
		, day_sum, day_avg
		from 
		(
		select	'0' data_opt
		,		num
		,		[1월]  = max(case when mmofyear =  1 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2월]  = max(case when mmofyear =  2 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3월]  = max(case when mmofyear =  3 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4월]  = max(case when mmofyear =  4 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5월]  = max(case when mmofyear =  5 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6월]  = max(case when mmofyear =  6 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7월]  = max(case when mmofyear =  7 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8월]  = max(case when mmofyear =  8 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9월]  = max(case when mmofyear =  9 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10월] = max(case when mmofyear = 10 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11월] = max(case when mmofyear = 11 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12월] = max(case when mmofyear = 12 then case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then null when 6 then null end)	
		,		[day_avg] = avg(case num when 1 then sales when 2 then sale_cnt when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/exp_cnt,0) when 6 then round(sales/hit_cnt,0) when 7 then round(hit_cnt*100.0/exp_cnt,2) end)
		from #tbl_groupby_month cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7) bb
		group by num
		) a 
		order by num
