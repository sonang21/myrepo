/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-03 09:15:35.68
 *        Modify: 2018-05-03 17:23:35.52
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-01-02
	-- ��  �� : ����͸��� �۾��� ����� ����
	--			monitoring_team_agg_target.monitor_no	
	--			1 : ���θ� ��ǰ�� ���� : tbl_strange_list
	--			2 : ���θ� ������ ���� : tbl_strange_list
	--			3 : ������ ���� : tbl_strange_list
	--			4 : ����<���� ������ : tbl_strange_list
	--			5 : ���������â : pricelist_matching_alarm_srch
	--			6 : �ɼ�ǰ�� : tbl_pricelist_option_ctu_detail
	--			7 : �ɼǺ��� : tbl_pricelist_option_diff_detail
	--			8 : ������ : pricelist_dml_log
	--			9 : �ְ����â : pricelist_matching_alarm_srch
	--			10 : �ǽð� ������  : pricelist_matching_alarm_srch
	--			11 : �ɼǺ���_���һ�ǰ : tbl_pricelist_option_diff_copyplno
	-- ----------------------------------------------


	 -- �ָ� ���� // 2014.12.09 �ָ��� ó���ǵ���.
	 --if datepart(dw, getdate()) between 2 and 6 begin
--		if @monitor_no = 0 or @monitor_no = 1
--			exec udp_monitoring_team_agg_target_case1 1
--
--		if @monitor_no = 0 or @monitor_no = 2
--			exec udp_monitoring_team_agg_target_case1 2
--
--		if @monitor_no = 0 or @monitor_no = 3
--			exec udp_monitoring_team_agg_target_case1 3
--		-- 2014.06.26 ����ó��. ������ ��û. ������
--		-- ���� ����� �� �־� �ּ�ó����.
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
		-- 2014.06.26 ����ó��. ������ ��û. ������
		-- ���� ����� �� �־� �ּ�ó����.
		if @monitor_no = 0 or @monitor_no = 9
			exec udp_monitoring_team_agg_target_case2 9
		*/

--		if @monitor_no = 0 or @monitor_no = 11
--			exec udp_monitoring_team_agg_target_case5 11


		-- ���ܺз� ����
--		delete from tbl_monitoring_team_agg_target 
--		where agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime) and category >= '90'
--		and monitor_no in (5,6,7,11)


