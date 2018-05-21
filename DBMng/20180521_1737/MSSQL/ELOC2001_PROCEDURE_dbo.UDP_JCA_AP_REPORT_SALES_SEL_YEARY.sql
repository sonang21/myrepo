/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SALES_SEL_YEARY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-12 15:55:25.903
 *        Modify: 2018-05-03 17:23:34.29
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sales_sel_yeary
	@yyyy	varchar(4)
,	@shop_group char(1) = null
,	@device char(1) = null
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

	declare @groupname varchar(100)
	if @shop_group = 't'
		set @groupname = '�����'
	else if @shop_group = 'b'
		set @groupname = '���θ�'
	else if @shop_group = 'o'
		set @groupname = '������'
	-- ��ü
	select '��ü '+@groupname, yyyy, isnull([1��],0),isnull([2��],0),isnull([3��],0),isnull([4��],0),isnull([5��],0),isnull([6��],0)
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
		where shop_group = @shop_group
		and device = isnull(@device, device)
		and sales_date  < getdate() - day(getdate()) -- ��� ����
		and	shop_vcode in 
		(
			select shop_vcode from shoplist where @shop_group = 't' and shop_vcode  = aa.shop_vcode and shop_name not like '%����%'
			union all
			select shop_vcode from shoplist where @shop_group = 'b'
		)
		group by year(sales_date)
	) a
	order by yyyy desc
	
	-- ��ü��
	select shop_name, yyyy, isnull([1��],0),isnull([2��],0),isnull([3��],0),isnull([4��],0),isnull([5��],0),isnull([6��],0)
	,		isnull([7��],0),isnull([8��],0),isnull([9��],0),isnull([10��],0),isnull([11��],0),isnull([12��],0)
	,		month_sum
	,		month_avg= month_sum/(sign(isnull([1��],0))+sign(isnull([2��],0))+sign(isnull([3��],0))+
				sign(isnull([4��],0))+sign(isnull([5��],0))+sign(isnull([6��],0))+
				sign(isnull([7��],0))+sign(isnull([8��],0))+sign(isnull([9��],0))+
				sign(isnull([10��],0))+sign(isnull([11��],0))+sign(isnull([12��],0)))
	from 
	(
		select	shop_vcode, year(sales_date) as yyyy
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
		where shop_group = @shop_group
		and device = isnull(@device, device)
		and sales_date  < getdate() - day(getdate()) -- ��� ����
		and	shop_vcode in 
		(
			select shop_vcode from shoplist where @shop_group = 't' and shop_vcode  = aa.shop_vcode and shop_name not like '%����%'
			union all
			select shop_vcode from shoplist where @shop_group = 'b' -- shop_vcode in (724, 4856, 4861)
		)
		group by shop_vcode, year(sales_date)
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by 
	case a.shop_vcode 
	when 4856 then 1 
	when 3367 then 2
	when 4861 then 3
	when  724 then 4
	when 4858 then 5
	when 6238 then 6
	when 4859 then 7 
	else a.shop_vcode end, a.yyyy desc	





