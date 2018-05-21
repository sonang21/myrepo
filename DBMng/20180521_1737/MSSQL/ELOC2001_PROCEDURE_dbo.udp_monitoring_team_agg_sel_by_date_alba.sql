/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_date_alba
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-10 14:42:47.053
 *        Modify: 2018-05-03 17:23:34.433
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_sel_by_date_alba
	@sdate smalldatetime
,	@edate smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.06.10
	-- 설  명 : 모니터링팀 작업한 로그 통계 보기
	-- ----------------------------------------------

	-- 수정량은 오류DB결과 페이지 참조하도록 수정.
	declare @str_sdate varchar(10)
	declare @str_edate varchar(10)
	select @str_sdate=convert(varchar(10), @sdate, 120), @str_edate=convert(varchar(10), @edate+1, 120)
	

	create table #temp_work(
		yyyymmdd varchar(10)
	,	mm_id varchar(12)
	,	u_cnt int
	,	d_cnt int
	,	a_cnt int
	,	run_cnt int
	)

	create table #alba(
		mm_id varchar(12)
	,	mm_nm varchar(10)
	)


	insert into #alba
	select mm_id, mm_nm from openquery(searchkey_193, 'select mm_nm, mm_id from enuridb.dbo.mm_enuri where mm_partcode like ''_________411'' and mm_flag=''1''')
	--102204308411  -> 101203306411

	--select * from #alba

	insert into #temp_work(yyyymmdd, mm_id, u_cnt)
	exec ('select yyyymmdd, mm_id, jog_cnt from openquery(SEARCHKEY_193, ''
					select mm_id, convert(varchar(10), regdate, 120) yyyymmdd, count(*) jog_cnt
					from enuridb.dbo.tbl_error_report with (nolock) 
					where pl_no >0
					and regdate >=cast('''''+@str_sdate+''''' as datetime) 
					and regdate < cast('''''+@str_edate+''''' as datetime) 
					and (mm_partcode like ''''_________411'''' or mm_id in (select mm_id from  enuridb.dbo.mm_enuri where mm_partcode like ''''_________411'''' and mm_flag=''''1''''))
					group by mm_id, convert(varchar(10), regdate, 120)
					'')')

	-- 부서이동, 탈퇴 사원 입력
	insert into #alba(mm_id)
	select distinct mm_id from #temp_work where mm_id not in (
		select mm_id from #alba
	)



	-- 확인개수
	insert into #temp_work(yyyymmdd, mm_id, d_cnt, a_cnt)
	select convert(varchar(10), agg_date, 120) as yyyymmdd, mm_id, isnull(sum(delete_cnt),0) as dcnt, isnull(sum(assign_cnt),0) as acnt
	from tbl_monitoring_team_agg_work
	where agg_date >= @sdate and agg_date < @edate+1
	and monitor_no in (
		select monitor_no from tbl_monitoring_team_agg_name where is_use = 1
	)
	and mm_id in (
		select mm_id from #alba
	)
	group by mm_id, convert(varchar(10), agg_date, 120)


	-- 총량
/*
	insert into #temp_work(yyyymmdd, run_cnt)
	select convert(varchar(10), run_start, 120) yyyymm, sum(run_cnt) run_cnt
	from tbl_monitoring_target_run_history
	where run_start >= @sdate and run_start < @edate+1
	and chg_type in (
		select monitor_no from tbl_monitoring_team_agg_name where is_use = 1
	)
	group by convert(varchar(10), run_start, 120)
*/

	select isnull(yyyymmdd,'합계') yyyymmdd
	,	sum(a_cnt1) a_cnt1, sum(d_cnt1) d_cnt1, sum(u_cnt1) u_cnt1
		, case when sum(a_cnt1) > 0 then sum(d_cnt1+u_cnt1)*100.0 / sum(a_cnt1) else 0 end
		, case when sum(d_cnt1+u_cnt1) > 0 then sum(u_cnt1)*100.0 / sum(d_cnt1+u_cnt1) else 0 end


	,	sum(a_cnt2) a_cnt2, sum(d_cnt2) d_cnt2, sum(u_cnt2) u_cnt2
		, case when sum(a_cnt2) > 0 then sum(d_cnt2+u_cnt2)*100.0 / sum(a_cnt2) else 0 end
		, case when sum(d_cnt2+u_cnt2) > 0 then sum(u_cnt2)*100.0 / sum(d_cnt2+u_cnt2) else 0 end


	,	sum(a_cnt3) a_cnt3, sum(d_cnt3) d_cnt3, sum(u_cnt3) u_cnt3
		, case when sum(a_cnt3) > 0 then sum(d_cnt3+u_cnt3)*100.0 / sum(a_cnt3) else 0 end
		, case when sum(d_cnt3+u_cnt3) > 0 then sum(u_cnt3)*100.0 / sum(d_cnt3+u_cnt3) else 0 end
	from
	(
		select yyyymmdd
			, isnull(case when mm_id = 'yeoni528' then d_cnt end ,0)  d_cnt1
			, isnull(case when mm_id = 'yeoni528' then u_cnt end ,0)  u_cnt1
			, isnull(case when mm_id = 'yeoni528' then a_cnt end ,0)  a_cnt1

			, isnull(case when mm_id = 'aridel' then d_cnt end ,0) d_cnt2
			, isnull(case when mm_id = 'aridel' then u_cnt end ,0) u_cnt2
			, isnull(case when mm_id = 'aridel' then a_cnt end,0)  a_cnt2

			, isnull(case when mm_id = 'hur1207' then d_cnt end ,0) d_cnt3
			, isnull(case when mm_id = 'hur1207' then u_cnt end ,0) u_cnt3
			, isnull(case when mm_id = 'hur1207' then a_cnt end ,0) a_cnt3
		from #temp_work
	) a 
	group by yyyymmdd
	with rollup
	order by yyyymmdd asc



