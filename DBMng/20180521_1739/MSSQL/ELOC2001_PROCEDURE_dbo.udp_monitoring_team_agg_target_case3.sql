/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_target_case3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 14:44:08.41
 *        Modify: 2018-05-03 17:23:35.417
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_target_case3
	@monitor_no smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-01-02
	-- ��  �� : ����͸��� �۾��� ����� ����/tbl_pricelist_option_ctu_detail
	--			monitoring_team_agg_target.monitor_no	
	--			6 : �ɼ�ǰ�� : tbl_pricelist_option_ctu_detail
	-- ----------------------------------------------
	-- �Էµ� ������ ����
	delete from tbl_monitoring_team_agg_target 
	where monitor_no = @monitor_no and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- ���� �Է�
	insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
	select @monitor_no
	,	cast(convert(char(10), getdate(), 120) as smalldatetime)
	,	lcate
	,	count(*)
	from (
		select left(max(ca_code),2) as lcate
		from tbl_pricelist_option_ctu_detail -- �ɼǳ��� �ִ� ��ǰ
		where p_status='i' 
		and regdate >= cast(convert(char(8), getdate(),112) as datetime)
		and regdate < cast(convert(char(8), getdate()+1,112) as datetime)
		group by pl_no
	) x
	group by lcate




