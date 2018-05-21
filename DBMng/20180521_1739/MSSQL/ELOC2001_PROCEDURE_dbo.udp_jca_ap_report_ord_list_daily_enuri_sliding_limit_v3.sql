/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_sliding_limit_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-14 11:25:36.89
 *        Modify: 2018-05-03 17:23:35.173
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ord_list_daily_enuri_sliding_limit_v3
	@sdate datetime
,	@sale_flag char(1)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-05-18
	-- ��  �� : ������ ���� ������ �����̵� ���ѱݾ�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	/*
	������ ����ó�� 2012.05.17 �����
	���� �Ⱓ�� ���� 26�� ~ ��� 25�� �̶�.
	���� �Ⱓ�� ���������� ���.
	*/
	-- gshop(75), cjmall(806) ����ó�� 2012.07.10
	-- gmarket 2013.03.01���� ������ 1��~���Ϸ� ���� ����. ����� ��û
	declare @sdate_ex datetime
	set @sdate_ex = dateadd(d, 25, dateadd(m, -1, @sdate)) -- ���� 26��

	create table #tmp_ex_shop_sales(shop_vcode int, ex_sales money)
	if @sdate <= cast('2013-02-28' as datetime) begin
		-- �ش���� �����̵� �ݾ׿��� �������� ���������� �����̱⶧���� 
		-- ���̳ʽ� ó���ؾ��ϴ� ������� ���Ѵ�.
		insert #tmp_ex_shop_sales
		select shop_vcode, sum(sales) as ex_sales
		from tbl_ap_sales 		
		where	sale_date >=@sdate_ex
		and		sale_date < @sdate
		and		shop_vcode in (1733, 536, 75, 806) 
		and		sale_flag = @sale_flag
		group by shop_vcode

	end else begin
		insert #tmp_ex_shop_sales
		select shop_vcode, sum(sales) as ex_sales
		from tbl_ap_sales 		
		where	sale_date >=@sdate_ex
		and		sale_date < @sdate
		and		shop_vcode in (75, 806) 
		and		sale_flag = @sale_flag
		group by shop_vcode
	end

	select case when a.shop_vcode = 1733 then 'G����(��)' else a.shop_name end shop_name, a.sum_limit - isnull(b.ex_sales, 0), b.ex_sales
	from
	(
		--  �ش�� �����̵� �ݾ� ��������
		select d.shop_name, d.shop_vcode, sum_limit 
		from tbl_ap_sales_fee_rate_sliding c inner join shoplist d on c.shop_vcode = d.shop_vcode
		where @sdate between s_date and e_date
		and		sale_flag = @sale_flag
	) a 
		left outer join 
	(

		-- �������� �ſ� 1�� ����(=���� �Ϲݱ�)�� ��� 
		-- ������~1�ϱ��� ������� �����´�.
		select * from #tmp_ex_shop_sales
	) b
		on a.shop_vcode = b.shop_vcode



