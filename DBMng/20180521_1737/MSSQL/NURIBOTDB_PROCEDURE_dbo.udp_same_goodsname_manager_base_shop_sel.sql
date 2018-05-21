/* *************************************************************************
 * NAME : dbo.udp_same_goodsname_manager_base_shop_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-29 17:30:14.537
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_same_goodsname_manager_base_shop_sel
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
	select mon, tue, wed, thu, fri, sat, sun
	from  tbl_same_goodsname_manager_base_shop
