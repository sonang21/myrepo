/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.91
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_same_goodsname_manager_cate_mod
	@category char(4)
,	@srv_flag char(1)
,	@run_date varchar(30)
,	@price_range smallint
,	@goods_cnt  smallint
,	@run_group varchar(10)
,	@run_group_order int 
,	@ex_pop_range varchar(10)
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
	update tbl_same_goodsname_manager_cate_set 
	set	srv_flag = @srv_flag
	,	run_date = @run_date
	,	price_range = @price_range
	,	goods_cnt  = @goods_cnt
	,	moddate = getdate()
	,	run_group = @run_group
	,	run_group_order  = @run_group_order
	,	ex_pop_range = @ex_pop_range
	where category = @category


