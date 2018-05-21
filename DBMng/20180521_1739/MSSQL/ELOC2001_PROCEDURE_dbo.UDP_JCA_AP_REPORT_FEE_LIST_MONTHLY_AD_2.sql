/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 16:01:53.937
 *        Modify: 2018-05-03 17:23:34.57
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE PROC [dbo].[UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD_2]
	@YEAR	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.03.11
	-- 설  명 : AP 월별 수수료 리스트
	-- 실  행 : UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD 2008
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	select	shop_name,
			sum(case fee_month when 1 then sum_fee end) as '1월',
			sum(case fee_month  when 2 then sum_fee end) as '2월',
			sum(case fee_month  when 3 then sum_fee end) as '3월',
			sum(case fee_month  when 4 then sum_fee end) as '4월',
			sum(case fee_month  when 5 then sum_fee end) as '5월',
			sum(case fee_month  when 6 then sum_fee end) as '6월',
			sum(case fee_month when 7 then sum_fee end) as '7월',
			sum(case fee_month when 8 then sum_fee end) as '8월',
			sum(case fee_month when 9 then sum_fee end) as '9월',
			sum(case fee_month when 10 then sum_fee end) as '10월',
			sum(case fee_month when 11 then sum_fee end) as '11월',
			sum(case fee_month when 12 then sum_fee end) as '12월',
			sum(sum_fee) as sum_fee, avg(sum_fee) avg_fee
	from
		(
		select	shop_name, month(fee_date) as fee_month, sum(fee) as sum_fee 
		from	tbl_ap_fee a inner join  shoplist b on a.shop_vcode = b.shop_vcode
		where	fee_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
		and		fee_date <
						case when year(getdate())=@year then
							cast(cast(@year as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01' as datetime)
						else
							dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
						end
		and		shop_apflag = '5'
		group by shop_name, month(fee_date)
		) e
	group by shop_name
