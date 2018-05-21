/* *************************************************************************
 * NAME : dbo.udp_list_exclude_cate_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-27 14:01:15.53
 *        Modify: 2018-05-03 17:23:35.443
 *        Backup: 20180521_1737
 ************************************************************************* */

create PROC udp_list_exclude_cate_ins
	@category	varchar(12)
,	@add_cate	char(1)
,	@main_goods	varchar(30)
,	@cate_scope char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 리스트 제외 분류 ins / 2010-04-27
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	insert into tbl_list_exclude_cate
	(category, add_cate, main_goods, cate_scope)
	values
	(@category, @add_cate, @main_goods, @cate_scope)
	
	
