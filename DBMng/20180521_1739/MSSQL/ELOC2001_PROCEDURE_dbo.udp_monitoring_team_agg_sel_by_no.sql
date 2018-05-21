/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_sel_by_no
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-04 15:58:02.17
 *        Modify: 2018-05-03 17:23:35.647
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_sel_by_no
	@sdate smalldatetime
,	@edate smalldatetime
,	@is_alba bit = null
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

	-- 전체 작업량
	select isnull(x.monitor_no,256) as monitor_no, case when x.monitor_no is null then '총량' else max(x.monitor_name) end as monitor_name
	, sum(y.tcnt) as tcnt
	, 0 as del_column--case when sum(y.dcnt+y.ucnt)=0 then 0 else sum(y.dcnt*100.0)/sum((y.dcnt+y.ucnt)*1.0) end d_ratio -- 확인률	
	, case when sum(y.dcnt+y.ucnt)=0 then 0 else sum(y.ucnt*100.0)/sum((y.dcnt+y.ucnt)*1.0) end u_ratio -- 수정률
	, sum(y.dcnt+y.ucnt) as ud_sum
	, sum(y.dcnt) as dcnt
	, sum(y.ucnt) as unct 
	from tbl_monitoring_team_agg_name x --  where is_alba = isnull(@is_alba, is_alba)
		left outer join 
	(
		select  monitor_no, sum(target_cnt) as tcnt, 0 as dcnt, 0 as ucnt
		from tbl_monitoring_team_agg_target
		where agg_date >= @sdate and agg_date < @edate+1
		group by monitor_no

		union all

		select monitor_no, 0 tcnt, sum(delete_cnt) as dcnt, sum(update_cnt) as ucnt
		from tbl_monitoring_team_agg_work a
		where agg_date >= @sdate and agg_date < @edate+1
		--and mm_id not in (select mm_id from mpdb02.member.dbo.mm_enuri where mm_partcode like '_________411')
		group by monitor_no
	) y
		on x.monitor_no = y.monitor_no
	group by x.monitor_no with rollup
	order by isnull(x.monitor_no,256) asc
