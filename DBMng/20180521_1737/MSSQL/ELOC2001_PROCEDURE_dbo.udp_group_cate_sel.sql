/* *************************************************************************
 * NAME : dbo.udp_group_cate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-26 16:35:14.917
 *        Modify: 2018-05-03 17:23:34.87
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_group_cate_sel
	@category varchar(12) = '%'
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 그룹 적용 분류 sel / 2010-04-26
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2010.09.08		wookki25		unit_price_cmt 추가
									컬럼삭제
									list_title, help_img_file, combo_title, small_img
	*/
	select gc_seq, category, '', '', ''
	, '', unit_price, group_spec, add_cate, isnull(exclude_cate, ''), isnull(unit_price_cmt, '')
	from tbl_group_cate 
	where category like @category
	order by category