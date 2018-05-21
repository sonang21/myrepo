/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_raw_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-12 13:57:51.697
 *        Modify: 2018-05-03 17:23:35.673
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_raw_agg
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-01-06
	-- ��  �� : ����͸� ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	-- �Ѱ��� ������Ʈ 
	--	: ���� �ݿ��� �ּ� Ǯ��� ��
	--	: ���� ���ν��� �����ؾ� �� : udp_monitoring_team_agg_target
	delete from tbl_monitoring_team_agg_target 	
	where monitor_no in (12, 1, 8, 2, 3, 14, 15, 16, 17, 18, 19, 20)  and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- ���� �Է�
	insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
	select chg_type
	,	cast(convert(char(10), getdate(), 120) as smalldatetime) agg_date
	,	left(pl_category,2) lcate
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	group by chg_type, left(pl_category,2)
	option (maxdop 1)

	-- �ð��� ������ ���� : �Ҵ����� ��������!
	declare @run_start smalldatetime
	select top 1 @run_start=work_start
	from tbl_mc_manager_set 
	order by work_start desc

	insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
	select @run_start
	,	getdate()
	,	left(pl_category,2) lcate
	,	chg_type
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	and assign_mm_id is null
	group by chg_type, left(pl_category,2)
	option (maxdop 1)	

	-- ������ ���â
	insert into tbl_monitoring_target_run_history(run_start, run_end, category, chg_type, run_cnt)
	select @run_start
	,	getdate()
	,	left(ca_code, 2) as lcate
	,	'5' as chg_type
	,	count(*) target_cnt 
	from pricelist_matching_alarm_srch
	where p_status='i' and  alarm_flag='2' and assign_mm_id is null		
	group by left(ca_code, 2)

	-- �ֱ� 4�ָ� ���� 
	delete from tbl_monitoring_target_run_history where run_start < dateadd(ww, -4, getdate())
