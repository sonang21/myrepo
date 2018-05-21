/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_fee_list_sum_monthly_enuri_promotion_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 17:58:51.137
 *        Modify: 2018-05-03 17:23:34.75
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_fee_list_sum_monthly_enuri_promotion_v3]
	@year	smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : AP 월별 주문액 리스트 합계
	-- 실  행 : [UDP_JCA_AP_REPORT_FEE_LIST_SUM_MONTHLY_ENURI] 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	select	'합계(프)'  as shop_name,
			sum([1월]),sum([2월]),sum([3월]),sum([4월]),sum([5월]),sum( [6월]),
			sum([7월]),sum([8월]),sum([9월]),sum([10월]),sum([11월]),sum([12월]),
			sum(sum_fee), sum(sum_fee)/max(avg_cnt) as avg_fee
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
						sum(fee) as sum_fee,  count(*) as avg_cnt
				from	tbl_ap_fee_promotion
				where	fee_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		fee_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				and		sale_flag = @sale_flag
				group by shop_vcode
				having sum(fee) is not null

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)--(a.shop_apflag = '1')
	having sum(sum_fee) is not null
