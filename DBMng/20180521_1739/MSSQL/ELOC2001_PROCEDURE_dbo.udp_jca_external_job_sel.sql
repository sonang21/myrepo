/* *************************************************************************
 * NAME : dbo.udp_jca_external_job_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-04-14 11:36:26.913
 *        Modify: 2018-05-03 17:23:34.77
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_jca_external_job_sel
	@job_date date
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� :  wookki25 / 2017.04.14
	-- ��   �� :  gs �۾���
	-- http://58.234.199.100/redmine/issues/21859
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	select isnull(mm_id, '�հ�')
	, isnull(SUM(case when job_flag ='m' then p_cnt end) ,0) -- �Ӽ��ִ� �𵨿� ��ȣ ��Ī ��ǰ ��
	, isnull(SUM(case when job_flag ='s' then p_cnt end) ,0) -- �����ǰ���� �Ϲݻ�ǰ���� ��ȯ�� �𵨿� ��Ī�Ǿ��ִ� ��ǰ �� (���� �������̳� �׷��Ī���� �ڵ����� ��Ī�� ��ǰ)
	from TBL_EXTERNAL_JOB_AGG
	where job_date = @job_date
	group by mm_id
	with rollup
end
