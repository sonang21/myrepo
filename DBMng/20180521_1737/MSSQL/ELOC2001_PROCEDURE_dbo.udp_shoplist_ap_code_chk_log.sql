/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_chk_log
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-27 14:10:12.413
 *        Modify: 2018-05-03 17:23:34.573
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_chk_log
	@shop_vcode_p int = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-09-26
	-- 설  명 : ap 수익코드 관리 & db 스케쥴링으로 체크할 때 참조
	-- ap 코드 유무 & 한글포함 유무
	-- 참조 : udp_shoplist_ap_code_chk
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	--커서
	declare cur_shop_vcode cursor for select shop_vcode, shop_apcode1, shop_apcode2 from shoplist_ap_code where shop_vcode = isnull(@shop_vcode_p, shop_vcode)

	declare @shop_vcode int
	declare @apcode1 varchar(100)
	declare @apcode2 varchar(100)

	open cur_shop_vcode
	fetch next from cur_shop_vcode into @shop_vcode, @apcode1, @apcode2

	while @@fetch_status = 0 begin
		
		insert into shoplist_ap_code_chk_log(shop_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, chk_kind)
		exec udp_shoplist_ap_code_chk @shop_vcode

		fetch next from cur_shop_vcode into @shop_vcode, @apcode1, @apcode2
	end
	close cur_shop_vcode
	deallocate cur_shop_vcode

	-- 최근일주일만 보관
	delete shoplist_ap_code_chk_log where logdate <getdate()-7

