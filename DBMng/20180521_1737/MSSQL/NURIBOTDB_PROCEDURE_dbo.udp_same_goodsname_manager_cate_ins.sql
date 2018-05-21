/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.89
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_same_goodsname_manager_cate_ins
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
	insert into tbl_same_goodsname_manager_cate_set 
			(category, srv_flag, run_date, price_range, goods_cnt, run_group, run_group_order, ex_pop_range)
	values (@category, @srv_flag, @run_date, @price_range, @goods_cnt, @run_group, @run_group_order, @ex_pop_range)

