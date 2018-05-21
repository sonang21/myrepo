/* *************************************************************************
 * NAME : dbo.udp_shoplist_minibot_setting_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-02 13:37:18.593
 *        Modify: 2018-05-03 17:23:34.253
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_minibot_setting_mod
	@shop_vcode int
,	@is_upd bit
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-02
	-- 설  명 : 미니봇 설정
	-- ----------------------------------------------
	update shoplist_minibot_setting
	set is_upd =@is_upd
	where shop_vcode = @shop_vcode
