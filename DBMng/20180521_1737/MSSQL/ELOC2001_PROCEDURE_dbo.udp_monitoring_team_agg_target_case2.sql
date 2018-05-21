/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target_case2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 14:39:18.96
 *        Modify: 2018-05-03 17:23:35.4
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target_case2
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-01-02
	-- ��  �� : ����͸��� �۾��� ����� ����/pricelist_matching_alarm_srch
	--			monitoring_team_agg_target.monitor_no	
	--			5 : ���������â : pricelist_matching_alarm_srch
	--			9 : �ְ����â : pricelist_matching_alarm_srch
	-- ----------------------------------------------
	-- �Էµ� ������ ����
	delete from tbl_monitoring_team_agg_target 
	where monitor_no = @monitor_no and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	if @monitor_no = 5 begin

		-- ���� �Է�
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(pl_category),2) as lcate
			from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
			where p_status='i' and alarm_flag='2'
			group by a.pl_no

		) x
		group by lcate
		option (maxdop 1)
	end if @monitor_no = 9 begin

		-- ���� �Է�
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(pl_category),2) as lcate
			from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
			where p_status='i' and alarm_flag='3'
			group by a.pl_no

		) x
		group by lcate
		option (maxdop 1)
	end

