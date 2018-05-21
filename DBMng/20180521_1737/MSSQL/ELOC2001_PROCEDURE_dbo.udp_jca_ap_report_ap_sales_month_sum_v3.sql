/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ap_sales_month_sum_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-22 11:18:45.217
 *        Modify: 2018-05-03 17:23:36.11
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ap_sales_month_sum_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2014.07.22
	-- ��  �� : ap ���� ������ ����Ʈ
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/
	select	'�հ�'  as shop_name,
			sum([1��]),sum([2��]),sum([3��]),sum([4��]),sum([5��]),sum( [6��]),
			sum([7��]),sum([8��]),sum([9��]),sum([10��]),sum([11��]),sum([12��]),
			sum(sum_sale), sum(sum_sale)/max(avg_cnt) as avg_sale
	from	shoplist a
				inner join
			(
				select	shop_vcode,
						sum(case month(sale_date) when 1 then sales end) as '1��',
						sum(case month(sale_date) when 2 then sales end) as '2��',
						sum(case month(sale_date) when 3 then sales end) as '3��',
						sum(case month(sale_date) when 4 then sales end) as '4��',
						sum(case month(sale_date) when 5 then sales end) as '5��',
						sum(case month(sale_date) when 6 then sales end) as '6��',
						sum(case month(sale_date) when 7 then sales end) as '7��',
						sum(case month(sale_date) when 8 then sales end) as '8��',
						sum(case month(sale_date) when 9 then sales end) as '9��',
						sum(case month(sale_date) when 10 then sales end) as '10��',
						sum(case month(sale_date) when 11 then sales end) as '11��',
						sum(case month(sale_date) when 12 then sales end) as '12��',
						sum(sales) as sum_sale,  count(*) as avg_cnt
				from	tbl_ap_sales_month
				where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		sale_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				and		sale_flag = @sale_flag
				group by shop_vcode
				having sum(sales) is not null

			) b
				on a.shop_vcode = b.shop_vcode
--	where	(a.shop_apflag = '1')





