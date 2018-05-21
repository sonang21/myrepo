/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_LIST_SUM_MONTHLY_ENURI_promotion
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-05-03 14:12:05.497
 *        Modify: 2018-05-03 17:23:34.43
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_FEE_LIST_SUM_MONTHLY_ENURI_promotion]
	@YEAR	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.11
	-- ��  �� : AP ���� �ֹ��� ����Ʈ �հ�
	-- ��  �� : [UDP_JCA_AP_REPORT_FEE_LIST_SUM_MONTHLY_ENURI] 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/
	select	'�հ�(��)'  as shop_name,
			sum([1��]),sum([2��]),sum([3��]),sum([4��]),sum([5��]),sum( [6��]),
			sum([7��]),sum([8��]),sum([9��]),sum([10��]),sum([11��]),sum([12��]),
			sum(sum_fee), sum(sum_fee)/max(avg_cnt) as avg_fee
	from	shoplist a
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
						sum(fee) as sum_fee,  count(*) as avg_cnt
				from	tbl_ap_fee_promotion
				where	fee_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
				and		fee_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
				group by shop_vcode
				having sum(fee) is not null

			) b
				on a.shop_vcode = b.shop_vcode
	where	a.shop_vcode in (select shop_vcode from tbl_ap_sales_shop)--(a.shop_apflag = '1')
	having sum(sum_fee) is not null
