/* *************************************************************************
 * NAME : dbo.udp_list_exclude_cate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-27 14:01:26.263
 *        Modify: 2018-05-03 17:23:35.48
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_list_exclude_cate_sel
	@category	varchar(12) = '%'
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 리스트 제외 분류 sel / 2010-04-27
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select lec_seq, category, add_cate, main_goods, cate_scope 
	from tbl_list_exclude_cate
	where category like @category

