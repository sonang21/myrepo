/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_work_case1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 15:01:38.997
 *        Modify: 2018-05-03 17:23:35.453
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_monitoring_team_agg_work_case1]
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-01-02
	-- ��  �� : ����͸��� �۾��� �α� ���/tbl_strange_list
	--			monitoring_team_agg_target.monitor_no	
	--			1 : ���θ� ��ǰ�� ����
	--			2 : ���θ� ������ ����
	--			3 : ������ ����(��з� 14�� ������->2014.06.24 ���� Ǯ����.������ ��û))
	--			4 : ����<���� ������
	-- ----------------------------------------------
	-- ���� �Է�

	if @monitor_no = 1 begin --1 : ���θ� ��ǰ�� ���� // �ߺз��������� // 2012.09.25 // ��з��������� 2015.01.14
		insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate()-1, 120) as smalldatetime)
		,	lcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	sum(case when p_status = 'u' then 1 else 0 end)
		from (
			select left(max(sl_category) , 2) as lcate
			,	max(p_status) as p_status
			,	max(mm_id) as mm_id
			from tbl_strange_list
			where p_status in ('u', 'd')
			and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
			and p_date < cast(convert(char(8), getdate(),112) as datetime)
			and sl_srvflag = case @monitor_no 
								when 1 then 'v' -- ���θ� ��ǰ�� ����
								when 2 then 'p' -- ���θ� ������ ����
								when 3 then '8' -- ������ ����
								when 4 then 'f' -- ���� < ���� ������
							end 
			and sl_category is not null
			group by sl_plno
		) x
		group by lcate, mm_id
	end else begin
		insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate()-1, 120) as smalldatetime)
		,	lcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	sum(case when p_status = 'u' then 1 else 0 end)
		from (
			select left(max(sl_category) , 2) as lcate
			,	max(p_status) as p_status
			,	max(mm_id) as mm_id
			from tbl_strange_list
			where p_status in ('u', 'd')
			and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
			and p_date < cast(convert(char(8), getdate(),112) as datetime)
			and sl_srvflag = case @monitor_no 
								when 1 then 'v' -- ���θ� ��ǰ�� ����
								when 2 then 'p' -- ���θ� ������ ����
								when 3 then '8' -- ������ ����
								when 4 then 'f' -- ���� < ���� ������
							end 
			and sl_category is not null
			group by sl_plno
		) x
		group by lcate, mm_id
	end

	-- ���ܺз� ����
	/* ->2014.06.24 ���� Ǯ����.������ ��û
	if @monitor_no = 3 begin
		delete from tbl_monitoring_team_agg_work where monitor_no=3 and agg_date = cast(convert(char(10), getdate()-1, 120) as smalldatetime) and category in ('14')
	end
	*/






