/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.93
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1737
 ************************************************************************* */


create proc udp_same_goodsname_manager_cate_del
	@category char(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-07-28
	-- ��  �� : ���� ��ǰ�� ������
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	delete tbl_same_goodsname_manager_cate_set 
	where category = @category
