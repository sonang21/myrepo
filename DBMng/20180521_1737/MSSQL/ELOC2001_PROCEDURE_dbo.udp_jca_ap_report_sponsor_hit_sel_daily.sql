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

	select shop_name, case num when 1 then '�����' when 2 then 'Ŭ����' end as hit_name, 
		 [1��],[2��],[3��],[4��],[5��],[6��],[7��],[8��],[9��],[10��]
		,[11��],[12��],[13��],[14��],[15��],[16��],[17��],[18��],[19��],[20��]
		,[21��],[22��],[23��],[24��],[25��],[26��],[27��],[28��],[29��],[30��],[31��]
		, day_sum, day_avg
		from 
		(
		select	shop_vcode as shop_vcode
		,		num
		,		[1��]  = sum(case when day(hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[2��]  = sum(case when day(hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[3��]  = sum(case when day(hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[4��]  = sum(case when day(hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[5��]  = sum(case when day(hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[6��]  = sum(case when day(hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[7��]  = sum(case when day(hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[8��]  = sum(case when day(hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[9��]  = sum(case when day(hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit end end) 
		,		[10��] = sum(case when day(hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11��] = sum(case when day(hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12��] = sum(case when day(hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[13��] = sum(case when day(hit_date) = 13 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[14��] = sum(case when day(hit_date) = 14 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[15��] = sum(case when day(hit_date) = 15 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[16��] = sum(case when day(hit_date) = 16 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[17��] = sum(case when day(hit_date) = 17 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[18��] = sum(case when day(hit_date) = 18 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[19��] = sum(case when day(hit_date) = 19 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[20��] = sum(case when day(hit_date) = 20 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[21��] = sum(case when day(hit_date) = 21 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[22��] = sum(case when day(hit_date) = 22 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[23��] = sum(case when day(hit_date) = 23 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[24��] = sum(case when day(hit_date) = 24 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[25��] = sum(case when day(hit_date) = 25 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[26��] = sum(case when day(hit_date) = 26 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[27��] = sum(case when day(hit_date) = 27 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[28��] = sum(case when day(hit_date) = 28 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[29��] = sum(case when day(hit_date) = 29 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[30��] = sum(case when day(hit_date) = 30 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[31��] = sum(case when day(hit_date) = 31 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[day_sum] = sum(case num when 1 then view_hit when 2 then move_hit end)	
		,		[day_avg] = avg(case num when 1 then view_hit when 2 then move_hit end)
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb
		where hit_date >= @hit_date and hit_date < dateadd(m, 1, @hit_date)
		and data_opt = 1
		group by shop_vcode, num
		) a inner join shoplist b on a.shop_vcode = b.shop_vcode
		order by shop_name, num



