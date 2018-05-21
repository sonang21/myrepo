/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_fee_list_monthly_enuri_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 17:30:16.567
 *        Modify: 2018-05-03 17:23:34.303
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_fee_list_monthly_enuri_2]
	@year	smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : ap 월별 수수료 리스트
	-- 실  행 : udp_jca_ap_report_fee_list_monthly_enuri 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	select	a.shop_name,
			[1월],[2월], [3월], [4월], [5월], [6월], [7월], [8월], [9월], [10월],[11월],[12월],
			sum_fee, avg_fee
	from	shoplist a
				inner join
			(
				select	shop_vcode,
						sum(case month(fee_date) when 1 then fee end) as '1월',
						sum(case month(fee_date) when 2 then fee end) as '2월',
						sum(case month(fee_date) when 3 then fee end) as '3월',
						sum(case month(fee_date) when 4 then fee end) as '4월',
						sum(case month(fee_date) when 5 then fee end) as '5월',
						sum(case month(fee_date) when 6 then fee end) as '6월',
						sum(case month(fee_date) when 7 then fee end) as '7월',
						sum(case month(fee_date) when 8 then fee end) as '8월',
						sum(case month(fee_date) when 9 then fee end) as '9월',
						sum(case month(fee_date) when 10 then fee end) as '10월',
						sum(case month(fee_date) when 11 then fee end) as '11월',
						sum(case month(fee_date) when 12 then fee end) as '12월',
						sum(fee) as sum_fee,  avg(fee) avg_fee
				from	tbl_ap_fee
				where	fee_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		fee_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				group by shop_vcode

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
	and		sum_fee is not null
	order by sum_fee desc

