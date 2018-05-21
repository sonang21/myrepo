/* *************************************************************************
 * NAME : dbo.udp_reward_raw_order_cleansing
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-02-22 15:47:26.183
 *        Modify: 2018-05-03 17:23:34.157
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_reward_raw_order_cleansing
	@shop_code int
as

	--If datediff(d, getdate(), '2016-11-03') = 0 begin

	--	select 1
	--end else begin

	-- 원격 호출
	exec MPDB02.member.dbo.udp_reward_raw_order_cleansing @shop_code 

	--end 

