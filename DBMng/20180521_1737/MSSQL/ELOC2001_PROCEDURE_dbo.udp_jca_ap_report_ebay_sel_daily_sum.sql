/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ebay_sel_daily_sum
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-16 08:35:52.77
 *        Modify: 2018-05-03 17:23:35.433
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_ebay_sel_daily_sum
	@sale_date smalldatetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 累己磊 : wookki25 / 2013-08-16
	-- 汲  疙 : 捞海捞 畴免,努腐 炼雀
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 荐沥郴开
	-- ----------------------------------------------
	/* 
	荐沥老:			荐沥磊:			荐沥郴侩:
	-------------------------------------------------
	*/

	select shop_name, data_opt,
		case num 
				when 1 then '概免咀' 
				when 2 then '乞窜啊'
				when 3 then '畴免荐' 
				when 4 then '努腐荐' 
				when 5 then 'CPC' 
				when 6 then 'CTR(%)' 
 		end as hit_name, 
		 isnull([1老],0),isnull([2老],0),isnull([3老],0),isnull([4老],0),isnull([5老],0),isnull([6老],0),isnull([7老],0),isnull([8老],0),isnull([9老],0),isnull([10老],0)
		,isnull([11老],0),isnull([12老],0),isnull([13老],0),isnull([14老],0),isnull([15老],0),isnull([16老],0),isnull([17老],0),isnull([18老],0),isnull([19老],0),isnull([20老],0)
		,isnull([21老],0),isnull([22老],0),isnull([23老],0),isnull([24老],0),isnull([25老],0),isnull([26老],0),isnull([27老],0),isnull([28老],0),isnull([29老],0),isnull([30老],0),isnull([31老],0)
		, day_sum, day_avg
		from 
		(
		select	'傈眉' as shop_name
		,		0 as data_opt
		,		num
		,		[1老]  = sum(case when day(sale_date) =  1 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2老]  = sum(case when day(sale_date) =  2 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3老]  = sum(case when day(sale_date) =  3 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4老]  = sum(case when day(sale_date) =  4 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5老]  = sum(case when day(sale_date) =  5 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6老]  = sum(case when day(sale_date) =  6 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7老]  = sum(case when day(sale_date) =  7 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8老]  = sum(case when day(sale_date) =  8 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9老]  = sum(case when day(sale_date) =  9 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10老] = sum(case when day(sale_date) = 10 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11老] = sum(case when day(sale_date) = 11 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12老] = sum(case when day(sale_date) = 12 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[13老] = sum(case when day(sale_date) = 13 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[14老] = sum(case when day(sale_date) = 14 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[15老] = sum(case when day(sale_date) = 15 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[16老] = sum(case when day(sale_date) = 16 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[17老] = sum(case when day(sale_date) = 17 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[18老] = sum(case when day(sale_date) = 18 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[19老] = sum(case when day(sale_date) = 19 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[20老] = sum(case when day(sale_date) = 20 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[21老] = sum(case when day(sale_date) = 21 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[22老] = sum(case when day(sale_date) = 22 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[23老] = sum(case when day(sale_date) = 23 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[24老] = sum(case when day(sale_date) = 24 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[25老] = sum(case when day(sale_date) = 25 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[26老] = sum(case when day(sale_date) = 26 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[27老] = sum(case when day(sale_date) = 27 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[28老] = sum(case when day(sale_date) = 28 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[29老] = sum(case when day(sale_date) = 29 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[30老] = sum(case when day(sale_date) = 30 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[31老] = sum(case when day(sale_date) = 31 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then null when 3 then exp_cnt when 4 then hit_cnt when 5 then null when 6 then null end)	
		,		[day_avg] = case when sum(exp_cnt)=0 then 0 else avg(case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end) end
		from ( 

			select sale_date, sum(sales) sales, sum(sale_cnt) sale_cnt, sum(exp_cnt) exp_cnt, sum(hit_cnt) hit_cnt
			from tbl_ap_sales_ebay 
			where sale_date >= @sale_date and sale_date < dateadd(m, 1, @sale_date)
			group by sale_date
		) b
		cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) bb
		
		group by num
		) a 
		order by num


