/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ebay_sel_weekly
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-16 09:45:58.463
 *        Modify: 2018-05-03 17:23:35.453
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_ebay_sel_weekly
	@sale_date smalldatetime
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 累己磊 : wookki25 / 2013-08-16
	-- 汲  疙 : 捞海捞 畴免,努腐 炼雀
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 荐沥郴开
	-- ----------------------------------------------------------------------------------
	/*
	荐沥老:			荐沥磊:			荐沥郴侩:
	----------		-----------		-----------------------------------------------------	
	*/	

	select	shop_vcode
	,		data_opt
	,		datepart(ww, sale_date) as weekofyear
	,		sum(sales) as sales
	,		sum(sale_cnt) as sale_cnt
	,		sum(exp_cnt) as exp_cnt
	,		sum(hit_cnt) as hit_cnt
	into	#tbl_groupby_weekofyear_2
	from	tbl_ap_sales_ebay
	where	sale_date >=@sale_date
	and		sale_date<dateadd(yy, 1, @sale_date)
	group by shop_vcode, data_opt, datepart(ww, sale_date)
	having sum(sales) is not null

	If year(@sale_date) = year(getdate()) -- 陛斥阑 犬牢窍绰 版快, 陛林 力寇贸府
		delete from #TBL_GROUPBY_WEEKOFYEAR_2 where weekofyear > datepart(ww, getdate())-1

	select shop_name, data_opt,
		case num 
				when 1 then '概免咀' 
				when 2 then '乞窜啊'
				when 3 then '畴免荐' 
				when 4 then '努腐荐' 
				when 5 then 'CPC' 
				when 6 then 'CTR(%)' 
 		end as hit_name 
		, [1林], [2林], [3林], [4林], [5林], [6林], [7林], [8林], [9林]
		, [10林], [11林], [12林], [13林], [14林], [15林], [16林], [17林], [18林], [19林]
		, [20林], [21林], [22林], [23林], [24林], [25林], [26林], [27林], [28林], [29林]
		, [30林], [31林], [32林], [33林], [34林], [35林], [36林], [37林], [38林], [39林]
		, [40林], [41林], [42林], [43林], [44林], [45林], [46林], [47林], [48林], [49林]
		, [50林], [51林], [52林], [53林]
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		data_opt
		,		num
		,		[1林]  = max(case when weekofyear =  1 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[2林]  = max(case when weekofyear =  2 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[3林]  = max(case when weekofyear =  3 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[4林]  = max(case when weekofyear =  4 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[5林]  = max(case when weekofyear =  5 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[6林]  = max(case when weekofyear =  6 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[7林]  = max(case when weekofyear =  7 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[8林]  = max(case when weekofyear =  8 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[9林]  = max(case when weekofyear =  9 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[10林] = max(case when weekofyear = 10 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[11林] = max(case when weekofyear = 11 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[12林] = max(case when weekofyear = 12 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[13林] = max(case when weekofyear = 13 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[14林] = max(case when weekofyear = 14 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[15林] = max(case when weekofyear = 15 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[16林] = max(case when weekofyear = 16 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[17林] = max(case when weekofyear = 17 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[18林] = max(case when weekofyear = 18 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[19林] = max(case when weekofyear = 19 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[20林] = max(case when weekofyear = 20 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[21林] = max(case when weekofyear = 21 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[22林] = max(case when weekofyear = 22 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[23林] = max(case when weekofyear = 23 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[24林] = max(case when weekofyear = 24 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[25林] = max(case when weekofyear = 25 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[26林] = max(case when weekofyear = 26 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[27林] = max(case when weekofyear = 27 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[28林] = max(case when weekofyear = 28 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[29林] = max(case when weekofyear = 29 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[30林] = max(case when weekofyear = 30 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[31林] = max(case when weekofyear = 31 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[32林] = max(case when weekofyear = 32 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[33林] = max(case when weekofyear = 33 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[34林] = max(case when weekofyear = 34 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[35林] = max(case when weekofyear = 35 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[36林] = max(case when weekofyear = 36 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[37林] = max(case when weekofyear = 37 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[38林] = max(case when weekofyear = 38 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[39林] = max(case when weekofyear = 39 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[40林] = max(case when weekofyear = 40 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[41林] = max(case when weekofyear = 41 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[42林] = max(case when weekofyear = 42 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[43林] = max(case when weekofyear = 43 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[44林] = max(case when weekofyear = 44 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[45林] = max(case when weekofyear = 45 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[46林] = max(case when weekofyear = 46 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[47林] = max(case when weekofyear = 47 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[48林] = max(case when weekofyear = 48 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[49林] = max(case when weekofyear = 49 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[50林] = max(case when weekofyear = 50 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[51林] = max(case when weekofyear = 51 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[52林] = max(case when weekofyear = 52 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[53林] = max(case when weekofyear = 53 then case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end end) 
		,		[day_sum] = sum(case num when 1 then sales when 2 then null when 3 then exp_cnt when 4 then hit_cnt when 5 then null when 6 then null end)	
		,		[day_avg] = avg(case num when 1 then sales when 2 then round(sales/sale_cnt,0) when 3 then exp_cnt when 4 then hit_cnt when 5 then round(sales/hit_cnt,0) when 6 then round(hit_cnt*100.0/exp_cnt,2) end)
		from #tbl_groupby_weekofyear_2 cross join (select 1 num union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) bb
		group by shop_vcode, data_opt, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, data_opt, num

