/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.85
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_same_goodsname_manager_cate_sel
	@category varchar(4)
,	@srv_flag char(1)
,	@run_date varchar(10)
,	@run_group char(1)
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
	select category, cm_name, srv_flag, run_date, price_range, goods_cnt, run_group, run_group_order, isnull(ex_pop_range,'') ex_pop_range
	from  tbl_same_goodsname_manager_cate_set left outer join eloc2001.dbo.c_mcate on cm_lcode = left(category,2) and cm_mcode= right(category,2)
	where category like @category + '%' 
	and srv_flag = case when @srv_flag ='%' then srv_flag else @srv_flag end
	and run_date like '%'+ @run_date +'%'
	and run_group like isnull(@run_group, '%')

