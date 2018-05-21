/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_fee_list_monthly_enuri_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 18:01:51.937
 *        Modify: 2018-05-03 17:23:34.763
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_fee_list_monthly_enuri_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.11
	-- ��  �� : ap ���� ������ ����Ʈ
	-- ��  �� : udp_jca_ap_report_fee_list_monthly_enuri 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/
	select	a.shop_name,
			[1��],[2��], [3��], [4��], [5��], [6��], [7��], [8��], [9��], [10��],[11��],[12��],
			sum_fee, avg_fee
			, a.display_order
	from	( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) a
				inner join
			(
				select	shop_vcode,
						sum(case month(fee_date) when 1 then fee end) as '1��',
						sum(case month(fee_date) when 2 then fee end) as '2��',
						sum(case month(fee_date) when 3 then fee end) as '3��',
						sum(case month(fee_date) when 4 then fee end) as '4��',
						sum(case month(fee_date) when 5 then fee end) as '5��',
						sum(case month(fee_date) when 6 then fee end) as '6��',
						sum(case month(fee_date) when 7 then fee end) as '7��',
						sum(case month(fee_date) when 8 then fee end) as '8��',
						sum(case month(fee_date) when 9 then fee end) as '9��',
						sum(case month(fee_date) when 10 then fee end) as '10��',
						sum(case month(fee_date) when 11 then fee end) as '11��',
						sum(case month(fee_date) when 12 then fee end) as '12��',
						sum(fee) as sum_fee,  avg(fee) avg_fee
				from	tbl_ap_fee
				where	fee_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		fee_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				and		sale_flag = @sale_flag
				group by shop_vcode

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
	and		sum_fee is not null
	order by a.display_order, sum_fee desc

