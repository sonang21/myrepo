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
	select shop_name, case num when 1 then '�����' when 2 then 'Ŭ����' end as hit_name
		,[1��] ,[2��] ,[3��] ,[4��] ,[5��] ,[6��] ,[7��] ,[8��] ,[9��] ,[10��]
		,[11��],[12��],[13��],[14��],[15��],[16��],[17��],[18��],[19��],[20��]
		,[21��],[22��],[23��],[24��],[25��],[26��],[27��],[28��],[29��],[30��]
		,[31��],[32��],[33��],[34��],[35��],[36��],[37��],[38��],[39��],[40��]
		,[41��],[42��],[43��],[44��],[45��],[46��],[47��],[48��],[49��],[50��]
		,[51��],[52��],[53��],hit_sum, hit_sum/(
	isnull(sign([1��]),0) + isnull(sign([2��]),0) + isnull(sign([3��]),0) + isnull(sign([4��]),0) + isnull(sign([5��]),0) + isnull(sign([6��]),0) + isnull(sign([7��]),0) + isnull(sign([8��]),0) + isnull(sign([9��]),0) + isnull(sign([10��]),0)
	+ isnull(sign([11��]),0)+ isnull(sign([12��]),0)+ isnull(sign([13��]),0)+ isnull(sign([14��]),0)+ isnull(sign([15��]),0)+ isnull(sign([16��]),0)+ isnull(sign([17��]),0)+ isnull(sign([18��]),0)+ isnull(sign([19��]),0)+ isnull(sign([20��]),0)
	+ isnull(sign([21��]),0)+ isnull(sign([22��]),0)+ isnull(sign([23��]),0)+ isnull(sign([24��]),0)+ isnull(sign([25��]),0)+ isnull(sign([26��]),0)+ isnull(sign([27��]),0)+ isnull(sign([28��]),0)+ isnull(sign([29��]),0)+ isnull(sign([30��]),0)
	+ isnull(sign([31��]),0)+ isnull(sign([32��]),0)+ isnull(sign([33��]),0)+ isnull(sign([34��]),0)+ isnull(sign([35��]),0)+ isnull(sign([36��]),0)+ isnull(sign([37��]),0)+ isnull(sign([38��]),0)+ isnull(sign([39��]),0)+ isnull(sign([40��]),0)
	+ isnull(sign([41��]),0)+ isnull(sign([42��]),0)+ isnull(sign([43��]),0)+ isnull(sign([44��]),0)+ isnull(sign([45��]),0)+ isnull(sign([46��]),0)+ isnull(sign([47��]),0)+ isnull(sign([48��]),0)+ isnull(sign([49��]),0)+ isnull(sign([50��]),0)
	+ isnull(sign([51��]),0)+ isnull(sign([52��]),0)+ isnull(sign([53��]),0)
		) as hit_avg
	from
	(
		select	shop_vcode, num
		,		[1��] = sum(case when datepart(ww, hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit  end end)  
		,		[2��] = sum(case when datepart(ww, hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[3��] = sum(case when datepart(ww, hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[4��] = sum(case when datepart(ww, hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[5��] = sum(case when datepart(ww, hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[6��] = sum(case when datepart(ww, hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[7��] = sum(case when datepart(ww, hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[8��] = sum(case when datepart(ww, hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[9��] = sum(case when datepart(ww, hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[10��] = sum(case when datepart(ww, hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11��] = sum(case when datepart(ww, hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12��] = sum(case when datepart(ww, hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[13��] = sum(case when datepart(ww, hit_date) = 13 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[14��] = sum(case when datepart(ww, hit_date) = 14 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[15��] = sum(case when datepart(ww, hit_date) = 15 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[16��] = sum(case when datepart(ww, hit_date) = 16 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[17��] = sum(case when datepart(ww, hit_date) = 17 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[18��] = sum(case when datepart(ww, hit_date) = 18 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[19��] = sum(case when datepart(ww, hit_date) = 19 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[20��] = sum(case when datepart(ww, hit_date) = 20 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[21��] = sum(case when datepart(ww, hit_date) = 21 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[22��] = sum(case when datepart(ww, hit_date) = 22 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[23��] = sum(case when datepart(ww, hit_date) = 23 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[24��] = sum(case when datepart(ww, hit_date) = 24 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[25��] = sum(case when datepart(ww, hit_date) = 25 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[26��] = sum(case when datepart(ww, hit_date) = 26 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[27��] = sum(case when datepart(ww, hit_date) = 27 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[28��] = sum(case when datepart(ww, hit_date) = 28 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[29��] = sum(case when datepart(ww, hit_date) = 29 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[30��] = sum(case when datepart(ww, hit_date) = 30 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[31��] = sum(case when datepart(ww, hit_date) = 31 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[32��] = sum(case when datepart(ww, hit_date) = 32 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[33��] = sum(case when datepart(ww, hit_date) = 33 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[34��] = sum(case when datepart(ww, hit_date) = 34 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[35��] = sum(case when datepart(ww, hit_date) = 35 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[36��] = sum(case when datepart(ww, hit_date) = 36 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[37��] = sum(case when datepart(ww, hit_date) = 37 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[38��] = sum(case when datepart(ww, hit_date) = 38 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[39��] = sum(case when datepart(ww, hit_date) = 39 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[40��] = sum(case when datepart(ww, hit_date) = 40 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[41��] = sum(case when datepart(ww, hit_date) = 41 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[42��] = sum(case when datepart(ww, hit_date) = 42 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[43��] = sum(case when datepart(ww, hit_date) = 43 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[44��] = sum(case when datepart(ww, hit_date) = 44 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[45��] = sum(case when datepart(ww, hit_date) = 45 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[46��] = sum(case when datepart(ww, hit_date) = 46 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[47��] = sum(case when datepart(ww, hit_date) = 47 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[48��] = sum(case when datepart(ww, hit_date) = 48 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[49��] = sum(case when datepart(ww, hit_date) = 49 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[50��] = sum(case when datepart(ww, hit_date) = 50 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[51��] = sum(case when datepart(ww, hit_date) = 51 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[52��] = sum(case when datepart(ww, hit_date) = 52 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[53��] = sum(case when datepart(ww, hit_date) = 53 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[hit_sum] = sum( case num when 1 then view_hit when 2 then move_hit  end)
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb 
		where hit_date >= @hit_date and hit_date < dateadd(yy, 1, @hit_date)
		group by shop_vcode, num
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by shop_name,num

