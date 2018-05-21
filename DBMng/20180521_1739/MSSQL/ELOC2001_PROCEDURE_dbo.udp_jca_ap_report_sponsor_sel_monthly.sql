/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sel_monthly
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-23 16:14:00.16
 *        Modify: 2018-05-03 17:23:36.037
 *        Backup: 20180521_1739
 ************************************************************************* */


create PROC udp_jca_ap_report_sponsor_sel_monthly
	@sale_date smalldatetime
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.08.13
	-- ��  �� : ap ���� �ֹ��� ����Ʈ
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------	
	*/	

	select	shop_vcode
	,		data_opt
	,		datepart(mm, sale_date) as mmofyear
	,		sum(sales) as sales
	,		sum(exp_cnt) as exp_cnt
	,		sum(hit_cnt) as hit_cnt
	into	#tbl_groupby_month
	from	tbl_ap_sales_sponsor
	where	sale_date >=@sale_date
	and		sale_date<dateadd(yy, 1, @sale_date)
	group by shop_vcode, data_opt, datepart(mm, sale_date)
	having sum(sales) is not null


	If year(@sale_date) = year(getdate()) -- �ݳ��� Ȯ���ϴ� ���, �ݿ� ����ó��
		delete from #tbl_groupby_month where mmofyear > datepart(mm, getdate())-1

	select shop_name, data_opt,
		case num 
				when 1 then '�����' 
				when 2 then '�����' 
				when 3 then 'Ŭ����' 
				when 4 then 'CPC' 
				when 5 then 'CTR(%)' 
 		end as hit_name 
		, [1��], [2��], [3��], [4��], [5��], [6��], [7��], [8��], [9��]
		, [10��], [11��], [12��]
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		data_opt
		,		num
		,		[1��]  = max(case when mmofyear =  1 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2��]  = max(case when mmofyear =  2 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3��]  = max(case when mmofyear =  3 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4��]  = max(case when mmofyear =  4 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5��]  = max(case when mmofyear =  5 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6��]  = max(case when mmofyear =  6 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7��]  = max(case when mmofyear =  7 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8��]  = max(case when mmofyear =  8 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9��]  = max(case when mmofyear =  9 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10��] = max(case when mmofyear = 10 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11��] = max(case when mmofyear = 11 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12��] = max(case when mmofyear = 12 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then null when 5 then null end)	
		,		[day_avg] = avg(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end)
		from #tbl_groupby_month cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5) bb
		group by shop_vcode, data_opt, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, data_opt, num
