/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_monthly_enuri_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 15:07:55.123
 *        Modify: 2018-05-03 17:23:34.27
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_monthly_enuri_2]
	@year	smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.11
	-- ��  �� : ap ���� �ֹ��� ����Ʈ
	-- ��  �� : udp_jca_ap_report_monthly_ord_list 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	2010.06.04		wookki25		and as_date_month < datepart(mm, getdate())  �߰�
									���� �������� ���� �����ʹ� �������� �ʴ´�.
	*/
	select	case b.shop_vcode
					when 1733 then 'G����(��)'
					when 5893 then '����(��)'
					when 1719 then '������ũ(��)'
					when 6052 then '11����(��)'
					else a.shop_name
			end as shop_name,
			[1��],[2��], [3��], [4��], [5��], [6��], [7��], [8��], [9��], [10��],[11��],[12��],
			sum_sales, avg_sales
	from	shoplist a
				inner join
			(
			select c.*, isnull(d.order_sum_sales,c.sum_sales) as order_sum_sales
			from
				(
				select	shop_vcode,
						sum(case sale_month when 1 then sum_sales end) as '1��',
						sum(case sale_month  when 2 then sum_sales end) as '2��',
						sum(case sale_month  when 3 then sum_sales end) as '3��',
						sum(case sale_month  when 4 then sum_sales end) as '4��',
						sum(case sale_month  when 5 then sum_sales end) as '5��',
						sum(case sale_month  when 6 then sum_sales end) as '6��',
						sum(case sale_month when 7 then sum_sales end) as '7��',
						sum(case sale_month when 8 then sum_sales end) as '8��',
						sum(case sale_month when 9 then sum_sales end) as '9��',
						sum(case sale_month when 10 then sum_sales end) as '10��',
						sum(case sale_month when 11 then sum_sales end) as '11��',
						sum(case sale_month when 12 then sum_sales end) as '12��',
						sum(sum_sales) as sum_sales, avg(sum_sales) avg_sales
				from
					(
					select	shop_vcode, month(sale_date) as sale_month, sum(sales) as sum_sales
					from	tbl_ap_sales
					where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
					and		sale_date <
									case when year(getdate())=@year then
										cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
									else
										dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
									end
					and		shop_vcode not in (4861,3368,724,4859,4856,5137,4857)
					group by shop_vcode, month(sale_date)
					) e
				group by shop_vcode

				) c
					left outer join
				(
				select
					case shop_vcode
						when 536 then 1733
						when 4027 then 5893
						when 5910 then 6052
						when 55 then 1719
						end as shop_vcode , sum(sales) as order_sum_sales
				from	tbl_ap_sales
				where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		sale_date <
									case when year(getdate())=@year then
										cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
									else
										dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
									end
				and		shop_vcode in (536, 4027, 55, 5910)
				group by shop_vcode
				) d
					on c.shop_vcode = d.shop_vcode

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop) --(a.shop_apflag = '1' or b.shop_vcode in (5893,1733,6052,1719))
	and		sum_sales is not null
	order by b.order_sum_sales desc, b.shop_vcode asc
