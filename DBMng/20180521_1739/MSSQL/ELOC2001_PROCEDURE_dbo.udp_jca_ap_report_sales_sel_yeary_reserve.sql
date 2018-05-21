/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sales_sel_yeary_reserve
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-07-21 16:10:45.023
 *        Modify: 2018-05-03 17:23:34.5
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sales_sel_yeary_reserve
	@yyyy	varchar(4)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2010.03.10
	-- 설  명 : ap 업체 월별 매출액
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	declare @sdate smalldatetime, @edate smalldatetime
	set @sdate = cast(@yyyy+'-01-01' as smalldatetime)
	set @edate = cast(@yyyy+'-12-31' as smalldatetime)
	
	-- 전체
	select '전체 여행사 (예약)', yyyy, isnull([1월],0),isnull([2월],0),isnull([3월],0),isnull([4월],0),isnull([5월],0),isnull([6월],0)
	,		isnull([7월],0),isnull([8월],0),isnull([9월],0),isnull([10월],0),isnull([11월],0),isnull([12월],0)
	,		month_sum
	,		month_avg= month_sum/(sign(isnull([1월],0))+sign(isnull([2월],0))+sign(isnull([3월],0))+
			sign(isnull([4월],0))+sign(isnull([5월],0))+sign(isnull([6월],0))+
			sign(isnull([7월],0))+sign(isnull([8월],0))+sign(isnull([9월],0))+
			sign(isnull([10월],0))+sign(isnull([11월],0))+sign(isnull([12월],0)))
	from 
	(
		select	year(sales_date) as yyyy
		,		[1월] = sum(case when month(sales_date) = 1 then sales_sum end) 
		,		[2월] = sum(case when month(sales_date) = 2 then sales_sum end)
		,		[3월] = sum(case when month(sales_date) = 3 then sales_sum end)
		,		[4월] = sum(case when month(sales_date) = 4 then sales_sum end)
		,		[5월] = sum(case when month(sales_date) = 5 then sales_sum end)
		,		[6월] = sum(case when month(sales_date) = 6 then sales_sum end)
		,		[7월] = sum(case when month(sales_date) = 7 then sales_sum end)
		,		[8월] = sum(case when month(sales_date) = 8 then sales_sum end)
		,		[9월] = sum(case when month(sales_date) = 9 then sales_sum end)
		,		[10월] = sum(case when month(sales_date) = 10 then sales_sum end)
		,		[11월] = sum(case when month(sales_date) = 11 then sales_sum end)
		,		[12월] = sum(case when month(sales_date) = 12 then sales_sum end)
		,		[month_sum] = sum(sales_sum)
		from tbl_ap_shop_sales aa
		where shop_group = 'T'
		and sales_date  < getdate() - day(getdate()) -- 당월 제외
		and	shop_vcode in 
		(
			select shop_vcode from shoplist where shop_vcode  = aa.shop_vcode and shop_name like '%예약%'
		)
		group by year(sales_date)
	) a
	order by yyyy desc	
