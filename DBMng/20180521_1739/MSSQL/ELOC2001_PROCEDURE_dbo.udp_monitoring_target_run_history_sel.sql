/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_run_history_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-18 20:27:47.46
 *        Modify: 2018-05-03 17:23:34.93
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_run_history_sel
	@run_start smalldatetime
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-03-18
	-- 설  명 : 모니터링 데이터 수집
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select run_start, run_end, sum(run_cnt)
	,	sum(case when chg_type = 1 then run_cnt end)
	,	sum(case when chg_type = 2 then run_cnt end)
	,	sum(case when chg_type = 3 then run_cnt end)
	,	sum(case when chg_type = 5 then run_cnt end)
	,	sum(case when chg_type = 8 then run_cnt end)
	,	sum(case when chg_type = 12 then run_cnt end)
	,	sum(case when chg_type = 14 then run_cnt end)
	,	sum(case when chg_type = 17 then run_cnt end)
	,	sum(case when chg_type = 18 then run_cnt end)
	,	sum(case when chg_type = 19 then run_cnt end)
	,	sum(case when chg_type = 20 then run_cnt end)
	,	sum(case when chg_type = 21 then run_cnt end)
	,	sum(case when chg_type = 22 then run_cnt end)
	,	sum(case when chg_type = 23 then run_cnt end)
	,	sum(case when chg_type = 24 then run_cnt end)
	,	sum(case when chg_type = 25 then run_cnt end)
	from
	(
		select run_start, run_end, chg_type, sum(run_cnt) run_cnt
		from tbl_monitoring_target_run_history
		where run_start >= @run_start and run_start < @run_start+1
		and chg_type in (
			select monitor_no from tbl_monitoring_team_agg_name where is_use = 1
		)
		group by run_start, run_end, chg_type		
	) a
	group by run_start, run_end
	order by run_start





