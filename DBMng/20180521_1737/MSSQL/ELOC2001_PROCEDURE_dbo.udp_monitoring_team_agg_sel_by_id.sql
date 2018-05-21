/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_id
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-03 14:06:15.097
 *        Modify: 2018-05-03 17:23:35.563
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_sel_by_id
	@sdate smalldatetime
,	@edate smalldatetime
,	@mm_id varchar(12)
,	@is_alba bit = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-023
	-- 설  명 : 모니터링팀 작업한 로그 통계 보기
	-- ----------------------------------------------

	-- 수정량은 오류DB결과 페이지 참조하도록 수정.
	declare @str_sdate varchar(10)
	declare @str_edate varchar(10)
	select @str_sdate=convert(varchar(10), @sdate, 120), @str_edate=convert(varchar(10), @edate+1, 120)
	

	create table #temp_work(
		mm_id varchar(12)
	,	refer_route smallint
	,	job_cnt int
	)

	-- 담당자별 작업량
if @is_alba = 1 begin

	insert into #temp_work
	exec ('select mm_id, refer_route, jog_cnt from openquery(SEARCHKEY_193, ''
					select mm_id, refer_route, count(*) jog_cnt
					from enuridb.dbo.tbl_error_report with (nolock) 
					where pl_no >0
					and mm_id in (select mm_id from enuridb.dbo.mm_enuri where mm_partcode like ''''_________411'''') 
					and regdate >=cast('''''+@str_sdate+''''' as datetime) 
					and regdate < cast('''''+@str_edate+''''' as datetime) 
					and mm_id='''''+ @mm_id+'''''
					group by mm_id, refer_route 
					'')')

	select isnull(x.monitor_no,256) as monitor_no, case when x.monitor_no is null then '총량' else max(x.monitor_name) end as monitor_name
	, sum(y.dcnt+y.ucnt) as ud_sum
	, sum(dcnt) dcnt
	, sum(ucnt) ucnt
	, sum(out_cnt) out_cnt
	, sum(in_cnt) in_cnt
	from tbl_monitoring_team_agg_name  x
		left outer join 
	(
		select mm_id, monitor_no, sum(dcnt) dcnt,  sum(ucnt) ucnt
		from 
		(
			select mm_id, monitor_no, isnull(sum(delete_cnt),0) as dcnt, 0 as ucnt--isnull(sum(update_cnt),0) as ucnt
			from tbl_monitoring_team_agg_work
			where agg_date >= @sdate and agg_date < @edate+1 and mm_id = @mm_id
			group by mm_id, monitor_no


			union all

			select mm_id, refer_route, 0, isnull(job_cnt,0) as ucnt  
			from #temp_work
		) a
		group by mm_id, monitor_no

	) y on x.monitor_no = y.monitor_no
		left outer join 
	(
		select monitor_no, out_cnt, all_cnt-out_cnt as in_cnt
		from tbl_monitoring_team_agg_alba
		where regdate>= @sdate and regdate<@edate+1 and mm_id = @mm_id
		and day(@sdate) = 22 and day(@edate) = 21 and datediff(m, @sdate, @edate) = 1
	) z on x.monitor_no = z.monitor_no
--	where x.is_use=1
	group by x.monitor_no with rollup
	order by isnull(x.monitor_no,256)
end else begin

	insert into #temp_work
	exec ('select mm_id, refer_route, jog_cnt from openquery(SEARCHKEY_193, ''
					select mm_id, refer_route, count(*) jog_cnt
					from enuridb.dbo.tbl_error_report with (nolock) 
					where pl_no >0
					and mm_id in (select mm_id from enuridb.dbo.mm_enuri where mm_partcode like ''''_________464'''' and mm_flag=''''1'''') 
					and regdate >=cast('''''+@str_sdate+''''' as datetime) 
					and regdate < cast('''''+@str_edate+''''' as datetime) 
					and mm_id='''''+ @mm_id+'''''
					group by mm_id, refer_route 
					'')')

	select isnull(x.monitor_no,256) as monitor_no, case when x.monitor_no is null then '총량' else max(x.monitor_name) end as monitor_name
	, sum(y.dcnt+y.ucnt) as ud_sum
	, sum(dcnt) dcnt
	, sum(ucnt) ucnt
	from tbl_monitoring_team_agg_name x
		left outer join 
	(
		select mm_id, monitor_no, sum(dcnt) dcnt,  sum(ucnt) ucnt
		from 
		(
			select mm_id, monitor_no, isnull(sum(delete_cnt),0) as dcnt, 0 as ucnt--isnull(sum(update_cnt),0) as ucnt
			from tbl_monitoring_team_agg_work
			where agg_date >= @sdate and agg_date < @edate+1 and mm_id = @mm_id
			group by mm_id, monitor_no


			union all

			select mm_id, refer_route, 0, isnull(job_cnt,0) as ucnt  
			from #temp_work
		) a
		group by mm_id, monitor_no

	) y on x.monitor_no = y.monitor_no
--	where x.is_use=1
	group by x.monitor_no with rollup
	order by isnull(x.monitor_no,256)
end



