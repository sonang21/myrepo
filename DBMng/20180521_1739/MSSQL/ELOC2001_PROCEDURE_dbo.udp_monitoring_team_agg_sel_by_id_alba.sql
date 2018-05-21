/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_id_alba
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-19 20:36:11.207
 *        Modify: 2018-05-03 17:23:35.17
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_sel_by_id_alba
	@sdate smalldatetime
,	@edate smalldatetime
,	@mm_id varchar(12)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-023
	-- 설  명 : 모니터링팀 작업한 로그 통계 보기
	-- 참  조 : udp_monitoring_team_agg_alba_pay_step2 : 급여산정
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2015.02.16		wookki25		근무연차에 따른 급여 테이블 차등 적용 / work_years 조건 추가
	*/

	-- 수정량은 오류DB결과 페이지 참조하도록 수정.
	declare @str_sdate varchar(10)
	declare @str_edate varchar(10)
	select @str_sdate=convert(varchar(10), @sdate, 120), @str_edate=convert(varchar(10), @edate+1, 120)
	

	create table #temp_work(
		job_cnt int
	,	work_years int
	)
	insert into #temp_work
	exec ('select jog_cnt, work_years from openquery(SEARCHKEY_193, ''
					select a.mm_id, count(*) jog_cnt, ((datediff(m, max(mm_enterdate), getdate()) / 12) +1) work_years
					from enuridb.dbo.tbl_error_report a with (readuncommitted) inner join enuridb.dbo.mm_enuri b on a.mm_id = b.mm_id
					where pl_no >0
					and a.mm_id='''''+ @mm_id+'''''
					and regdate >=cast('''''+@str_sdate+''''' as datetime) 
					and regdate < cast('''''+@str_edate+''''' as datetime) 
					group by a.mm_id
					'')')

	-- 근무연차 : 월단위로 12개월까지는 1년차 // 13개월부터 24개월까지 2년차 // 25개월부터 3년차
	-- 근무연차 : 3년 이상 근무자는 동일한 급여 테이블 사용
	update #temp_work 
	set work_years = 3
	where work_years > 3

	select dcnt
	, ucnt
	, pre_pay = (select work_pay from tbl_monitoring_team_agg_alba_pay_table b where a.ucnt = b.work_cnt and work_years=(select work_years from #temp_work))
	, out_cnt
	, in_cnt
	, fix_pay = (select work_pay from tbl_monitoring_team_agg_alba_pay_table b where a.in_cnt = b.work_cnt and work_years=(select work_years from #temp_work))
	from
	(
		select sum(dcnt) dcnt, sum(ucnt) ucnt, sum(out_cnt) out_cnt, sum(in_cnt) in_cnt
		from
		(
			-- 확인개수
			select isnull(sum(delete_cnt),0) as dcnt, 0 as ucnt, 0 as out_cnt, 0 as in_cnt
			from tbl_monitoring_team_agg_work
			where agg_date >= @sdate and agg_date < @edate+1
			and monitor_no in (
				select monitor_no from tbl_monitoring_team_agg_name where is_use = 1
			)
			and mm_id = @mm_id
			

			union all

			-- 수정개수
			select 0 dcnt, isnull(job_cnt,0) as ucnt, 0 as out_cnt, 0 as in_cnt  
			from #temp_work

			union all

			-- 재매칭, 실수정
			select 0, 0, sum(out_cnt), sum(all_cnt-out_cnt) as in_cnt
			from tbl_monitoring_team_agg_alba
			where day(@sdate) = 22 and day(@edate) = 21 
			and regdate>= case when @sdate = cast('2018-01-22' as date) then  cast('2018-02-01' as date) else @edate end and regdate< dateadd(m, 1, @edate)			
			and datediff(m, @sdate, @edate) = 1
			and mm_id = @mm_id

		) result_set
	) a 
	where ucnt+dcnt > 0
