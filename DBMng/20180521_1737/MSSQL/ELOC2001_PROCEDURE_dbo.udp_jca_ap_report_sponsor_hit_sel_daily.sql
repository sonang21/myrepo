/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_hit_sel_daily
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-08-12 09:57:19.99
 *        Modify: 2018-05-03 17:23:35.527
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ap_report_sponsor_hit_sel_daily
	@hit_date smalldatetime
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

	select shop_name, case num when 1 then '畴免荐' when 2 then '努腐荐' end as hit_name, 
		 [1老],[2老],[3老],[4老],[5老],[6老],[7老],[8老],[9老],[10老]
		,[11老],[12老],[13老],[14老],[15老],[16老],[17老],[18老],[19老],[20老]
		,[21老],[22老],[23老],[24老],[25老],[26老],[27老],[28老],[29老],[30老],[31老]
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		num
		,		[1老]  = sum(case when day(hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[2老]  = sum(case when day(hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[3老]  = sum(case when day(hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[4老]  = sum(case when day(hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[5老]  = sum(case when day(hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[6老]  = sum(case when day(hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[7老]  = sum(case when day(hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[8老]  = sum(case when day(hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[9老]  = sum(case when day(hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[10老] = sum(case when day(hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11老] = sum(case when day(hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12老] = sum(case when day(hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[13老] = sum(case when day(hit_date) = 13 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[14老] = sum(case when day(hit_date) = 14 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[15老] = sum(case when day(hit_date) = 15 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[16老] = sum(case when day(hit_date) = 16 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[17老] = sum(case when day(hit_date) = 17 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[18老] = sum(case when day(hit_date) = 18 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[19老] = sum(case when day(hit_date) = 19 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[20老] = sum(case when day(hit_date) = 20 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[21老] = sum(case when day(hit_date) = 21 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[22老] = sum(case when day(hit_date) = 22 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[23老] = sum(case when day(hit_date) = 23 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[24老] = sum(case when day(hit_date) = 24 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[25老] = sum(case when day(hit_date) = 25 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[26老] = sum(case when day(hit_date) = 26 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[27老] = sum(case when day(hit_date) = 27 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[28老] = sum(case when day(hit_date) = 28 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[29老] = sum(case when day(hit_date) = 29 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[30老] = sum(case when day(hit_date) = 30 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[31老] = sum(case when day(hit_date) = 31 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[day_sum] = sum(case num when 1 then view_hit when 2 then move_hit end)	
		,		[day_avg] = avg(case num when 1 then view_hit when 2 then move_hit end)
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb
		where hit_date >= @hit_date and hit_date < dateadd(m, 1, @hit_date)
		and data_opt = 1
		group by shop_vcode, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, num



