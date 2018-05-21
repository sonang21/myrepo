/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_no_alba
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-12-02 17:02:01.913
 *        Modify: 2017-07-24 16:18:25.62
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_sel_by_no_alba
	@sdate smalldatetime
,	@edate smalldatetime
--,	@mm_id_csv varchar(1000)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-023
	-- 설  명 : 모니터링팀 작업한 로그 통계 보기
	-- ----------------------------------------------
/*	
	declare @mm_id_rs table(mm_id varchar(12))
	insert into @mm_id_rs
	select distinct cast(substring(vals, s, e-s) as varchar(12))
	from 
	(  
		select  min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
		from 	(select @mm_id_csv vals) a  
				inner join master.dbo.spt_values b 
				on len(a.vals) >= b.number and type='p'
		group by charindex (',',vals+',',number)
	) a
*/

	-- 수정량은 오류DB결과 페이지 참조하도록 수정.
	declare @str_sdate varchar(10)
	declare @str_edate varchar(10)
	select @str_sdate=convert(varchar(10), @sdate, 120), @str_edate=convert(varchar(10), @edate+1, 120)
	

	create table #temp_work(
		refer_route smallint
	,	job_cnt int
	)


	insert into #temp_work
	exec ('select refer_route, jog_cnt from openquery(SEARCHKEY_193, ''
					select refer_route, count(*) jog_cnt
					from enuridb.dbo.tbl_error_report with (nolock) 
					where pl_no >0
					and mm_id in (select mm_id from enuridb.dbo.mm_enuri where mm_partcode like ''''_________411'''') 
					and regdate >=cast('''''+@str_sdate+''''' as datetime) 
					and regdate < cast('''''+@str_edate+''''' as datetime) 
					group by refer_route 
					'')')


	-- 전체 작업량
	select isnull(x.monitor_no,256) as monitor_no, case when x.monitor_no is null then '총량' else max(x.monitor_name) end as monitor_name
	, sum(y.tcnt) as tcnt

	, case when sum(y.tcnt)=0 then 0 else sum((y.dcnt+y.ucnt)*100.0)/sum(y.tcnt*1.0) end d_ratio -- 작업률

	, case when sum(y.dcnt+y.ucnt)=0 then 0 else sum(y.ucnt*100.0)/sum((y.dcnt+y.ucnt)*1.0) end u_ratio
	, sum(y.dcnt+y.ucnt) as ud_sum
	, sum(y.dcnt) as dcnt, sum(y.ucnt) as unct
	from (select * from tbl_monitoring_team_agg_name where is_alba = 1) x
		left outer join 
	(
		select  monitor_no, sum(target_cnt) as tcnt, 0 as dcnt, 0 as ucnt
		from tbl_monitoring_team_agg_target
		where agg_date >= @sdate and agg_date < @edate+1
		group by monitor_no

		union all

		select monitor_no, 0 tcnt, sum(delete_cnt) as dcnt, 0  as ucnt--sum(update_cnt) as ucnt
		from tbl_monitoring_team_agg_work a-- inner join @mm_id_rs as b
		--	on a.mm_id = b.mm_id
		where agg_date >= @sdate and agg_date < @edate+1
		and mm_id in (select mm_id from mpdb02.member.dbo.mm_enuri where mm_partcode like '_________411')
		group by monitor_no


		union all


		select refer_route, 0, 0, job_cnt as ucnt  from #temp_work
	
	) y
		on x.monitor_no = y.monitor_no
	where x.is_use=1
	group by x.monitor_no with rollup
	order by isnull(x.monitor_no,256) asc

