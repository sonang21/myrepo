/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_hit_sel_weekly
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-08-13 17:38:32.15
 *        Modify: 2018-05-03 17:23:35.867
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sponsor_hit_sel_weekly
	@hit_date smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
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
	select shop_name, case num when 1 then '畴免荐' when 2 then '努腐荐' end as hit_name
		,[1林] ,[2林] ,[3林] ,[4林] ,[5林] ,[6林] ,[7林] ,[8林] ,[9林] ,[10林]
		,[11林],[12林],[13林],[14林],[15林],[16林],[17林],[18林],[19林],[20林]
		,[21林],[22林],[23林],[24林],[25林],[26林],[27林],[28林],[29林],[30林]
		,[31林],[32林],[33林],[34林],[35林],[36林],[37林],[38林],[39林],[40林]
		,[41林],[42林],[43林],[44林],[45林],[46林],[47林],[48林],[49林],[50林]
		,[51林],[52林],[53林],hit_sum, hit_sum/(
	isnull(sign([1林]),0) + isnull(sign([2林]),0) + isnull(sign([3林]),0) + isnull(sign([4林]),0) + isnull(sign([5林]),0) + isnull(sign([6林]),0) + isnull(sign([7林]),0) + isnull(sign([8林]),0) + isnull(sign([9林]),0) + isnull(sign([10林]),0)
	+ isnull(sign([11林]),0)+ isnull(sign([12林]),0)+ isnull(sign([13林]),0)+ isnull(sign([14林]),0)+ isnull(sign([15林]),0)+ isnull(sign([16林]),0)+ isnull(sign([17林]),0)+ isnull(sign([18林]),0)+ isnull(sign([19林]),0)+ isnull(sign([20林]),0)
	+ isnull(sign([21林]),0)+ isnull(sign([22林]),0)+ isnull(sign([23林]),0)+ isnull(sign([24林]),0)+ isnull(sign([25林]),0)+ isnull(sign([26林]),0)+ isnull(sign([27林]),0)+ isnull(sign([28林]),0)+ isnull(sign([29林]),0)+ isnull(sign([30林]),0)
	+ isnull(sign([31林]),0)+ isnull(sign([32林]),0)+ isnull(sign([33林]),0)+ isnull(sign([34林]),0)+ isnull(sign([35林]),0)+ isnull(sign([36林]),0)+ isnull(sign([37林]),0)+ isnull(sign([38林]),0)+ isnull(sign([39林]),0)+ isnull(sign([40林]),0)
	+ isnull(sign([41林]),0)+ isnull(sign([42林]),0)+ isnull(sign([43林]),0)+ isnull(sign([44林]),0)+ isnull(sign([45林]),0)+ isnull(sign([46林]),0)+ isnull(sign([47林]),0)+ isnull(sign([48林]),0)+ isnull(sign([49林]),0)+ isnull(sign([50林]),0)
	+ isnull(sign([51林]),0)+ isnull(sign([52林]),0)+ isnull(sign([53林]),0)
		) as hit_avg
	from
	(
		select	shop_vcode, num
		,		[1林] = sum(case when datepart(ww, hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit  end end)  
		,		[2林] = sum(case when datepart(ww, hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[3林] = sum(case when datepart(ww, hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[4林] = sum(case when datepart(ww, hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[5林] = sum(case when datepart(ww, hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[6林] = sum(case when datepart(ww, hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[7林] = sum(case when datepart(ww, hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[8林] = sum(case when datepart(ww, hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[9林] = sum(case when datepart(ww, hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[10林] = sum(case when datepart(ww, hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11林] = sum(case when datepart(ww, hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12林] = sum(case when datepart(ww, hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[13林] = sum(case when datepart(ww, hit_date) = 13 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[14林] = sum(case when datepart(ww, hit_date) = 14 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[15林] = sum(case when datepart(ww, hit_date) = 15 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[16林] = sum(case when datepart(ww, hit_date) = 16 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[17林] = sum(case when datepart(ww, hit_date) = 17 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[18林] = sum(case when datepart(ww, hit_date) = 18 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[19林] = sum(case when datepart(ww, hit_date) = 19 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[20林] = sum(case when datepart(ww, hit_date) = 20 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[21林] = sum(case when datepart(ww, hit_date) = 21 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[22林] = sum(case when datepart(ww, hit_date) = 22 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[23林] = sum(case when datepart(ww, hit_date) = 23 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[24林] = sum(case when datepart(ww, hit_date) = 24 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[25林] = sum(case when datepart(ww, hit_date) = 25 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[26林] = sum(case when datepart(ww, hit_date) = 26 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[27林] = sum(case when datepart(ww, hit_date) = 27 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[28林] = sum(case when datepart(ww, hit_date) = 28 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[29林] = sum(case when datepart(ww, hit_date) = 29 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[30林] = sum(case when datepart(ww, hit_date) = 30 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[31林] = sum(case when datepart(ww, hit_date) = 31 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[32林] = sum(case when datepart(ww, hit_date) = 32 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[33林] = sum(case when datepart(ww, hit_date) = 33 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[34林] = sum(case when datepart(ww, hit_date) = 34 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[35林] = sum(case when datepart(ww, hit_date) = 35 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[36林] = sum(case when datepart(ww, hit_date) = 36 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[37林] = sum(case when datepart(ww, hit_date) = 37 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[38林] = sum(case when datepart(ww, hit_date) = 38 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[39林] = sum(case when datepart(ww, hit_date) = 39 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[40林] = sum(case when datepart(ww, hit_date) = 40 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[41林] = sum(case when datepart(ww, hit_date) = 41 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[42林] = sum(case when datepart(ww, hit_date) = 42 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[43林] = sum(case when datepart(ww, hit_date) = 43 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[44林] = sum(case when datepart(ww, hit_date) = 44 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[45林] = sum(case when datepart(ww, hit_date) = 45 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[46林] = sum(case when datepart(ww, hit_date) = 46 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[47林] = sum(case when datepart(ww, hit_date) = 47 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[48林] = sum(case when datepart(ww, hit_date) = 48 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[49林] = sum(case when datepart(ww, hit_date) = 49 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[50林] = sum(case when datepart(ww, hit_date) = 50 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[51林] = sum(case when datepart(ww, hit_date) = 51 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[52林] = sum(case when datepart(ww, hit_date) = 52 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[53林] = sum(case when datepart(ww, hit_date) = 53 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[hit_sum] = sum( case num when 1 then view_hit when 2 then move_hit  end)
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb 
		where hit_date >= @hit_date and hit_date < dateadd(yy, 1, @hit_date)
		group by shop_vcode, num
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by shop_name,num

