/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_diff_copyplno_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-06 09:30:28.577
 *        Modify: 2018-05-03 17:23:34.57
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pricelist_option_diff_copyplno_ins
AS
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013-08-06
	-- ��  �� : �ɼǺ��� ��ǰ�� ���� ��ǰ ��󳻱�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/*
	������:			������:			��������:
	-------------------------------------------------
	*/

	-- ������ ����
	select pl_no into #tmp_pricelist_option_diff from openquery(oradb, 'select pl_no from tbl_pricelist_option_diff')


	-- ���ҿ��� Ȯ��
	insert into tbl_pricelist_option_diff_copyplno(regdate, pl_vcode, pl_category, pl_goodscode)
	select convert(varchar(10),  getdate(), 120), max(pl_vcode), max(pl_category), pl_goodscode
	from #tmp_pricelist_option_diff a inner join pricelist b
	on a.pl_no = b.pl_no
	where b.pl_copyplno > 0
	group by pl_goodscode
	-- and b.pl_category like '1007%'


	-- �ֱ� 3�� �����͸� ����
	delete from tbl_pricelist_option_diff_copyplno where regdate <= getdate()-3
