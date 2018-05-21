/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 14:41:13.543
 *        Modify: 2018-05-03 17:23:34.303
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_ins
	@shop_vcode int
,	@shop_apcode1 varchar(100)
,	@shop_apcode2 varchar(100)
,	@memo varchar(500)
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
	insert into shoplist_ap_code(shop_vcode, shop_apcode1, shop_apcode2, memo)
	values(@shop_vcode, @shop_apcode1, nullif(@shop_apcode2,''), nullif(@memo,''))

