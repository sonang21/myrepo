/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sales_sel_weekly_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-08 15:53:07.46
 *        Modify: 2018-05-03 17:23:34.523
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_jca_ap_report_sponsor_sales_sel_weekly_2
	@year smallint
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.08.13
	-- ��  �� : ap �ֺ� �ֹ��� ����Ʈ
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------	
	*/	

	select	shop_name,
			datepart(ww, sale_date) as weekofyear,
			sum(sales) as sum_sales
	into	#tbl_groupby_weekofyear_2
	from	tbl_ap_sales a inner join  shoplist b on a.shop_vcode = b.shop_vcode
	where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
	and		sale_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
	and		shop_apflag = '5'
	group by b.shop_name, datepart(ww, sale_date)
	having sum(sales) is not null


	If @year = year(getdate()) -- �ݳ��� Ȯ���ϴ� ���, ���� ����ó��
		delete from #TBL_GROUPBY_WEEKOFYEAR_2 where weekofyear > datepart(ww, getdate())-1


	select	shop_name, '�����' data_name,
			sum(case when weekofyear = 1 then sum_sales end) as	weekofyear1,
			sum(case when weekofyear = 2 then sum_sales end) as	weekofyear2,
			sum(case when weekofyear = 3 then sum_sales end) as	weekofyear3,
			sum(case when weekofyear = 4 then sum_sales end) as	weekofyear4,
			sum(case when weekofyear = 5 then sum_sales end) as	weekofyear5,
			sum(case when weekofyear = 6 then sum_sales end) as	weekofyear6,
			sum(case when weekofyear = 7 then sum_sales end) as	weekofyear7,
			sum(case when weekofyear = 8 then sum_sales end) as	weekofyear8,
			sum(case when weekofyear = 9 then sum_sales end) as	weekofyear9,
			sum(case when weekofyear = 10 then sum_sales end) as	weekofyear10,
			sum(case when weekofyear = 11 then sum_sales end) as	weekofyear11,
			sum(case when weekofyear = 12 then sum_sales end) as	weekofyear12,
			sum(case when weekofyear = 13 then sum_sales end) as	weekofyear13,
			sum(case when weekofyear = 14 then sum_sales end) as	weekofyear14,
			sum(case when weekofyear = 15 then sum_sales end) as	weekofyear15,
			sum(case when weekofyear = 16 then sum_sales end) as	weekofyear16,
			sum(case when weekofyear = 17 then sum_sales end) as	weekofyear17,
			sum(case when weekofyear = 18 then sum_sales end) as	weekofyear18,
			sum(case when weekofyear = 19 then sum_sales end) as	weekofyear19,
			sum(case when weekofyear = 20 then sum_sales end) as	weekofyear20,
			sum(case when weekofyear = 21 then sum_sales end) as	weekofyear21,
			sum(case when weekofyear = 22 then sum_sales end) as	weekofyear22,
			sum(case when weekofyear = 23 then sum_sales end) as	weekofyear23,
			sum(case when weekofyear = 24 then sum_sales end) as	weekofyear24,
			sum(case when weekofyear = 25 then sum_sales end) as	weekofyear25,
			sum(case when weekofyear = 26 then sum_sales end) as	weekofyear26,
			sum(case when weekofyear = 27 then sum_sales end) as	weekofyear27,
			sum(case when weekofyear = 28 then sum_sales end) as	weekofyear28,
			sum(case when weekofyear = 29 then sum_sales end) as	weekofyear29,
			sum(case when weekofyear = 30 then sum_sales end) as	weekofyear30,
			sum(case when weekofyear = 31 then sum_sales end) as	weekofyear31,
			sum(case when weekofyear = 32 then sum_sales end) as	weekofyear32,
			sum(case when weekofyear = 33 then sum_sales end) as	weekofyear33,
			sum(case when weekofyear = 34 then sum_sales end) as	weekofyear34,
			sum(case when weekofyear = 35 then sum_sales end) as	weekofyear35,
			sum(case when weekofyear = 36 then sum_sales end) as	weekofyear36,
			sum(case when weekofyear = 37 then sum_sales end) as	weekofyear37,
			sum(case when weekofyear = 38 then sum_sales end) as	weekofyear38,
			sum(case when weekofyear = 39 then sum_sales end) as	weekofyear39,
			sum(case when weekofyear = 40 then sum_sales end) as	weekofyear40,
			sum(case when weekofyear = 41 then sum_sales end) as	weekofyear41,
			sum(case when weekofyear = 42 then sum_sales end) as	weekofyear42,
			sum(case when weekofyear = 43 then sum_sales end) as	weekofyear43,
			sum(case when weekofyear = 44 then sum_sales end) as	weekofyear44,
			sum(case when weekofyear = 45 then sum_sales end) as	weekofyear45,
			sum(case when weekofyear = 46 then sum_sales end) as	weekofyear46,
			sum(case when weekofyear = 47 then sum_sales end) as	weekofyear47,
			sum(case when weekofyear = 48 then sum_sales end) as	weekofyear48,
			sum(case when weekofyear = 49 then sum_sales end) as	weekofyear49,
			sum(case when weekofyear = 50 then sum_sales end) as	weekofyear50,
			sum(case when weekofyear = 51 then sum_sales end) as	weekofyear51,
			sum(case when weekofyear = 52 then sum_sales end) as	weekofyear52,
			sum(case when weekofyear = 53 then sum_sales end) as	weekofyear53,
			sum(sum_sales) as week_sum,
			avg(sum_sales) as week_avg
	from #tbl_groupby_weekofyear_2
	group by shop_name

