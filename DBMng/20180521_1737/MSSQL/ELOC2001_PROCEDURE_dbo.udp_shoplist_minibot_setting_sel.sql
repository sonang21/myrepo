/* *************************************************************************
 * NAME : dbo.udp_shoplist_minibot_setting_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-02 13:36:13.137
 *        Modify: 2018-05-03 17:23:34.237
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_minibot_setting_sel
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-05-02
	-- ��  �� : �̴Ϻ� ����
	-- ----------------------------------------------
	
	select a.shop_vcode, shop_name, is_upd, upd_date, upd_cnt
	from shoplist_minibot_setting a inner join shoplist b
	on a.shop_vcode = b.shop_vcode
	order by is_upd desc, shop_vcode
