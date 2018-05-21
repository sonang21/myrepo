/* *************************************************************************
 * NAME : dbo.udp_list_exclude_cate_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-27 14:01:15.62
 *        Modify: 2018-05-03 17:23:35.46
 *        Backup: 20180521_1739
 ************************************************************************* */

create PROC udp_list_exclude_cate_mod
	@lec_seq	int
,	@category	varchar(12)
,	@add_cate	char(1)
,	@main_goods	varchar(30)
,	@cate_scope char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 리스트 제외 분류 mod / 2010-04-27
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	update tbl_list_exclude_cate
	set	category    =	@category	
	,	add_cate	=	@add_cate	
	,	main_goods	=	@main_goods
	,	cate_scope	=	@cate_scope
	where lec_seq	=	@lec_seq
	
