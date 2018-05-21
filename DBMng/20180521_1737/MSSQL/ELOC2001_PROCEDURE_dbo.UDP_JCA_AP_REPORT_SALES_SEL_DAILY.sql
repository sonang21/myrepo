/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SALES_SEL_DAILY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 14:31:23.16
 *        Modify: 2018-05-03 17:23:34.18
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sales_sel_daily
	@yyyy	varchar(4)
,	@mm		varchar(2)
,	@shop_group char(1) = null
,	@device char(1) = null
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 累己磊 : wookki25 / 2010.03.10
	-- 汲  疙 : ap 诀眉 老喊 概免咀
	-- ----------------------------------------------------------------------------------
	-- 荐沥郴开
	-- ----------------------------------------------------------------------------------
	/*
	荐沥老:			荐沥磊:			荐沥郴侩:
	----------		-----------		-----------------------------------------------------		
	*/
	declare @sdate smalldatetime, @edate smalldatetime
	set @sdate = cast(@yyyy+'-'+@mm+'-01' as smalldatetime)
	set @edate = dateadd(m, 1, @sdate)-1

	select shop_name,[1老],[2老],[3老],[4老],[5老],[6老],[7老],[8老],[9老],[10老]
	,[11老],[12老],[13老],[14老],[15老],[16老],[17老],[18老],[19老],[20老]
	,[21老],[22老],[23老],[24老],[25老],[26老],[27老],[28老],[29老],[30老],[31老]
	,shop_name, day_sum
	from 
	(
	select	shop_vcode as shop_vcode
	,		[1老] = sum(case when day(sales_date) = 1 then sales_sum end) 
	,		[2老] = sum(case when day(sales_date) = 2 then sales_sum end)
	,		[3老] = sum(case when day(sales_date) = 3 then sales_sum end)
	,		[4老] = sum(case when day(sales_date) = 4 then sales_sum end)
	,		[5老] = sum(case when day(sales_date) = 5 then sales_sum end)
	,		[6老] = sum(case when day(sales_date) = 6 then sales_sum end)
	,		[7老] = sum(case when day(sales_date) = 7 then sales_sum end)
	,		[8老] = sum(case when day(sales_date) = 8 then sales_sum end)
	,		[9老] = sum(case when day(sales_date) = 9 then sales_sum end)
	,		[10老] = sum(case when day(sales_date) = 10 then sales_sum end)
	,		[11老] = sum(case when day(sales_date) = 11 then sales_sum end)
	,		[12老] = sum(case when day(sales_date) = 12 then sales_sum end)
	,		[13老] = sum(case when day(sales_date) = 13 then sales_sum end)
	,		[14老] = sum(case when day(sales_date) = 14 then sales_sum end)
	,		[15老] = sum(case when day(sales_date) = 15 then sales_sum end)
	,		[16老] = sum(case when day(sales_date) = 16 then sales_sum end)
	,		[17老] = sum(case when day(sales_date) = 17 then sales_sum end)
	,		[18老] = sum(case when day(sales_date) = 18 then sales_sum end)
	,		[19老] = sum(case when day(sales_date) = 19 then sales_sum end)
	,		[20老] = sum(case when day(sales_date) = 20 then sales_sum end)
	,		[21老] = sum(case when day(sales_date) = 21 then sales_sum end)
	,		[22老] = sum(case when day(sales_date) = 22 then sales_sum end)
	,		[23老] = sum(case when day(sales_date) = 23 then sales_sum end)
	,		[24老] = sum(case when day(sales_date) = 24 then sales_sum end)
	,		[25老] = sum(case when day(sales_date) = 25 then sales_sum end)
	,		[26老] = sum(case when day(sales_date) = 26 then sales_sum end)
	,		[27老] = sum(case when day(sales_date) = 27 then sales_sum end)
	,		[28老] = sum(case when day(sales_date) = 28 then sales_sum end)
	,		[29老] = sum(case when day(sales_date) = 29 then sales_sum end)
	,		[30老] = sum(case when day(sales_date) = 30 then sales_sum end)
	,		[31老] = sum(case when day(sales_date) = 31 then sales_sum end)
	,		[day_sum] = sum(sales_sum)	
	from tbl_ap_shop_sales
	where sales_date between @sdate and @edate
	and	shop_group = @shop_group
	and device = isnull(@device, device)
	group by shop_vcode
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by case when @shop_group = 'b' then cast(100000000 - day_sum as int) else row_number() over(order by b.shop_name asc) end

	


	select	'钦拌' as shop_vcode
	,		[1老] = sum(case when day(sales_date) = 1 then sales_sum end) 
	,		[2老] = sum(case when day(sales_date) = 2 then sales_sum end)
	,		[3老] = sum(case when day(sales_date) = 3 then sales_sum end)
	,		[4老] = sum(case when day(sales_date) = 4 then sales_sum end)
	,		[5老] = sum(case when day(sales_date) = 5 then sales_sum end)
	,		[6老] = sum(case when day(sales_date) = 6 then sales_sum end)
	,		[7老] = sum(case when day(sales_date) = 7 then sales_sum end)
	,		[8老] = sum(case when day(sales_date) = 8 then sales_sum end)
	,		[9老] = sum(case when day(sales_date) = 9 then sales_sum end)
	,		[10老] = sum(case when day(sales_date) = 10 then sales_sum end)
	,		[11老] = sum(case when day(sales_date) = 11 then sales_sum end)
	,		[12老] = sum(case when day(sales_date) = 12 then sales_sum end)
	,		[13老] = sum(case when day(sales_date) = 13 then sales_sum end)
	,		[14老] = sum(case when day(sales_date) = 14 then sales_sum end)
	,		[15老] = sum(case when day(sales_date) = 15 then sales_sum end)
	,		[16老] = sum(case when day(sales_date) = 16 then sales_sum end)
	,		[17老] = sum(case when day(sales_date) = 17 then sales_sum end)
	,		[18老] = sum(case when day(sales_date) = 18 then sales_sum end)
	,		[19老] = sum(case when day(sales_date) = 19 then sales_sum end)
	,		[20老] = sum(case when day(sales_date) = 20 then sales_sum end)
	,		[21老] = sum(case when day(sales_date) = 21 then sales_sum end)
	,		[22老] = sum(case when day(sales_date) = 22 then sales_sum end)
	,		[23老] = sum(case when day(sales_date) = 23 then sales_sum end)
	,		[24老] = sum(case when day(sales_date) = 24 then sales_sum end)
	,		[25老] = sum(case when day(sales_date) = 25 then sales_sum end)
	,		[26老] = sum(case when day(sales_date) = 26 then sales_sum end)
	,		[27老] = sum(case when day(sales_date) = 27 then sales_sum end)
	,		[28老] = sum(case when day(sales_date) = 28 then sales_sum end)
	,		[29老] = sum(case when day(sales_date) = 29 then sales_sum end)
	,		[30老] = sum(case when day(sales_date) = 30 then sales_sum end)
	,		[31老] = sum(case when day(sales_date) = 31 then sales_sum end)
	,		'钦拌' as shop_vcode2
	,		[day_sum] = sum(sales_sum)	
	from tbl_ap_shop_sales
	where sales_date between @sdate and @edate
	and shop_group = @shop_group
	and device = isnull(@device, device)









