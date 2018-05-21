/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_work_sel_case1_desc
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-23 20:32:40.563
 *        Modify: 2018-05-03 17:23:35.92
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_work_sel_case1_desc
	@sdate smalldatetime
,	@edate smalldatetime
,	@order int
,	@cate varchar(10)
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

	-- select *  from tbl_monitoring_team_agg_name

	select	cate
		,	cate_name =  (select cm_name from c_mcate where cm_lcode = left(cate,2) and cm_mcode = right(cate,2))
		,	sum(dcnt)
		,	sum(ucnt)
		,	case when sum(ucnt+dcnt) >  0 then round((sum(ucnt)*100.0) / (sum(ucnt+dcnt)*1.0), 1) else 0 end

		,	max(case monitor_no when 1 then dcnt end)
		,	max(case monitor_no when 1 then ucnt end)		
		,	round(max(case monitor_no when 1 then uratio end), 1)
--
--		,	max(case monitor_no when 2 then dcnt end)
--		,	max(case monitor_no when 2 then ucnt end)	
--		,	round(max(case monitor_no when 2 then uratio end), 1)
--
--		,	max(case monitor_no when 3 then dcnt end)
--		,	max(case monitor_no when 3 then ucnt end)	
--		,	round(max(case monitor_no when 3 then uratio end), 1)
										   
		,	max(case monitor_no when 5 then dcnt end)
		,	max(case monitor_no when 5 then ucnt end)	
		,	round(max(case monitor_no when 5 then uratio end), 1)
										   
		,	max(case monitor_no when 8 then dcnt end)
		,	max(case monitor_no when 8 then ucnt end)	
		,	round(max(case monitor_no when 8 then uratio end), 1)

		,	max(case monitor_no when 10 then dcnt end)
		,	max(case monitor_no when 10 then ucnt end)	
		,	round(max(case monitor_no when 10 then uratio end), 1)


		,	max(case monitor_no when 12 then dcnt end)
		,	max(case monitor_no when 12 then ucnt end)	
		,	round(max(case monitor_no when 12 then uratio end), 1)

		,	max(case monitor_no when 14 then dcnt end)
		,	max(case monitor_no when 14 then ucnt end)	
		,	round(max(case monitor_no when 14 then uratio end), 1)

		,	max(case monitor_no when 17 then dcnt end)
		,	max(case monitor_no when 17 then ucnt end)	
		,	round(max(case monitor_no when 17 then uratio end), 1)

		,	max(case monitor_no when 18 then dcnt end)
		,	max(case monitor_no when 18 then ucnt end)	
		,	round(max(case monitor_no when 18 then uratio end), 1)

		,	max(case monitor_no when 19 then dcnt end)
		,	max(case monitor_no when 19 then ucnt end)	
		,	round(max(case monitor_no when 19 then uratio end), 1)

		,	max(case monitor_no when 20 then dcnt end)
		,	max(case monitor_no when 20 then ucnt end)	
		,	round(max(case monitor_no when 20 then uratio end), 1)

		,	max(case monitor_no when 21 then dcnt end)
		,	max(case monitor_no when 21 then ucnt end)	
		,	round(max(case monitor_no when 21 then uratio end), 1)

		,	max(case monitor_no when 22 then dcnt end)
		,	max(case monitor_no when 22 then ucnt end)	
		,	round(max(case monitor_no when 22 then uratio end), 1)

		,	max(case monitor_no when 23 then dcnt end)
		,	max(case monitor_no when 23 then ucnt end)	
		,	round(max(case monitor_no when 23 then uratio end), 1)

		,	max(case monitor_no when 24 then dcnt end)
		,	max(case monitor_no when 24 then ucnt end)	
		,	round(max(case monitor_no when 24 then uratio end), 1)

		,	max(case monitor_no when 25 then dcnt end)
		,	max(case monitor_no when 25 then ucnt end)	
		,	round(max(case monitor_no when 25 then uratio end), 1)

		,ordercol = case @order -- 항상 select 컬럼의 마지막 컬럼이 되면 된다.
					when 2 then sum(dcnt)
					when 3 then sum(ucnt)
					else (case when sum(ucnt+dcnt) > 0 then round((sum(ucnt)*100.0) / (sum(ucnt+dcnt)*1.0), 1) else 0 end) end
	from
	(
			select monitor_no, left(category, 4) cate, sum(delete_cnt) dcnt, sum(update_cnt) ucnt
				, case when sum(delete_cnt+update_cnt) > 0 then round((sum(update_cnt)*100.0) / (sum(delete_cnt+update_cnt)*1.0),1) else 0 end uratio
			from tbl_monitoring_team_agg_work
			where agg_date between @sdate and @edate	
			and monitor_no in (
				select monitor_no from tbl_monitoring_team_agg_name where is_use = 1
			)	
			and category like @cate+'%'
			and delete_cnt+update_cnt > 0
			group by monitor_no, left(category, 4)
	)a
	group by cate
	order by ordercol desc










