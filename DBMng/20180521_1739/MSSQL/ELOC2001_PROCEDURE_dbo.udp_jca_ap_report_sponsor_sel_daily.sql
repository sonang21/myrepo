/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sel_daily
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 10:09:43.06
 *        Modify: 2018-05-03 17:23:35.617
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_sponsor_sel_daily
	@sale_date smalldatetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-08-11
	-- ��  �� : ��������ũ ����,Ŭ�� ��ȸ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	select shop_name, data_opt,
		case num 
				when 1 then '�����' 
				when 2 then '�����' 
				when 3 then 'Ŭ����' 
				when 4 then 'CPC' 
				when 5 then 'CTR(%)' 
 		end as hit_name, 
		 isnull([1��],0),isnull([2��],0),isnull([3��],0),isnull([4��],0),isnull([5��],0),isnull([6��],0),isnull([7��],0),isnull([8��],0),isnull([9��],0),isnull([10��],0)
		,isnull([11��],0),isnull([12��],0),isnull([13��],0),isnull([14��],0),isnull([15��],0),isnull([16��],0),isnull([17��],0),isnull([18��],0),isnull([19��],0),isnull([20��],0)
		,isnull([21��],0),isnull([22��],0),isnull([23��],0),isnull([24��],0),isnull([25��],0),isnull([26��],0),isnull([27��],0),isnull([28��],0),isnull([29��],0),isnull([30��],0),isnull([31��],0)
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		data_opt
		,		num
		,		[1��]  = max(case when day(sale_date) =  1 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2��]  = max(case when day(sale_date) =  2 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3��]  = max(case when day(sale_date) =  3 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4��]  = max(case when day(sale_date) =  4 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5��]  = max(case when day(sale_date) =  5 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6��]  = max(case when day(sale_date) =  6 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7��]  = max(case when day(sale_date) =  7 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8��]  = max(case when day(sale_date) =  8 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9��]  = max(case when day(sale_date) =  9 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10��] = max(case when day(sale_date) = 10 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11��] = max(case when day(sale_date) = 11 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12��] = max(case when day(sale_date) = 12 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[13��] = max(case when day(sale_date) = 13 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[14��] = max(case when day(sale_date) = 14 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[15��] = max(case when day(sale_date) = 15 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[16��] = max(case when day(sale_date) = 16 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[17��] = max(case when day(sale_date) = 17 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[18��] = max(case when day(sale_date) = 18 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[19��] = max(case when day(sale_date) = 19 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[20��] = max(case when day(sale_date) = 20 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[21��] = max(case when day(sale_date) = 21 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[22��] = max(case when day(sale_date) = 22 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[23��] = max(case when day(sale_date) = 23 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[24��] = max(case when day(sale_date) = 24 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[25��] = max(case when day(sale_date) = 25 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[26��] = max(case when day(sale_date) = 26 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[27��] = max(case when day(sale_date) = 27 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[28��] = max(case when day(sale_date) = 28 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[29��] = max(case when day(sale_date) = 29 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[30��] = max(case when day(sale_date) = 30 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[31��] = max(case when day(sale_date) = 31 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then null when 5 then null end)	
		,		[day_avg] = case when sum(exp_cnt)=0 then 0 else avg(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end) end
		from tbl_ap_sales_sponsor cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5) bb
		where sale_date >= @sale_date and sale_date < dateadd(m, 1, @sale_date)
		group by shop_vcode, data_opt, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, data_opt, num


