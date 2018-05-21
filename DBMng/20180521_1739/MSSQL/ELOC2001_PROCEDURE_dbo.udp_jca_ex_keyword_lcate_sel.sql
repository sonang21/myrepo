/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_lcate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-05-03 09:46:02.663
 *        Modify: 2018-05-03 17:23:34.337
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC udp_jca_ex_keyword_lcate_sel
	@cate char(2)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-04-28
	-- 설  명 : 자동그룹핑 카테고리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select cm_lcode+cm_mcode, cm_name, use_flag,
	is_group_ex, is_first, is_ex, is_pattern,shop_code,price_range	
	from c_mcate with (readuncommitted) 
			left outer join 
		tbl_ex_keyword_cate
			on cm_lcode+cm_mcode = category
	where cm_lcode = @cate
	and cm_seqno > 0
	order by cm_lcode, cm_mcode
