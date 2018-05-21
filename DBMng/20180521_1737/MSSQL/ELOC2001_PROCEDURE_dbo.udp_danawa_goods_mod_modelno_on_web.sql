/* *************************************************************************
 * NAME : dbo.udp_danawa_goods_mod_modelno_on_web
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-06-13 10:27:52.327
 *        Modify: 2018-05-03 17:23:35.493
 *        Backup: 20180521_1737
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc udp_danawa_goods_mod_modelno_on_web
	@goodscode varchar(50)
,	@modelno int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-05-21
	-- 설  명 : @commnet
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	update tbl_danawa_goods_on_web
	set modelno = @modelno
	,	category = isnull((select top 1 g_category from goods where g_modelno = @modelno), category)
	where goodscode = @goodscode

