/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_sel_daily
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 10:09:43.06
 *        Modify: 2018-05-03 17:23:35.617
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_sponsor_sel_daily
	@sale_date smalldatetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 累己磊 : wookki25 / 2010-08-11
	-- 汲  疙 : 胶迄辑傅农 畴免,努腐 炼雀
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
				when 2 then '畴免荐' 
				when 3 then '努腐荐' 
				when 4 then 'CPC' 
				when 5 then 'CTR(%)' 
 		end as hit_name, 
		 isnull([1老],0),isnull([2老],0),isnull([3老],0),isnull([4老],0),isnull([5老],0),isnull([6老],0),isnull([7老],0),isnull([8老],0),isnull([9老],0),isnull([10老],0)
		,isnull([11老],0),isnull([12老],0),isnull([13老],0),isnull([14老],0),isnull([15老],0),isnull([16老],0),isnull([17老],0),isnull([18老],0),isnull([19老],0),isnull([20老],0)
		,isnull([21老],0),isnull([22老],0),isnull([23老],0),isnull([24老],0),isnull([25老],0),isnull([26老],0),isnull([27老],0),isnull([28老],0),isnull([29老],0),isnull([30老],0),isnull([31老],0)
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		data_opt
		,		num
		,		[1老]  = max(case when day(sale_date) =  1 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2老]  = max(case when day(sale_date) =  2 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3老]  = max(case when day(sale_date) =  3 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4老]  = max(case when day(sale_date) =  4 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5老]  = max(case when day(sale_date) =  5 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6老]  = max(case when day(sale_date) =  6 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7老]  = max(case when day(sale_date) =  7 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8老]  = max(case when day(sale_date) =  8 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9老]  = max(case when day(sale_date) =  9 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10老] = max(case when day(sale_date) = 10 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11老] = max(case when day(sale_date) = 11 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12老] = max(case when day(sale_date) = 12 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[13老] = max(case when day(sale_date) = 13 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[14老] = max(case when day(sale_date) = 14 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[15老] = max(case when day(sale_date) = 15 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[16老] = max(case when day(sale_date) = 16 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[17老] = max(case when day(sale_date) = 17 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[18老] = max(case when day(sale_date) = 18 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[19老] = max(case when day(sale_date) = 19 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[20老] = max(case when day(sale_date) = 20 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[21老] = max(case when day(sale_date) = 21 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[22老] = max(case when day(sale_date) = 22 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[23老] = max(case when day(sale_date) = 23 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[24老] = max(case when day(sale_date) = 24 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[25老] = max(case when day(sale_date) = 25 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[26老] = max(case when day(sale_date) = 26 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[27老] = max(case when day(sale_date) = 27 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[28老] = max(case when day(sale_date) = 28 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[29老] = max(case when day(sale_date) = 29 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[30老] = max(case when day(sale_date) = 30 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[31老] = max(case when day(sale_date) = 31 then case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then null when 5 then null end)	
		,		[day_avg] = case when sum(exp_cnt)=0 then 0 else avg(case num when 1 then sales when 2 then exp_cnt when 3 then hit_cnt when 4 then round(sales/hit_cnt,0) when 5 then round(hit_cnt*100.0/exp_cnt,2) end) end
		from tbl_ap_sales_sponsor cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5) bb
		where sale_date >= @sale_date and sale_date < dateadd(m, 1, @sale_date)
		group by shop_vcode, data_opt, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, data_opt, num


