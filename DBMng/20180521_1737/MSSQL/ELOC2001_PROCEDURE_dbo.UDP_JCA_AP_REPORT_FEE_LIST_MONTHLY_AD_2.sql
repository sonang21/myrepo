/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 16:01:53.937
 *        Modify: 2018-05-03 17:23:34.57
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE PROC [dbo].[UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD_2]
	@YEAR	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2008.03.11
	-- ��  �� : AP ���� ������ ����Ʈ
	-- ��  �� : UDP_JCA_AP_REPORT_FEE_LIST_MONTHLY_AD 2008
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	select	shop_name,
			sum(case fee_month when 1 then sum_fee end) as '1��',
			sum(case fee_month  when 2 then sum_fee end) as '2��',
			sum(case fee_month  when 3 then sum_fee end) as '3��',
			sum(case fee_month  when 4 then sum_fee end) as '4��',
			sum(case fee_month  when 5 then sum_fee end) as '5��',
			sum(case fee_month  when 6 then sum_fee end) as '6��',
			sum(case fee_month when 7 then sum_fee end) as '7��',
			sum(case fee_month when 8 then sum_fee end) as '8��',
			sum(case fee_month when 9 then sum_fee end) as '9��',
			sum(case fee_month when 10 then sum_fee end) as '10��',
			sum(case fee_month when 11 then sum_fee end) as '11��',
			sum(case fee_month when 12 then sum_fee end) as '12��',
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
