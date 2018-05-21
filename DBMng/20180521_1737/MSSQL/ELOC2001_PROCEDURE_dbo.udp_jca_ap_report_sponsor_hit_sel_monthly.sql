/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_hit_sel_monthly
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-08-13 15:17:18.06
 *        Modify: 2018-05-03 17:23:35.83
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sponsor_hit_sel_monthly
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
	

	select shop_name, case num when 1 then '�����' when 2 then 'Ŭ����' end as hit_name , [1��],[2��],[3��],[4��],[5��],[6��]
	,		[7��],[8��],[9��],[10��],[11��],[12��]
	,		month_sum
	,		month_sum / (
					isnull(sign([1��]),0)+
					isnull(sign([2��]),0)+
					isnull(sign([3��]),0)+
					isnull(sign([4��]),0)+
					isnull(sign([5��]),0)+
					isnull(sign([6��]),0)+
					isnull(sign([7��]),0)+
					isnull(sign([8��]),0)+
					isnull(sign([9��]),0)+
					isnull(sign([10��]),0)+
					isnull(sign([11��]),0)+
					isnull(sign([12��]),0)
			)
	from 
	(
		select	 shop_vcode, num
		,		[1��] = sum(case when month(hit_date) = 1 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[2��] = sum(case when month(hit_date) = 2 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[3��] = sum(case when month(hit_date) = 3 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[4��] = sum(case when month(hit_date) = 4 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[5��] = sum(case when month(hit_date) = 5 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[6��] = sum(case when month(hit_date) = 6 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[7��] = sum(case when month(hit_date) = 7 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[8��] = sum(case when month(hit_date) = 8 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[9��] = sum(case when month(hit_date) = 9 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[10��] = sum(case when month(hit_date) = 10 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[11��] = sum(case when month(hit_date) = 11 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[12��] = sum(case when month(hit_date) = 12 then case num when 1 then view_hit when 2 then move_hit  end end) 
		,		[month_sum] = sum(case num when 1 then view_hit when 2 then move_hit end)	
		from tbl_ap_shop_sponsor_hit cross join (select 1 num union all select 2) bb 
		where hit_date >= @hit_date and hit_date < dateadd(yy, 1, @hit_date)
		group by shop_vcode, num
	) a inner join shoplist b on a.shop_vcode = b.shop_vcode
	order by shop_name,num
