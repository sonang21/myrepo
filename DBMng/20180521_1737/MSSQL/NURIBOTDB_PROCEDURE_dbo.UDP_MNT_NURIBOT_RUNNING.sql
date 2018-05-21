/* *************************************************************************
 * NAME : dbo.UDP_MNT_NURIBOT_RUNNING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-12-11 10:38:04.027
 *        Modify: 2015-05-15 00:52:25.973
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_mnt_nuribot_running
as
	set nocount on
	set transaction isolation level read uncommitted
	-- --------------------------------------
	-- 작성자 : wookki25
	-- 작성일 : 2007.12.11
	-- 설  명 : 현재 가격자료 수집중인 업체
	-- --------------------------------------
	select	convert(varchar(8), getdate(), 114) as snapshot_date, db_name() as dbname, appname, vcode, shop_name, step, sdate
	from	
	(
			select	'ssis(nb01)' as appname, vcode as vcode, cast(status	as sql_variant) as step, sdate_step1 as sdate
			from	tbl_nb_shoplist 
			where	status not like '완료%' and srvflag = '0'
			
			union all
			
			select	'vb(nb02)' as appname,  nbs_vcode, cast(nbs_step as sql_variant) as step, nbs_start_date
			from	tbl_nb_shop 
			where	nbs_step>'0'
		) as tbl_shop
			inner join eloc2001.dbo.shoplist sh
				on tbl_shop.vcode = sh.shop_vcode
