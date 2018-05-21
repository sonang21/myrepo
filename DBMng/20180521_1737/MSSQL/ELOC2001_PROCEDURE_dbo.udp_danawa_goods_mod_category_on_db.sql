/* *************************************************************************
 * NAME : dbo.udp_danawa_goods_mod_category_on_db
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-06-13 10:27:52.123
 *        Modify: 2018-05-03 17:23:35.44
 *        Backup: 20180521_1737
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc udp_danawa_goods_mod_category_on_db
	@goodscode varchar(50)
,	@category varchar(4)
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
	update tbl_danawa_goods_on_db
	set category = @category
	where goodscode = @goodscode

