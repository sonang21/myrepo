/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_yearly_enuri_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 18:06:21.24
 *        Modify: 2018-05-03 17:23:34.377
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ord_list_yearly_enuri_2
	@shop_code int = 0
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.11
	-- ��  �� : ap ���� �ֹ��� ����Ʈ
	-- ��  �� : udp_jca_ap_report_ord_list_yearly_enuri
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/

	if @shop_code = 0
		select
			as_date_year
		,	isnull(sum(case when as_date_month = 1 then month_sum end),0) as month_1
		,	isnull(sum(case when as_date_month = 2 then month_sum end),0) as month_2
		,	isnull(sum(case when as_date_month = 3 then month_sum end),0) as month_3
		,	isnull(sum(case when as_date_month = 4 then month_sum end),0) as month_4
		,	isnull(sum(case when as_date_month = 5 then month_sum end),0) as month_5
		,	isnull(sum(case when as_date_month = 6 then month_sum end),0) as month_6
		,	isnull(sum(case when as_date_month = 7 then month_sum end),0) as month_7
		,	isnull(sum(case when as_date_month = 8 then month_sum end),0) as month_8
		,	isnull(sum(case when as_date_month = 9 then month_sum end),0) as month_9
		,	isnull(sum(case when as_date_month = 10 then month_sum end),0) as month_10
		,	isnull(sum(case when as_date_month = 11 then month_sum end),0) as month_11
		,	isnull(sum(case when as_date_month = 12 then month_sum end),0) as month_12
		,	sum(month_sum) as sum_year
		,	case when year(getdate()) = as_date_year  then sum(month_sum)/(month(getdate())-1) else sum(month_sum)/12 end as avg_year
		from
		(
			select		year(sale_date) as as_date_year, month(sale_date) as_date_month, sum(sales) as month_sum
			from		tbl_ap_sales
			where		sale_date >= cast('2006-01-01' as datetime)
			and			sale_date < cast(convert( varchar(10), getdate()-day(getdate())+1, 120) as datetime)  -- ���س⵵ ��� ����
			and			shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
			and			shop_vcode not in (5893,1733,6052,1719,4861,3368,724,4859,4856,5137,4857) -- ü��(��)������ ����, ����, �ɹ�� ��ü ����
			group by	year(sale_date), month(sale_date)
			union all
			select		year(sale_date), month(sale_date), sum(sales) month_sum
			from		tbl_ap_sales
			where		sale_date >= cast('2006-01-01' as datetime) and sale_date < cast('2007-01-01' as datetime)
			and			shop_vcode = 5893 -- ����(��)=5893 ���� // 2006�⿡�� ����(��) �����͸� �ִ�.
			group by	year(sale_date), month(sale_date)
		) tmp_tbl_mid
		group by as_date_year
		order by as_date_year desc
	else if @shop_code = 4027 -- ����
		select
			as_date_year
		,	isnull(sum(case when as_date_month = 1 then month_sum end),0) as month_1
		,	isnull(sum(case when as_date_month = 2 then month_sum end),0) as month_2
		,	isnull(sum(case when as_date_month = 3 then month_sum end),0) as month_3
		,	isnull(sum(case when as_date_month = 4 then month_sum end),0) as month_4
		,	isnull(sum(case when as_date_month = 5 then month_sum end),0) as month_5
		,	isnull(sum(case when as_date_month = 6 then month_sum end),0) as month_6
		,	isnull(sum(case when as_date_month = 7 then month_sum end),0) as month_7
		,	isnull(sum(case when as_date_month = 8 then month_sum end),0) as month_8
		,	isnull(sum(case when as_date_month = 9 then month_sum end),0) as month_9
		,	isnull(sum(case when as_date_month = 10 then month_sum end),0) as month_10
		,	isnull(sum(case when as_date_month = 11 then month_sum end),0) as month_11
		,	isnull(sum(case when as_date_month = 12 then month_sum end),0) as month_12
		,	sum(month_sum) as sum_year
		,	case when year(getdate()) = as_date_year  then sum(month_sum)/(month(getdate())-1) else sum(month_sum)/12 end as avg_year
		from
		(
			select		year(sale_date) as as_date_year, month(sale_date) as_date_month, sum(sales) as month_sum
			from		tbl_ap_sales
			where		sale_date >= cast('2006-01-01' as datetime)
			and			sale_date < cast(convert( varchar(10), getdate()-day(getdate())+1, 120) as datetime)  -- ���س⵵ ��� ����
			and			shop_vcode = @shop_code
			group by	year(sale_date), month(sale_date)
			union all
			select		year(sale_date), month(sale_date), sum(sales) month_sum
			from		tbl_ap_sales
			where		sale_date >= cast('2006-01-01' as datetime) and sale_date < cast('2007-01-01' as datetime)
			and			shop_vcode = 5893 -- ����(��)=5893 ���� // 2006�⿡�� ����(��) �����͸� �ִ�.
			group by	year(sale_date), month(sale_date)
		) tmp_tbl_mid
		group by as_date_year
		order by as_date_year desc
	else
		select
			as_date_year
		,	isnull(sum(case when as_date_month = 1 then month_sum end),0) as month_1
		,	isnull(sum(case when as_date_month = 2 then month_sum end),0) as month_2
		,	isnull(sum(case when as_date_month = 3 then month_sum end),0) as month_3
		,	isnull(sum(case when as_date_month = 4 then month_sum end),0) as month_4
		,	isnull(sum(case when as_date_month = 5 then month_sum end),0) as month_5
		,	isnull(sum(case when as_date_month = 6 then month_sum end),0) as month_6
		,	isnull(sum(case when as_date_month = 7 then month_sum end),0) as month_7
		,	isnull(sum(case when as_date_month = 8 then month_sum end),0) as month_8
		,	isnull(sum(case when as_date_month = 9 then month_sum end),0) as month_9
		,	isnull(sum(case when as_date_month = 10 then month_sum end),0) as month_10
		,	isnull(sum(case when as_date_month = 11 then month_sum end),0) as month_11
		,	isnull(sum(case when as_date_month = 12 then month_sum end),0) as month_12
		,	sum(month_sum) as sum_year
		,	case when year(getdate()) = as_date_year  then sum(month_sum)/(month(getdate())-1) else sum(month_sum)/12 end as avg_year
		from
		(
			select		year(sale_date) as as_date_year, month(sale_date) as_date_month, sum(sales) as month_sum
			from		tbl_ap_sales
			where		sale_date >= cast('2006-01-01' as datetime)
			and			sale_date < cast(convert( varchar(10), getdate()-day(getdate())+1, 120) as datetime)  -- ���س⵵ ��� ����
			and			shop_vcode = @shop_code
			group by	year(sale_date), month(sale_date)
		) tmp_tbl_mid
		group by as_date_year
		order by as_date_year desc