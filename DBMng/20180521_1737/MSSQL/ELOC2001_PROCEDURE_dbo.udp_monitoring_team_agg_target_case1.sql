/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target_case1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 14:34:47.793
 *        Modify: 2018-05-03 17:23:35.387
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target_case1
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-02
	-- 설  명 : 모니터링팀 작업할 대상의 개수/tbl_strange_list
	--			monitoring_team_agg_target.monitor_no	
	--			1 : 쇼핑몰 상품명 변경
	--			2 : 쇼핑몰 최저가 변경
	--			3 : 전일저 최저(대분류14는 사용안함->2014.06.24 제한 풀어줌.권혁준 요청)
	--			4 : 무료<유료 최저가
	-- ----------------------------------------------
	-- 입력된 데이터 삭제
	delete from tbl_monitoring_team_agg_target 
	where monitor_no = @monitor_no and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- 새로 입력
	if @monitor_no = 1 begin --1 : 쇼핑몰 상품명 변경 // 중분류단위집계 // 2012.09.25
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'c'-- 쇼핑몰 상품명 변경
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)	
	end else if @monitor_no=2 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'p' -- 쇼핑몰 최저가 변경
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)
	end else if @monitor_no=3 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = '8' -- 전일저 최저
		--	and left(sl_category,2) <> '14' -- 제외분류 ->2014.06.24 제한 풀어줌.권혁준 요청
			and exists (select TOP 1 1 from pricelist where pl_no = sl_plno)
			group by sl_plno
		) x
		group by lcate
		option (maxdop 1)

	end else if @monitor_no=4 begin
		insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
		select @monitor_no
		,	cast(convert(char(10), getdate(), 120) as smalldatetime)
		,	lcate
		,	count(*)
		from (
			select left(max(sl_category) , 2) as lcate, sl_plno
			from tbl_strange_list
			where p_status='i' 
			and sl_srvflag = 'f' -- 무료<유료 최저가
			group by sl_plno
			having 	exists(select TOP 1 1 from pricelist where pl_no = sl_plno)
		) x
		group by lcate
		option (maxdop 1)
	end


