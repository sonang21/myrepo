/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 14:41:13.64
 *        Modify: 2018-05-03 17:23:34.317
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_sel
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
	select shop_vcode, shop_apcode1, shop_apcode2, memo from shoplist_ap_code order by shop_vcode
