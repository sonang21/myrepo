/* *************************************************************************
 * NAME : dbo.udp_shoplist_minibot_setting_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-02 13:37:40.06
 *        Modify: 2018-05-03 17:23:34.267
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_shoplist_minibot_setting_del
	@shop_vcode int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-02
	-- 설  명 : 미니봇 설정
	-- ----------------------------------------------
	delete shoplist_minibot_setting
	where shop_vcode = @shop_vcode