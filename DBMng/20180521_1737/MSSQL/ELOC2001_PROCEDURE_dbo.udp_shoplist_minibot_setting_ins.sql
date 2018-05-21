/* *************************************************************************
 * NAME : dbo.udp_shoplist_minibot_setting_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-02 13:45:10.46
 *        Modify: 2018-05-03 17:23:34.273
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_minibot_setting_ins
	@shop_vcode int
,	@is_upd bit
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-02
	-- 설  명 : 미니봇 설정
	-- ----------------------------------------------
	insert into shoplist_minibot_setting(shop_vcode, is_upd)
	values(@shop_vcode, @is_upd)
