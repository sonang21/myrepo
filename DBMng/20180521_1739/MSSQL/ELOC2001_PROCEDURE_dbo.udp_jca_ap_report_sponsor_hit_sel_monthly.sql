/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_hit_sel_monthly
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-08-13 15:17:18.06
 *        Modify: 2018-05-03 17:23:35.83
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sponsor_hit_sel_monthly
	@hit_date smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-08-11
	-- 설  명 : 스폰서링크 노출,클릭 조회
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	

	select shop_name, case num when 1 then '노출수' when 2 then '클릭수' end as hit_name , [1월],[2월],[3월],[4월],[5월],[6월]
	,		[7월],[8월],[9월],[10월],[11월],[12월]
	,		month_sum
	,		month_sum / (
					isnull(sign([1월]),0)+
					isnull(sign([2월]),0)+
					isnull(sign([3월]),0)+
					isnull(sign([4월]),0)+
					isnull(sign([5월]),0)+
					isnull(sign([6월]),0)+
					isnull(sign([7월]),0)+
					isnull(sign([8월]),0)+
					isnull(sign([9월]),0)+
					isnull(sign([10월]),0)+
					isnull(sign([11월]),0)+
					isnull(sign([12월]),0)
			)
	from 
	(
		select	 shop_vcode, num
		,		[1월] = sum(case when month(hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[2월] = sum(case when month(hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[3월] = sum(case when month(hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[4월] = sum(case when month(hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[5월] = sum(case when month(hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[6월] = sum(case when month(hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[7월] = sum(case when month(hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[8월] = sum(case when month(hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[9월] = sum(case when month(hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[10월] = sum(case when month(hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11월] = sum(case when month(hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12월] = sum(case when month(hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[month_sum] = sum(case num when 1 then view_hit when 2 then move_hit end)	
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb 
		where hit_date >= @hit_date and hit_date < dateadd(yy, 1, @hit_date)
		group by shop_vcode, num
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by shop_name,num
