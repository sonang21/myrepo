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
	-- �ۼ��� : wookki25 / 2010.03.10
	-- ��  �� : ap ��ü �Ϻ� �����
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	declare @sdate smalldatetime, @edate smalldatetime
	set @sdate = cast(@yyyy+'-'+@mm+'-01' as smalldatetime)
	set @edate = dateadd(m, 1, @sdate)-1

	select shop_name,[1��],[2��],[3��],[4��],[5��],[6��],[7��],[8��],[9��],[10��]
	,[11��],[12��],[13��],[14��],[15��],[16��],[17��],[18��],[19��],[20��]
	,[21��],[22��],[23��],[24��],[25��],[26��],[27��],[28��],[29��],[30��],[31��]
	,shop_name, day_sum
	from 
	(
	select	shop_vcode as shop_vcode
	,		[1��] = sum(case when day(sales_date) = 1 then sales_sum end) 
	,		[2��] = sum(case when day(sales_date) = 2 then sales_sum end)
	,		[3��] = sum(case when day(sales_date) = 3 then sales_sum end)
	,		[4��] = sum(case when day(sales_date) = 4 then sales_sum end)
	,		[5��] = sum(case when day(sales_date) = 5 then sales_sum end)
	,		[6��] = sum(case when day(sales_date) = 6 then sales_sum end)
	,		[7��] = sum(case when day(sales_date) = 7 then sales_sum end)
	,		[8��] = sum(case when day(sales_date) = 8 then sales_sum end)
	,		[9��] = sum(case when day(sales_date) = 9 then sales_sum end)
	,		[10��] = sum(case when day(sales_date) = 10 then sales_sum end)
	,		[11��] = sum(case when day(sales_date) = 11 then sales_sum end)
	,		[12��] = sum(case when day(sales_date) = 12 then sales_sum end)
	,		[13��] = sum(case when day(sales_date) = 13 then sales_sum end)
	,		[14��] = sum(case when day(sales_date) = 14 then sales_sum end)
	,		[15��] = sum(case when day(sales_date) = 15 then sales_sum end)
	,		[16��] = sum(case when day(sales_date) = 16 then sales_sum end)
	,		[17��] = sum(case when day(sales_date) = 17 then sales_sum end)
	,		[18��] = sum(case when day(sales_date) = 18 then sales_sum end)
	,		[19��] = sum(case when day(sales_date) = 19 then sales_sum end)
	,		[20��] = sum(case when day(sales_date) = 20 then sales_sum end)
	,		[21��] = sum(case when day(sales_date) = 21 then sales_sum end)
	,		[22��] = sum(case when day(sales_date) = 22 then sales_sum end)
	,		[23��] = sum(case when day(sales_date) = 23 then sales_sum end)
	,		[24��] = sum(case when day(sales_date) = 24 then sales_sum end)
	,		[25��] = sum(case when day(sales_date) = 25 then sales_sum end)
	,		[26��] = sum(case when day(sales_date) = 26 then sales_sum end)
	,		[27��] = sum(case when day(sales_date) = 27 then sales_sum end)
	,		[28��] = sum(case when day(sales_date) = 28 then sales_sum end)
	,		[29��] = sum(case when day(sales_date) = 29 then sales_sum end)
	,		[30��] = sum(case when day(sales_date) = 30 then sales_sum end)
	,		[31��] = sum(case when day(sales_date) = 31 then sales_sum end)
	,		[day_sum] = sum(sales_sum)	
	from tbl_ap_shop_sales
	where sales_date between @sdate and @edate
	and	shop_group = @shop_group
	and device = isnull(@device, device)
	group by shop_vcode
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by case when @shop_group = 'b' then cast(100000000 - day_sum as int) else row_number() over(order by b.shop_name asc) end

	


	select	'�հ�' as shop_vcode
	,		[1��] = sum(case when day(sales_date) = 1 then sales_sum end) 
	,		[2��] = sum(case when day(sales_date) = 2 then sales_sum end)
	,		[3��] = sum(case when day(sales_date) = 3 then sales_sum end)
	,		[4��] = sum(case when day(sales_date) = 4 then sales_sum end)
	,		[5��] = sum(case when day(sales_date) = 5 then sales_sum end)
	,		[6��] = sum(case when day(sales_date) = 6 then sales_sum end)
	,		[7��] = sum(case when day(sales_date) = 7 then sales_sum end)
	,		[8��] = sum(case when day(sales_date) = 8 then sales_sum end)
	,		[9��] = sum(case when day(sales_date) = 9 then sales_sum end)
	,		[10��] = sum(case when day(sales_date) = 10 then sales_sum end)
	,		[11��] = sum(case when day(sales_date) = 11 then sales_sum end)
	,		[12��] = sum(case when day(sales_date) = 12 then sales_sum end)
	,		[13��] = sum(case when day(sales_date) = 13 then sales_sum end)
	,		[14��] = sum(case when day(sales_date) = 14 then sales_sum end)
	,		[15��] = sum(case when day(sales_date) = 15 then sales_sum end)
	,		[16��] = sum(case when day(sales_date) = 16 then sales_sum end)
	,		[17��] = sum(case when day(sales_date) = 17 then sales_sum end)
	,		[18��] = sum(case when day(sales_date) = 18 then sales_sum end)
	,		[19��] = sum(case when day(sales_date) = 19 then sales_sum end)
	,		[20��] = sum(case when day(sales_date) = 20 then sales_sum end)
	,		[21��] = sum(case when day(sales_date) = 21 then sales_sum end)
	,		[22��] = sum(case when day(sales_date) = 22 then sales_sum end)
	,		[23��] = sum(case when day(sales_date) = 23 then sales_sum end)
	,		[24��] = sum(case when day(sales_date) = 24 then sales_sum end)
	,		[25��] = sum(case when day(sales_date) = 25 then sales_sum end)
	,		[26��] = sum(case when day(sales_date) = 26 then sales_sum end)
	,		[27��] = sum(case when day(sales_date) = 27 then sales_sum end)
	,		[28��] = sum(case when day(sales_date) = 28 then sales_sum end)
	,		[29��] = sum(case when day(sales_date) = 29 then sales_sum end)
	,		[30��] = sum(case when day(sales_date) = 30 then sales_sum end)
	,		[31��] = sum(case when day(sales_date) = 31 then sales_sum end)
	,		'�հ�' as shop_vcode2
	,		[day_sum] = sum(sales_sum)	
	from tbl_ap_shop_sales
	where sales_date between @sdate and @edate
	and shop_group = @shop_group
	and device = isnull(@device, device)









