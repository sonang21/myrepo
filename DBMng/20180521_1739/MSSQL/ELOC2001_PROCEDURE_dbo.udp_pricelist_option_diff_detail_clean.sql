/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_diff_detail_clean
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-10-10 14:12:09.95
 *        Modify: 2018-05-03 17:23:34.52
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_pricelist_option_diff_detail_clean
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-10-10
	-- ��  �� : �ɼǺ��� �������� �ʿ���� ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	-- ����/����
	create table #del_option(del_option varchar(10) primary key)	
	insert into #del_option(del_option) select '����' union all select '��Ȳ' union all select '���'
	insert into #del_option(del_option) select '�ʷ�' union all select '�Ķ�' union all select '����'
	insert into #del_option(del_option) select '����' union all select '����' union all select '���'
	insert into #del_option(del_option) select '�Ķ�' union all select '����' union all select '����'
	insert into #del_option(del_option) select '���̿÷�' union all select '���̿ø�' union all select '��ũ'
	insert into #del_option(del_option) select '������' union all select '����' union all select '������'
	insert into #del_option(del_option) select '����' union all select 'ȭ��Ʈ' union all select '��'
	insert into #del_option(del_option) select '���' union all select 'ü��' union all select '��'
	insert into #del_option(del_option) select '����' union all select 'û��' union all select '��Ű��'
	insert into #del_option(del_option) select '�׷���' union all select '�ǹ�' union all select '���'
	insert into #del_option(del_option) select '����' union all select '����' union all select '���'
	insert into #del_option(del_option) select '�泲' union all select '����' union all select '����'
	insert into #del_option(del_option) select '���' union all select '����' union all select '��õ'
	insert into #del_option(del_option) select '����' union all select '��û' union all select '�泲'
	insert into #del_option(del_option) select '����' union all select '����' union all select '���'

	create table #del_plno(pl_no bigint)

	-- ��� �ɼǰ����� 0�� pl_no�� ����	
	insert into #del_plno(pl_no)
	select pl_no
	from tbl_pricelist_option_diff_detail 
	where regdate>= cast(convert(varchar(10), getdate(), 120) as datetime)		
	group by pl_no
	having sum(t_option_price) = 0

	-- ����,���� : �ɼ�2�� ����ǥ�� or ����ǥ�Ⱑ �ְ�, ���� 0�� 1�� �̻��̸� �ش� pl_no ��� ����
	insert into #del_plno(pl_no)
	select distinct pl_no
	from tbl_pricelist_option_diff_detail where t_option_price=0 and exists(select 1 from #del_option where t_option_sub_name = del_option)

	-- ������// 09�з���. �ɼǼ����� �������� ��� ����
	insert into #del_plno(pl_no)
	select pl_no 
	from tbl_pricelist_option_diff_detail 
	where lcate = '09'
	group by pl_no
	having count(*) = sum(isnumeric(replace(t_option_sub_name,'ȣ',''))) and sum(t_option_price) = 0


	delete a from tbl_pricelist_option_diff_detail a inner join #del_plno b on a.pl_no = b.pl_no

