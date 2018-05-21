/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step3_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-31 19:00:54.65
 *        Modify: 2018-05-03 17:23:35.223
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_step3_agg
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-01-06
	-- ��  �� : ����͸� ������ ����
	-- �Ҵ��� ������ �����Ѵ�.
	-- ----------------------------------------------

--insert into tmp_20150326_runstep select getdate(), 31
	
	-- �Ѱ��� ������Ʈ 
	--	: ���� �ݿ��� �ּ� Ǯ��� ��
	--	: ���� ���ν��� �����ؾ� �� : udp_monitoring_team_agg_target
	delete from tbl_monitoring_team_agg_target 	
	where monitor_no in (12, 1, 8, 2, 3, 14, 15, 16, 17, 18, 19, 20, 5, 21, 22, 23, 24, 25)  
	and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)



	-- ���� : ���� �Է�
	insert into tbl_monitoring_team_agg_target(monitor_no, agg_date, category, target_cnt)
	select chg_type
	,	cast(convert(char(10), getdate(), 120) as smalldatetime) agg_date
	,	left(pl_category,2) lcate
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	group by chg_type, left(pl_category,2)
	option (maxdop 1)


	-- ���� : ������ ���â
	insert into tbl_monitoring_team_agg_target(monitor_no, agg_date, category, target_cnt)
	select 5
	,	getdate()
	,	left(ca_code, 2) as lcate
	,	count(*) target_cnt 
	from pricelist_matching_alarm_srch 
	where p_status='i' and  alarm_flag='2'
	group by left(ca_code, 2)


	-- ----------------------------------------------
	-- �Ҵ緮 ���� ���� : �Ҵ����� ��������!
	-- ----------------------------------------------
	declare @run_start smalldatetime
	select top 1 @run_start=work_start
	from tbl_mc_manager_set 
	order by work_start desc

	-- ��κ��� �׸�.
	insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
	select @run_start
	,	getdate()
	,	left(pl_category,2) lcate
	,	chg_type
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	and assign_mm_id is null
	and today_first_date >= @run_start
	--and chg_type not in ( 23 ) -- 23�� �Ҵ��ϰ� �Է��ϱ� ������ �ڵ����� ���ܵȴ�.��
	group by chg_type, left(pl_category,2)
	option (maxdop 1)	


	-- �����׸� : ������ ���â	
	insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
	select @run_start
	,	getdate()
	,	left(ca_code, 2) as lcate
	,	5 as chg_type
	,	count(*) target_cnt 
	from pricelist_matching_alarm_srch  a inner join (
		-- �ߺз� �α��ǰ 60�� ��ǰ�� �۾�������� ó��.
		select modelno from tbl_mcate_popular_rank where mcate_group_rank between 1 and 60
	) b on a.g_modelno = b.modelno
	where p_status='i' and  alarm_flag='2' and assign_mm_id is null		
	and regdate>= cast(cast(getdate() as date) as smalldatetime) -- 2016.05.13 // �̰汹 // ���� �����͸� ���� 
	group by left(ca_code, 2)
	

	-- �����׸� : �ǽð� ������ ����͸� : ctu, minibot���� ������ ����, �� ���Ϸ� ������ ����Ʈ
	-- �����׸� : �ǽð� �ɼ� ����͸�   : ctu, minibot���� �ǽð� �����ϴ� �ɼ� ���� ����.
	insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
	select @run_start
	,	getdate()
	,	left(pl_category, 2) as pl_category
	,	chg_type--23
	,	count(*) target_cnt 
	from tbl_monitoring_target
	where	chg_type in (23, 24)
	--and		regdate >= dateadd(hh, -1, @run_start)
	--and		regdate < @run_start
	and		today_first_date >= dateadd(hh, -1, @run_start)
	and		today_first_date < @run_start
	group by left(pl_category, 2), chg_type

	-- �����׸� : GS -- 2017.02.28
	-- �Է°� ���ÿ� �Ҵ� �Ǳ� ������. �Ϸ翡 �ѹ��� ó���Ѵ�.
	if not exists(select top 1 * from tbl_monitoring_target_run_history where run_start > cast(getdate() as date) and chg_type=25) begin 

		insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
		select @run_start
		,	getdate()
		,	left(pl_category, 2) as pl_category
		,	chg_type
		,	count(*) target_cnt 
		from tbl_monitoring_target
		where		chg_type in (25)
		and		regdate >= cast(getdate() as date)
		and		regdate < @run_start
		group by left(pl_category, 2), chg_type

	end
	
	-- �ð�����
	update tbl_monitoring_target_run_history 
	set run_end = getdate()
	where run_start = @run_start

	-- �ֱ� 53�ָ�(=1��) ���� 
	delete from tbl_monitoring_target_run_history where run_start < dateadd(ww, -53, getdate())

--insert into tmp_20150326_runstep select getdate(), 36

