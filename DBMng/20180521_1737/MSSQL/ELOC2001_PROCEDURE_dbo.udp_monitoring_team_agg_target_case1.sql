/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target_case1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 14:34:47.793
 *        Modify: 2018-05-03 17:23:35.387
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target_case1
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-01-02
	-- ��  �� : ����͸��� �۾��� ����� ����/tbl_strange_list
	--			monitoring_team_agg_target.monitor_no	
	--			1 : ���θ� ��ǰ�� ����
	--			2 : ���θ� ������ ����
	--			3 : ������ ����(��з�14�� ������->2014.06.24 ���� Ǯ����.������ ��û)
	--			4 : ����<���� ������
	-- ----------------------------------------------
	-- �Էµ� ������ ����
	delete from tbl_monitoring_team_agg_target 
	where monitor_no = @monitor_no and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- ���� �Է�
	if @monitor_no = 1 begin --1 : ���θ� ��ǰ�� ���� // �ߺз��������� // 2012.09.25
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'c'-- ���θ� ��ǰ�� ����
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)	
	end else if @monitor_no=2 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'p' -- ���θ� ������ ����
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)
	end else if @monitor_no=3 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = '8' -- ������ ����
		--	and left(sl_category,2) <> '14' -- ���ܺз� ->2014.06.24 ���� Ǯ����.������ ��û
			and exists (select TOP 1 1 from pricelist where pl_no = sl_plno)
			group by sl_plno
		) x
		group by lcate
		option (maxdop 1)

	end else if @monitor_no=4 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'f' -- ����<���� ������
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)
	end


