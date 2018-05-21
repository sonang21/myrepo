/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_no_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-04 16:03:52.237
 *        Modify: 2018-05-03 17:23:35.667
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_monitoring_team_agg_sel_by_no_cate
	@sdate smalldatetime
,	@edate smalldatetime
,	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-023
	-- 설  명 : 모니터링팀 작업한 로그 통계 보기
	-- ----------------------------------------------
	-- 전체 작업량
	select (select monitor_name from tbl_monitoring_team_agg_name where monitor_no=@monitor_no) as monitor_name
	, category
	, sum(y.tcnt) as tcnt

	, sum(y.dcnt+y.ucnt) as ud_sum
	, case when sum(y.tcnt)=0 then 0 else (sum(y.dcnt+y.ucnt)*100.0)/(sum(y.tcnt)*1.0) end ud_ratio

	, sum(y.dcnt) as dcnt
	, case when sum(y.tcnt)=0 then 0 else (sum(y.dcnt)*100.0)/(sum(y.tcnt)*1.0) end d_ratio

	, sum(y.ucnt) as unct
	, case when sum(y.tcnt)=0 then 0 else (sum(y.ucnt)*100.0)/(sum(y.tcnt)*1.0) end u_ratio	
	from 
	(
		select  category, sum(target_cnt) as tcnt, 0 as dcnt, 0 as ucnt
		from tbl_monitoring_team_agg_target
		where agg_date >= @sdate and agg_date < @edate+1
		and monitor_no=@monitor_no
		group by category

		union all

		select category, 0 tcnt, sum(delete_cnt) as dcnt, sum(update_cnt) as ucnt
		from tbl_monitoring_team_agg_work a-- inner join @mm_id_rs as b
		--	on a.mm_id = b.mm_id
		where agg_date >= @sdate and agg_date < @edate+1
		and monitor_no=@monitor_no
		group by category
	) y
	group by y.category with rollup
	order by case when y.category is null then '총계' else y.category end asc
