/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.89
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1739
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
	-- 작성자 : wookki25 / 2014-07-28
	-- 설  명 : 동일 상품명 관리자
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	insert into tbl_same_goodsname_manager_cate_set 
			(category, srv_flag, run_date, price_range, goods_cnt, run_group, run_group_order, ex_pop_range)
	values (@category, @srv_flag, @run_date, @price_range, @goods_cnt, @run_group, @run_group_order, @ex_pop_range)

