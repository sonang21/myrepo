/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_cate_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-28 19:03:44.93
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1739
 ************************************************************************* */


create proc udp_same_goodsname_manager_cate_del
	@category char(4)
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
	delete tbl_same_goodsname_manager_cate_set 
	where category = @category
