/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_work_sel_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-05-19 14:09:28.69
 *        Modify: 2018-05-03 17:23:35.087
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_work_sel_excel
	@sdate date
,	@edate date
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2016.05.19
	-- ��  �� : �۾����.����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	-- ��������
	select * into #mm from openquery (SEARCHKEY_193, 'select mm_id, mm_nm from enuridb.dbo.mm_enuri')


	-- �����
	select a.monitor_no, b.monitor_name, a.mm_id, c.mm_nm, category, delete_cnt, update_cnt, assign_cnt, agg_date
	from tbl_monitoring_team_agg_work a 
		left outer join tbl_monitoring_team_agg_name b on  a.monitor_no =  b.monitor_no
		left outer join #mm c on a.mm_id = c.mm_id
	where agg_date >= @sdate and agg_date < dateadd(d, 1, @edate)

