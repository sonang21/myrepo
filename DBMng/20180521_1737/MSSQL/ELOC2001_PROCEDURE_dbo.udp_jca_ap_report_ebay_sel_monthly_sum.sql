/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ebay_sel_monthly_sum
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-16 10:20:33.463
 *        Modify: 2018-05-03 17:23:35.53
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_ebay_sel_monthly_sum
	@sale_date smalldatetime
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2013-08-16
	-- ��  �� : �̺��� ����,Ŭ�� ��ȸ
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------	
	*/	

	select	datepart(mm, sale_date) as mmofyear
	,		sum(sales) as sales
	,		sum(sale_cnt) as sale_cnt
	,		sum(exp_cnt) as exp_cnt
	,		sum(hit_cnt) as hit_cnt
	into	#tbl_groupby_month
	from	tbl_ap_sales_ebay
	where	sale_date >=@sale_date
	and		sale_date<dateadd(yy, 1, @sale_date)
	group by datepart(mm, sale_date)
	having sum(sales) is not null


	If year(@sale_date) = year(getdate()) -- �ݳ��� Ȯ���ϴ� ���, �ݿ� ����ó��
		delete from #tbl_groupby_month where mmofyear > datepart(mm, getdate())-1

	select shop_name, data_opt,
		case num 
				when 1 then '�����' 
				when 2 then '��ܰ�'
				when 3 then '�����' 
				when 4 then 'Ŭ����' 
				when 5 then 'CPC' 
				when 6 then 'CTR(%)' 
 		end as hit_name 
		, [1��], [2��], [3��], [4��], [5��], [6��], [7��], [8��], [9��]
		, [10��], [11��], [12��]
		, day_sum, day_avg
		from 
		(
		select	'��ü' as shop_name
		,		0 data_opt
		,		num
		,		[1��]  = sum(case when mmofyear =  1 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2��]  = sum(case when mmofyear =  2 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3��]  = sum(case when mmofyear =  3 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4��]  = sum(case when mmofyear =  4 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5��]  = sum(case when mmofyear =  5 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6��]  = sum(case when mmofyear =  6 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7��]  = sum(case when mmofyear =  7 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8��]  = sum(case when mmofyear =  8 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9��]  = sum(case when mmofyear =  9 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10��] = sum(case when mmofyear = 10 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11��] = sum(case when mmofyear = 11 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12��] = sum(case when mmofyear = 12 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then null when 3 then exp_cnt when 4 then hit_cnt when 5 then null when 6 then null end)	
		,		[day_avg] = avg(case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end)
		from #tbl_groupby_month cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5union all select 6) bb
		group by num
		) a 
		order by num

