/* *************************************************************************
 * NAME : dbo.udp_rival_sales_sel_sum
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-18 16:36:23.0
 *        Modify: 2018-05-03 17:23:35.467
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_rival_sales_sel_sum
	@sdate	smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-04-18
	-- 설  명 : 경쟁사 매출 동향
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	select a.rival_name
	, b.m1, b.m2, b.m3, b.m4, b.m5
	, b.m6, b.m7, b.m8, b.m9, b.m10 
	, b.m11, b.m12, tot, round(tot /max_mon ,0)
	from (
		select '에누리' as rival_name, 1 sort  union all
		select '다나와', 3 sort union all
		select '지식쇼핑', 2 sort union all
		select '쇼핑하우', 4 sort union all
		select '어바웃', 5 sort union all
		select '합계',6
	) a left outer join (

		select	rival_name
		,	m1  = sum(case when month(sale_date) = 1  then sales end)
		,	m2  = sum(case when month(sale_date) = 2  then sales end)
		,	m3  = sum(case when month(sale_date) = 3  then sales end)
		,	m4  = sum(case when month(sale_date) = 4  then sales end)
		,	m5  = sum(case when month(sale_date) = 5  then sales end)
		,	m6  = sum(case when month(sale_date) = 6  then sales end)
		,	m7  = sum(case when month(sale_date) = 7  then sales end)
		,	m8  = sum(case when month(sale_date) = 8  then sales end)
		,	m9  = sum(case when month(sale_date) = 9  then sales end)
		,	m10 = sum(case when month(sale_date) = 10 then sales end)
		,	m11 = sum(case when month(sale_date) = 11 then sales end)
		,	m12 = sum(case when month(sale_date) = 12 then sales end)
		,	tot = sum(sales) 
		,	max_mon = month(max(sale_date))*1.0
		from	tbl_ap_sales_rival 			
		where	sale_date >= @sdate
		and		sale_date <  dateadd(yy, 1, @sdate)
		group by rival_name

		union all

		select '합계' rival_name
		,	m1  = sum(case when month(sale_date) = 1  then sales end)
		,	m2  = sum(case when month(sale_date) = 2  then sales end)
		,	m3  = sum(case when month(sale_date) = 3  then sales end)
		,	m4  = sum(case when month(sale_date) = 4  then sales end)
		,	m5  = sum(case when month(sale_date) = 5  then sales end)
		,	m6  = sum(case when month(sale_date) = 6  then sales end)
		,	m7  = sum(case when month(sale_date) = 7  then sales end)
		,	m8  = sum(case when month(sale_date) = 8  then sales end)
		,	m9  = sum(case when month(sale_date) = 9  then sales end)
		,	m10 = sum(case when month(sale_date) = 10 then sales end)
		,	m11 = sum(case when month(sale_date) = 11 then sales end)
		,	m12 = sum(case when month(sale_date) = 12 then sales end)
		,	tot = sum(sales) 
		,	max_mon = month(max(sale_date))*1.0
		from	tbl_ap_sales_rival 			
		where	sale_date >= @sdate
		and		sale_date <  dateadd(yy, 1, @sdate)

	) b on a.rival_name = b.rival_name
	where tot>0
	order by sort, rival_name

