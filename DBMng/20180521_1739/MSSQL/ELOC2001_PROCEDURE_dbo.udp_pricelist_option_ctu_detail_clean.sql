/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_ctu_detail_clean
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-07-18 13:47:15.097
 *        Modify: 2018-05-03 17:23:35.693
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_pricelist_option_ctu_detail_clean
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013-07-18
	-- ��  �� : �ɼ�ǰ�� �������� �ʿ���� ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

return

--	create table #del_plno(pl_no int)
--
--	-- �ɼǸ� ǰ���� �ִ� pl_no�� 
--	insert into #del_plno(pl_no)
--	select distinct pl_no
--	from tbl_pricelist_option_ctu_detail 
--	where regdate>= cast(convert(varchar(10), getdate(), 120) as datetime)		
--	and	t_option_name like '%ǰ��%' or t_option_sub_name like '%ǰ��%'
--
--	delete from tbl_pricelist_option_ctu_detail 
--	where pl_no not in (
--		select pl_no from #del_plno
--	)
