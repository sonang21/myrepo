/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 14:41:13.727
 *        Modify: 2018-05-03 17:23:34.35
 *        Backup: 20180521_1739
 ************************************************************************* */


create proc udp_shoplist_ap_code_del
	@shop_vcode int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-09-26
	-- 설  명 : ap 수익코드 관리 & db 스케쥴링으로 체크할 때 참조
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	delete from shoplist_ap_code
	where shop_vcode = @shop_vcode
