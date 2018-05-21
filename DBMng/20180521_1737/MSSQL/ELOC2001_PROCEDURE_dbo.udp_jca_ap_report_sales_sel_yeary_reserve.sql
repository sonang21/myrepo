/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sales_sel_yeary_reserve
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-07-21 16:10:45.023
 *        Modify: 2018-05-03 17:23:34.5
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sales_sel_yeary_reserve
	@yyyy	varchar(4)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.03.10
	-- ��  �� : ap ��ü ���� �����
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	declare @sdate smalldatetime, @edate smalldatetime
	set @sdate = cast(@yyyy+'-01-01' as smalldatetime)
	set @edate = cast(@yyyy+'-12-31' as smalldatetime)
	
	-- ��ü
	select '��ü ����� (����)', yyyy, isnull([1��],0),isnull([2��],0),isnull([3��],0),isnull([4��],0),isnull([5��],0),isnull([6��],0)
	,		isnull([7��],0),isnull([8��],0),isnull([9��],0),isnull([10��],0),isnull([11��],0),isnull([12��],0)
	,		month_sum
	,		month_avg= month_sum/(sign(isnull([1��],0))+sign(isnull([2��],0))+sign(isnull([3��],0))+
			sign(isnull([4��],0))+sign(isnull([5��],0))+sign(isnull([6��],0))+
			sign(isnull([7��],0))+sign(isnull([8��],0))+sign(isnull([9��],0))+
			sign(isnull([10��],0))+sign(isnull([11��],0))+sign(isnull([12��],0)))
	from 
	(
		select	year(sales_date) as yyyy
		,		[1��] = sum(case when month(sales_date) = 1 then sales_sum end) 
		,		[2��] = sum(case when month(sales_date) = 2 then sales_sum end)
		,		[3��] = sum(case when month(sales_date) = 3 then sales_sum end)
		,		[4��] = sum(case when month(sales_date) = 4 then sales_sum end)
		,		[5��] = sum(case when month(sales_date) = 5 then sales_sum end)
		,		[6��] = sum(case when month(sales_date) = 6 then sales_sum end)
		,		[7��] = sum(case when month(sales_date) = 7 then sales_sum end)
		,		[8��] = sum(case when month(sales_date) = 8 then sales_sum end)
		,		[9��] = sum(case when month(sales_date) = 9 then sales_sum end)
		,		[10��] = sum(case when month(sales_date) = 10 then sales_sum end)
		,		[11��] = sum(case when month(sales_date) = 11 then sales_sum end)
		,		[12��] = sum(case when month(sales_date) = 12 then sales_sum end)
		,		[month_sum] = sum(sales_sum)
		from tbl_ap_shop_sales aa
		where shop_group = 'T'
		and sales_date  < getdate() - day(getdate()) -- ��� ����
		and	shop_vcode in 
		(
			select shop_vcode from shoplist where shop_vcode  = aa.shop_vcode and shop_name like '%����%'
		)
		group by year(sales_date)
	) a
	order by yyyy desc	
