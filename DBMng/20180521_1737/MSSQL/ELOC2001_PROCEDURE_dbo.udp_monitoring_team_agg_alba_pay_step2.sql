/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_alba_pay_step2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-26 14:46:34.293
 *        Modify: 2018-01-19 10:53:59.65
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_alba_pay_step2
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-11-20
	-- ��  �� : ����͸��� �˹� �޿� ����
	--          �ſ� ������ ��¥�� ������ �Ⱓ������ ������ ����
	--			�Ⱓ : ���� 22�� ~ ��� 21��
	--	196���� udp_monitoring_team_agg_alba_pay_step1 ���� �Ŀ� ����Ǿ���Ѵ�.
	-- ��  �� : udp_monitoring_team_agg_sel_by_id_alba : jca�� �޿� Ȯ�� ���� ����޿� ǥ�� 
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2015.02.16		wookki25		pl_status in ('0', '1') --> pl_status in ('0', '1', '8')
	2015.02.16		wookki25		�ٹ������� ���� �޿� ���̺� ���� ���� / work_years ���� �߰�
	2017.02.06		wookki25		GS����͸� �Ӽ� ���� �߰� // goods_catalog_attribute_del_bak ���̺� ����
	*/

	-- �ٹ����� :  �������� 12���������� 1���� // 13�������� 24�������� 2���� // 25�������� 3����
	select mm_id, mm_nm, mm_enterdate, (datediff(m, mm_enterdate, getdate()) / 12) +1 work_years
	into #work_years
	from MPDB02.member.dbo.mm_enuri where mm_id in (
		select distinct mm_id from tbl_monitoring_team_agg_alba_desc
		--union
		--select 'aridel' union
		--select 'hur1207' union
		--select 'yeoni528'
	)
	order by 3

	-- �ٹ����� : 3�� �̻� �ٹ��ڴ� ������ �޿� ���̺� ���
	update #work_years
	set work_years = 3
	where  work_years > 3

/*

	-- ��������� ����, ����, �ɼ��ڵ� üũ�ؼ� ��� 0�� ��츸
	-- ���Ī ���� ī�����Ѵ�.
	update  a 
	set is_out_target = 1
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where pl_status in ('0', '1', '8') and pl_srvflag ='0' and option_flag2='0'


	-- ����Է� : �׸� ���Ī ���� ����
	-- tbl_monitoring_team_agg, error_report������ ����
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 and old_modelno + new_modelno >0 and old_modelno = new_modelno then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	group by mm_id, monitor_no

*/



	-- ��������� ����, ����, �ɼ��ڵ� üũ�ؼ� ��� 0�� ��츸
	-- ���Ī ���� ī�����Ѵ�.
	update  a 
	set is_out_target = 1
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where pl_status in ('0', '1', '8') and pl_srvflag ='0' and option_flag2='0'
	and monitor_no not in (25) -- GS�Ӽ� ����͸� ����

	-- ����Է� : �׸� ���Ī ���� ����
	-- tbl_monitoring_team_agg, error_report������ ����
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 and old_modelno + new_modelno >0 and old_modelno = new_modelno then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	where monitor_no not in (25) -- GS�Ӽ� ����͸� ����
	group by mm_id, monitor_no

	-- -----------------------------------------
	-- ����ó�� : GS�Ӽ� ����͸� �׸�
	-- alter table tbl_monitoring_team_agg_alba_desc add job_modelno int not null default(0)
	-- -----------------------------------------
	-- ����
	update  a 
	set is_out_target = 1 -- ����
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS�Ӽ� ����͸�

	-- ���� : ����͸� �� �Ӽ� ������ �ִ� ���
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS�Ӽ� ����͸�
	and is_out_target = 1
	and exists (select top 1 * from goods_catalog_attribute where g_modelno = job_modelno and upd_date > job_date)
	

	-- ���� : �Ӽ������� ���� ��� �޾ƾ��Ѵ�. // goods_catalog_attribute_del_bak
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS�Ӽ� ����͸�
	and is_out_target = 1
	and exists (select top 1 * from goods_catalog_attribute_del_bak where g_modelno = job_modelno and upd_date > job_date)

	-- ���� : �۾� �𵨹�ȣ�� ���� �𵨹�ȣ�� �ٸ� ���
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where monitor_no = 25 -- GS�Ӽ� ����͸�
	and is_out_target = 1
	and job_modelno <> pl_modelno

	-- ����Է� : �׸� ���Ī ���� ����
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	where monitor_no = 25 -- GS�Ӽ� ����͸�
	group by mm_id, monitor_no



	-- ������ �޿� �Է�
	insert into tbl_monitoring_team_agg_alba_pay(mm_id, fix_cnt, fix_pay)
	select a.mm_id, a.fix_cnt, (case when a.mm_id = 'aridel' then round((b.work_pay*23)/31, -2, 0) else b.work_pay end )as fix_pay
	from
	(
		select mm_id, sum(all_cnt-out_cnt) fix_cnt
		from tbl_monitoring_team_agg_alba
		where regdate >= cast(convert(varchar(10), getdate(),120) as smalldatetime)
		and regdate< cast(convert(varchar(10), getdate(),120) as smalldatetime)+1
		group by mm_id
	) a 
		inner join #work_years c on a.mm_id = c.mm_id
		inner join tbl_monitoring_team_agg_alba_pay_table b on work_cnt = fix_cnt and b.work_years = c.work_years


	-- �۾� ���̺� ����
	truncate table tbl_monitoring_team_agg_alba_desc

	-- ���� ���̺� ������ ���� : �ݿ�, ���� �����͸� ����
	delete from goods_catalog_attribute_del_bak 
	where del_date < dateadd(m, -1, cast(dateadd(d, -day(getdate())+1, getdate()) as date))
end
