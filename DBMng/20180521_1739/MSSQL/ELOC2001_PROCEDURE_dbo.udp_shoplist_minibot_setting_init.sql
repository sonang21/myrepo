/* *************************************************************************
 * NAME : dbo.udp_shoplist_minibot_setting_init
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-02 15:42:06.53
 *        Modify: 2018-05-03 17:23:34.3
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_shoplist_minibot_setting_init
	@shop_vcode int
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-02
	-- 설  명 : 미니봇 설정
	-- ----------------------------------------------
	declare @app_rows int
	set @app_rows = 0
	select 	pl_no+0 pl_no, identity(int, 1,1)  as seqno, 0 as is_ok
	into 	#a
	from 	pricelist with (Readuncommitted)
	where	pl_vcode = @shop_vcode 	and	pl_nochange = '1'
	
	set @app_rows = @@rowcount
	if @app_rows >0 begin

		update shoplist_minibot_setting
		set upd_date = getdate()
		, upd_cnt = @app_rows
		where shop_vcode = @shop_vcode

	end


	declare @seqno int
	declare @seed int
	set @seqno = 1
	set @seed  = 1000 -- 1000건씩 처리
	while 1=1 begin
		update pricelist  
		set pl_nochange='0'
		where pl_no in (
			select pl_no from #a
			where seqno >=@seqno  and seqno < @seqno + @seed and is_ok = 0
		)
		if @@rowcount = 0 break;	

		set @seqno = @seqno + @seed
	end

