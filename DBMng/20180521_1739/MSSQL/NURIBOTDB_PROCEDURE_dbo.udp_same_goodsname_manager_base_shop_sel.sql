/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_base_shop_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-29 17:30:14.537
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_same_goodsname_manager_base_shop_sel
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
	select mon, tue, wed, thu, fri, sat, sun
	from  tbl_same_goodsname_manager_base_shop
