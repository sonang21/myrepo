/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target_case5
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-16 13:46:57.37
 *        Modify: 2018-05-03 17:23:34.04
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target_case5
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-16
	-- 설  명 : 모니터링팀 작업할 대상의 개수/tbl_pricelist_option_diff_copyplno
	--			monitoring_team_agg_target.monitor_no	
	--			11 : 옵션변경_분할상품 : tbl_pricelist_option_diff_copyplno
	-- ----------------------------------------------
	-- 입력된 데이터 삭제
	delete from tbl_monitoring_team_agg_target 
	where monitor_no = @monitor_no and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- 새로 입력
	insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
	select @monitor_no
	,	cast(convert(char(10), getdate(), 120) as smalldatetime)
	,	lcate
	,	count(*)
	from (
		select left(max(pl_category),2) as lcate
		from tbl_pricelist_option_diff_copyplno
		where p_status='i' 
		and regdate >= cast(convert(char(8), getdate(),112) as datetime)
		and regdate < cast(convert(char(8), getdate()+1,112) as datetime)
		group by pl_goodscode
	) x
	group by lcate


