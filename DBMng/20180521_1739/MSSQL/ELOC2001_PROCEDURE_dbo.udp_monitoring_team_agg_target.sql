/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-03 09:15:35.68
 *        Modify: 2018-05-03 17:23:35.52
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-01-02
	-- 설  명 : 모니터링팀 작업할 대상의 개수
	--			monitoring_team_agg_target.monitor_no	
	--			1 : 쇼핑몰 상품명 변경 : tbl_strange_list
	--			2 : 쇼핑몰 최저가 변경 : tbl_strange_list
	--			3 : 전일저 최저 : tbl_strange_list
	--			4 : 무료<유료 최저가 : tbl_strange_list
	--			5 : 최저가경고창 : pricelist_matching_alarm_srch
	--			6 : 옵션품절 : tbl_pricelist_option_ctu_detail
	--			7 : 옵션변경 : tbl_pricelist_option_diff_detail
	--			8 : 전일저 : pricelist_dml_log
	--			9 : 최고가경고창 : pricelist_matching_alarm_srch
	--			10 : 실시간 최저가  : pricelist_matching_alarm_srch
	--			11 : 옵션변경_분할상품 : tbl_pricelist_option_diff_copyplno
	-- ----------------------------------------------


	 -- 주말 제외 // 2014.12.09 주말도 처리되도록.
	 --if datepart(dw, getdate()) between 2 and 6 begin
--		if @monitor_no = 0 or @monitor_no = 1
--			exec udp_monitoring_team_agg_target_case1 1
--
--		if @monitor_no = 0 or @monitor_no = 2
--			exec udp_monitoring_team_agg_target_case1 2
--
--		if @monitor_no = 0 or @monitor_no = 3
--			exec udp_monitoring_team_agg_target_case1 3
--		-- 2014.06.26 삭제처리. 권혁준 요청. 사용안함
--		-- 추후 사용할 수 있어 주석처리함.
--		if @monitor_no = 0 or @monitor_no = 4
--			exec udp_monitoring_team_agg_target_case1 4
--	--end
--
		if @monitor_no = 0 or @monitor_no = 5
			exec udp_monitoring_team_agg_target_case2 5


--		if @monitor_no = 0 or @monitor_no = 6
--			exec udp_monitoring_team_agg_target_case3 6
--	
--		if @monitor_no = 0 or @monitor_no = 7
--			exec udp_monitoring_team_agg_target_case4 7

		/*
		-- 2014.06.26 삭제처리. 권혁준 요청. 사용안함
		-- 추후 사용할 수 있어 주석처리함.
		if @monitor_no = 0 or @monitor_no = 9
			exec udp_monitoring_team_agg_target_case2 9
		*/

--		if @monitor_no = 0 or @monitor_no = 11
--			exec udp_monitoring_team_agg_target_case5 11


		-- 제외분류 삭제
--		delete from tbl_monitoring_team_agg_target 
--		where agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime) and category >= '90'
--		and monitor_no in (5,6,7,11)


