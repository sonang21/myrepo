/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_ORD_LIST_SUM_MONTHLY_ENURI_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 15:58:48.96
 *        Modify: 2018-05-03 17:23:34.277
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_ORD_LIST_SUM_MONTHLY_ENURI_2]
	@YEAR	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.11
	-- ��  �� : AP ���� �ֹ��� ����Ʈ �հ�
	-- ��  �� : UDP_JCA_AP_REPORT_MONTHLY_ORD_SUM 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	2010.06.04		wookki25		and AS_DATE_MONTH < datepart(mm, getdate())  �߰�
									���� �������� ���� �����ʹ� �������� �ʴ´�.
	*/
	select	(case when num = 1 then '�հ�' else '�հ�(��)' end) as shop_name,
			sum(case sale_month when 1 then sum_sales end) as '1��',
			sum(case sale_month when 2 then sum_sales end) as '2��',
			sum(case sale_month when 3 then sum_sales end) as '3��',
			sum(case sale_month when 4 then sum_sales end) as '4��',
			sum(case sale_month when 5 then sum_sales end) as '5��',
			sum(case sale_month when 6 then sum_sales end) as '6��',
			sum(case sale_month when 7 then sum_sales end) as '7��',
			sum(case sale_month when 8 then sum_sales end) as '8��',
			sum(case sale_month when 9 then sum_sales end) as '9��',
			sum(case sale_month when 10 then sum_sales end) as '10��',
			sum(case sale_month when 11 then sum_sales end) as '11��',
			sum(case sale_month when 12 then sum_sales end) as '12��',
			sum(sum_sales) as sum_sales, avg(sum_sales) avg_sales
	from
	(
		select copy_t.num, sale_month, sum(sum_sales) as sum_sales
		from
		(
			select	shop_name, a.shop_vcode, sale_month, sum_sales
			from	(
						select shop_vcode, month(sale_date) as sale_month, sum(sales) as sum_sales
						from tbl_ap_sales
						where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
						and		sale_date <
									case when year(getdate())=@year then
										cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
									else
										dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
									end
						and		shop_vcode not in (4861,3368,724,4859,4856,5137,4857)
						group by shop_vcode, month(sale_date)
					)a
						inner join
					shoplist b
						on a.shop_vcode = b.shop_vcode
			where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)--(shop_apflag = '1' or a.shop_vcode in (5893,1733,6052,1719))
		) c
				cross join
		(
			select 1 as num union select 2
		) copy_t
		where	c.shop_vcode not in (
			case when copy_t.num = 1 then 5893 else 4027 end,
			case when copy_t.num = 1 then 1733 else 536 end,
			case when copy_t.num = 1 then 6052 else 5910 end,
			case when copy_t.num = 1 then 1719 else 55 end
		)
		group by copy_t.num, sale_month
		having sum(sum_sales) is not null
	) d
	group by num
	having sum(sum_sales) IS NOT NULL
	order by num