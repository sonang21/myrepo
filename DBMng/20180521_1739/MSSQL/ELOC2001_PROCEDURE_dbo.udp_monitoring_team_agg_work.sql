/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_work
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 15:37:00.343
 *        Modify: 2018-05-03 17:23:35.47
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_work
	@agg_date smalldatetime = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-12-07
	-- ��  �� : ����͸��� �۾��α� ���
	--			monitoring_team_agg_work.monitor_no	
	--			1 : ���θ� ��ǰ�� ���� : tbl_strange_list
	--			2 : ���θ� ������ ���� : tbl_strange_list
	--			3 : ������ ���� : tbl_strange_list
	--			4 : ����<���� ������ : tbl_strange_list
	--			5 : ���������â : pricelist_matching_alarm_srch
	--			6 : �ɼ�ǰ�� : tbl_pricelist_option_ctu_detail
	--			7 : �ɼǺ��� : tbl_pricelist_option_diff_detail
	--			8 : ������ : pricelist_dml_log
	--			9 : �ְ����â : pricelist_matching_alarm_srch
	--			10 : �ǽð� ������: pricelist_dml_log
	--			11 : �ɼǺ���_���һ�ǰ : tbl_pricelist_option_diff_copyplno
	-- ----------------------------------------------
	--declare @agg_date smalldatetime
	if @agg_date is null begin
		set @agg_date = cast(convert(char(10), getdate()-1, 120) as smalldatetime)
	end



	-- �Էµ� ������ ����
	delete from tbl_monitoring_team_agg_work where agg_date = @agg_date


	-- tbl_strange_list
--	exec udp_monitoring_team_agg_work_case1 1
--	exec udp_monitoring_team_agg_work_case1 2
--	exec udp_monitoring_team_agg_work_case1 3
	/*
	-- 2014.06.26 ����ó��. ������ ��û. ������
	-- ���� ����� �� �־� �ּ�ó����.	
	exec udp_monitoring_team_agg_work_case1 4
	*/


	-- ---------------------------------------------
	-- ������ ���� ����� �Ʒ� ���� ��� ����ؾ���
	-- 1, 2, 3, 5, 8, 12, 13, 14, 15, 16, 17,10	
	-- ---------------------------------------------
	-- 193 error_report���� ������ ������ �����´�.
	--drop table #tbl_monitoring_team_agg_alba_desc

	select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
	into #tbl_monitoring_team_agg_alba_desc
	from openquery(SEARCHKEY_193, '
			select mm_id, refer_route, left(category,4) category, 0 u_cnt
			from enuridb.dbo.tbl_error_report with (nolock) 
			where 1=0
			')



	if datediff(d, @agg_date, getdate()) = 0 begin

		insert into #tbl_monitoring_team_agg_alba_desc
		select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
		from openquery(SEARCHKEY_193, '
				select mm_id, refer_route, left(category,4) category, count(*) u_cnt
				from enuridb.dbo.tbl_error_report with (nolock) 
				where pl_no >0
				and refer_route is not null
				and refer_route <> ''''
				and mm_id in (select mm_id from enuridb.dbo.mm_enuri where (mm_partcode like ''_________411'' or mm_partcode like ''_________437'' or mm_partcode like ''_________429'' or mm_partcode like ''_________464'')) 
				and regdate >=cast(convert(varchar(10), getdate()-0, 120) as datetime) 
				and regdate < cast(convert(varchar(10), getdate()+1, 120) as datetime) 
				group by mm_id, refer_route, left(category,4)
				')

			-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 1, ''

	end else begin

		insert into #tbl_monitoring_team_agg_alba_desc
		select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
		from openquery(SEARCHKEY_193, '
				select mm_id, refer_route, left(category,4) category, count(*) u_cnt
				from enuridb.dbo.tbl_error_report with (nolock) 
				where pl_no >0
				and refer_route is not null
				and refer_route <> ''''
				and mm_id in (select mm_id from enuridb.dbo.mm_enuri where (mm_partcode like ''_________411'' or mm_partcode like ''_________437'' or mm_partcode like ''_________429'' or mm_partcode like ''_________464'')) 
				and regdate >=cast(convert(varchar(10), getdate()-1, 120) as datetime) 
				and regdate < cast(convert(varchar(10), getdate()-0, 120) as datetime) 
				group by mm_id, refer_route, left(category,4)
				')

			-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 2, ''
	end





	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt, assign_cnt)
	select monitor_no, @agg_date, category, mm_id, sum(d_cnt), sum(u_cnt), sum(a_cnt)
	from 
	(
		select monitor_no, category, mm_id, 0 d_cnt, u_cnt, 0 a_cnt  from #tbl_monitoring_team_agg_alba_desc
	
		union all

		-- Ȯ��
		select chg_type
		,	left(pl_category , 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end) d_cnt
		,	0 u_cnt
		,	0 a_cnt
		--,	sum(case when p_status = 'u' then 1 else 0 end) u_cnt
		from tbl_monitoring_target_job_log a
		where a.p_status = 'd' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
		and	p_date>= cast(convert(char(8), @agg_date,112) as datetime) -- ó����
		and p_date < cast(convert(char(8), @agg_date+1,112) as datetime) -- ó����
		group by chg_type, left(pl_category,4), mm_id

		union all

		-- �Ҵ�
		select chg_type
		,	left(pl_category , 4) mcate
		,	assign_mm_id
		,	0 d_cnt
		,	0 u_cnt
		,	count(*) a_cnt
		--,	sum(case when p_status = 'u' then 1 else 0 end) u_cnt
		from tbl_monitoring_target a
		where exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
		and	regdate>= cast(convert(char(8), @agg_date,112) as datetime) -- �����
		and regdate< cast(convert(char(8), @agg_date+1,112) as datetime) -- �����
		and assign_mm_id is not null
		group by chg_type, left(pl_category,4), assign_mm_id


		union all


		-- 5. ������ ���â//pricelist_matching_alarm_srch // mp���� �Է�
		select 5
		,	left(ca_code , 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	0 u_cnt
		,	0 a_cnt
		from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
		where a.p_status in ('u', 'd')
		and	p_date>= cast(convert(char(8), @agg_date,112) as datetime)
		and p_date < cast(convert(char(8), @agg_date+1,112) as datetime)
		and ca_code is not null
		and	alarm_flag = '2'
		group by left(ca_code , 4), mm_id

		union all

		--10. �ǽð� ������
		select 10
		,	left(a.pl_category, 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	0 u_cnt
		,	0 a_cnt
		from
		(
			select pl_no, max(pl_category) as pl_category
			,	max(pl_modelno) as pl_modelno
			,	max(p_status) as p_status
			,	max(mm_id) as mm_id
			from pricelist_dml_log
			where p_status in ('u', 'd')
			and	p_date>= cast(convert(char(8), @agg_date,112) as datetime)
			and p_date < cast(convert(char(8), @agg_date+1,112) as datetime)		
			and pl_category is not null
			and log_flag=2
			group by pl_no
		) a 
		inner join pricelist b on a.pl_no = b.pl_no
		group by left(a.pl_category , 4), mm_id	

	) a
	group by monitor_no, category, mm_id

			-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 3, ''

	-- ������ ���â : ����ó�� 
	-- �ǽð� ���̴� �������̱� ������ ó���ϴ� ������ ���� ������ ĸó�� �۾��� �ѷ�����
	-- �۾��� �ѷ��� ���� �� �ִ�. ���������� mp���� �ѹ� ����� Ȯ���� �� 100���� ó���ǹǷ� �۾���=�ѷ����� ó���ϱ�� ��.
--	delete from tbl_monitoring_team_agg_target where monitor_no=5 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=5 and agg_date = @agg_date



	-- 6 : �ɼ�ǰ�� : tbl_pricelist_option_ctu_detail // ��з��������� 2015.01.14
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 6
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(ca_code) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_ctu_detail
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and ca_code is not null
--		group by convert(char(8), regdate,112), pl_no
--	) x
--	group by mcate, mm_id



	-- 7 : �ɼǺ��� : tbl_pricelist_option_diff_detail  // ��з��������� 2015.01.14
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 7
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(ca_code) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_diff_detail
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and ca_code is not null
--		group by convert(char(8), regdate,112), pl_no
--	) x
--	group by mcate, mm_id


	-- 8. ������ //pricelist.pl_status='8' // mp���� �Է�
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 8
--	,	@agg_date
--	,	left(a.pl_category, 2) mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from pricelist_dml_log a inner join pricelist b on a.pl_no = b.pl_no
--	where a.p_status in ('u', 'd')
--	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--	and p_date < cast(convert(char(8), getdate(),112) as datetime)
--	and a.pl_category is not null
--	and log_flag=1
--	group by left(a.pl_category , 2), mm_id

	-- ������ : ����ó�� 
	-- �ǽð� ���̴� �������̱� ������ ó���ϴ� ������ ���� ������ ĸó�� �۾��� �ѷ�����
	-- �۾��� �ѷ��� ���� �� �ִ�. ���������� mp���� �ѹ� ����� Ȯ���� �� 100���� ó���ǹǷ� �۾���=�ѷ����� ó���ϱ�� ��.
--	delete from tbl_monitoring_team_agg_target where monitor_no=8 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=8 and agg_date = @agg_date


	-- 9. �ְ� ���â//pricelist_matching_alarm_srch // mp���� �Է�
	/*
	-- 2014.06.26 ����ó��. ������ ��û. ������
	-- ���� ����� �� �־� �ּ�ó����.
	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
	select 9
	,	@agg_date
	,	left(ca_code , 2)
	,	mm_id
	,	sum(case when p_status = 'd' then 1 else 0 end)
	,	sum(case when p_status = 'u' then 1 else 0 end)
	from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
	where a.p_status in ('u', 'd')
	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
	and p_date < cast(convert(char(8), getdate(),112) as datetime)
	and ca_code is not null
	and	alarm_flag = '3'
	group by left(ca_code , 2), mm_id

	-- �ְ� ���â : ����ó�� 
	-- �ǽð� ���̴� �������̱� ������ ó���ϴ� ������ ���� ������ ĸó�� �۾��� �ѷ�����
	-- �۾��� �ѷ��� ���� �� �ִ�. ���������� mp���� �ѹ� ����� Ȯ���� �� 100���� ó���ǹǷ� �۾���=�ѷ����� ó���ϱ�� ��.
	delete from tbl_monitoring_team_agg_target where monitor_no=9 and agg_date=@agg_date
	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
	select monitor_no, category, delete_cnt+update_cnt, agg_date
	from tbl_monitoring_team_agg_work where monitor_no=9 and agg_date = @agg_date
	*/


	-- 10. �ǽð� ������
	--insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
	--select 10
	--,	@agg_date
	--,	left(a.pl_category, 4) mcate
	--,	mm_id
	--,	sum(case when p_status = 'd' then 1 else 0 end)
	--,	sum(case when p_status = 'u' then 1 else 0 end)
	--from
	--(
	--	select pl_no, max(pl_category) as pl_category
	--	,	max(pl_modelno) as pl_modelno
	--	,	max(p_status) as p_status
	--	,	max(mm_id) as mm_id
	--	from pricelist_dml_log
	--	where p_status in ('u', 'd')
	--	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
	--	and p_date < cast(convert(char(8), getdate(),112) as datetime)		
	--	and pl_category is not null
	--	and log_flag=2
	--	group by pl_no
	--) a 
	--inner join pricelist b on a.pl_no = b.pl_no
	--group by left(a.pl_category , 4), mm_id	

	-- �ǽð� ������ : ����ó�� 
	-- �ǽð� ���̴� �������̱� ������ ó���ϴ� ������ ���� ������ ĸó�� �۾��� �ѷ�����
	-- �۾��� �ѷ��� ���� �� �ִ�. ���������� mp���� �ѹ� ����� Ȯ���� �� 100���� ó���ǹǷ� �۾���=�ѷ����� ó���ϱ�� ��.
	--delete from tbl_monitoring_team_agg_target where monitor_no=10 and agg_date=@agg_date
	--insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
	--select monitor_no, category, delete_cnt+update_cnt, agg_date
	--from tbl_monitoring_team_agg_work where monitor_no=10 and agg_date = @agg_date


	-- 11 : �ɼǺ���_���һ�ǰ : tbl_pricelist_option_diff_copyplno
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 11
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(pl_category) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_diff_copyplno
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and pl_category is not null
--		group by convert(char(8), regdate,112), pl_goodscode
--	) x
--	group by mcate, mm_id
--	-- �ɼǺ���_���һ�ǰ : ����ó�� 
--	-- ���ϸ��� ó���ϴ� �з��� �޶� ����ó���Ѵ�. ��ü �з� ó���ϰԵǸ� ����ó���� ���־��Ѵ�.
--	-- �۾���=�ѷ����� ó���ϱ�� ��. with ��ȿ�� 2014.05.16	
--	delete from tbl_monitoring_team_agg_target where monitor_no=11 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=11 and agg_date = @agg_date

if datediff(d, @agg_date, getdate())>= 0 begin



	-- -------------------
	-- ���������� ����
	-- -------------------
	-- ������, �ǽð� ������
	delete from pricelist_dml_log  -- �ֱ� 8�� �����͸� ����
	where p_date < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as smalldatetime)
	and log_flag in (1, 2)
	and p_status in ('u', 'd')

				-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 4, ''
	-- ���θ� ��ǰ�� ����, ���θ� ������ ����, ������_����, ����<���� ������
--	-- ó���� ��鸸
--	delete from tbl_strange_list -- �ֱ� 8�� �����͸� ����
--	where sl_date < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as smalldatetime)
--	and sl_srvflag in( 'p', '8', 'f') --'c' : 6���� �������� ����
--	--and p_status in ('u', 'd')  
--	-- i ���� ��� ����� ���� // 2014.11.25 ������ ��û
--	-- i�� mc���� �����ϰ� �־���.



	-- ������ ���� ����� �Ʒ� ���� ��� ����ؾ���
	-- �ֱ� 4�ָ� ����
	delete from tbl_monitoring_target
	where regdate < cast(convert(char(8), dateadd(ww, -4, getdate()),112) as smalldatetime)

				-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 5, ''

	delete from tbl_monitoring_target_job_log
	where regdate < cast(convert(char(8), dateadd(ww, -4, getdate()),112) as smalldatetime)


	-- ������ ���â, �ְ� ���â
	-- ó���� ��鸸
	delete from pricelist_matching_alarm_srch  -- �ֱ� 30�� �����͸� ����
	where regdate < cast(convert(char(8), dateadd(ww, -30, getdate()),112) as smalldatetime)
	and isnull(p_date, regdate) < cast(convert(char(8), dateadd(ww, -30, getdate()),112) as smalldatetime)
	and alarm_flag in ('2','3')
	and p_status in ('u', 'd')

				-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 6, ''

	-- �ɼ�ǰ�� - �ɼǳ����ִ� ��.
	-- ó������ ��� ����
	delete from tbl_pricelist_option_ctu_detail-- �ֱ� 8�� �����͸� ����
	where regdate < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as datetime)


				-- ����͸�
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 7, ''

	-- �ɼǺ���
	-- ó������ ��� ����
	delete from tbl_pricelist_option_diff_detail-- �ֱ� 8�� �����͸� ����
	where regdate < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as datetime)

end



