/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_run_history_desc_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-18 20:32:41.17
 *        Modify: 2018-05-03 17:23:34.94
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_run_history_desc_sel
	@run_start smalldatetime
,	@chg_type smallint
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
	declare @monitor_name varchar(100)	
	select top 1 @monitor_name = monitor_name 
	from tbl_monitoring_team_agg_name
	where monitor_no = @chg_type

	select @monitor_name, isnull(category,'합계') category, sum(run_cnt) run_cnt
	from tbl_monitoring_target_run_history
	where run_start between @run_start and DateAdd(hh, 1, @run_start)
	and chg_type = @chg_type
	group by category with rollup
	order by isnull(category, '9999')
	--group by left(cate,2), left(cate,4) with rollup
