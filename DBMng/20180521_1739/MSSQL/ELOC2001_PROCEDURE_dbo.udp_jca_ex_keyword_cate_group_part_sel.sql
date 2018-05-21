/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_cate_group_part_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-07-19 16:22:36.55
 *        Modify: 2018-05-03 17:23:35.793
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ex_keyword_cate_group_part_sel]
	@group_part tinyint
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012.07.19
	-- 설  명 : 자동그룹핑 카테고리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select a.group_part, b.group_cnt, category, 
		case when len(category) >= 2 and category <> '00' then
			(select top 1 cl_name from c_lcate where cl_lcode = left(category,2))
		else ''	end +
		case when len(category) >= 4 then
			(select top 1 ' > '+cm_name from c_mcate 
			where cm_lcode = left(category,2) and cm_mcode = right(left(category, 4), 2))
		else '' end +
		case when len(category) >= 6 then
			(select top 1 ' > '+cs_name from c_scate 
			where cs_lcode = left(category,2) and cs_mcode = right(left(category, 4), 2) 
			and cs_scode = right(left(category, 6), 2))
		else ''	end	as cate_name
	,	use_flag
	,	use_flag_pre_day
	,	group_part_sort
	,	isnull(max_group_part_sort,0)
	from tbl_ex_keyword_cate a 
			inner join 
		( 
			select group_part, count(*) as group_cnt, max(group_part_sort) max_group_part_sort 
			from tbl_ex_keyword_cate 
			where use_flag in ('2','3') group by group_part 
		) b on a.group_part = b.group_part
	where a.group_part between case when @group_part is null then 1 else @group_part end and case when @group_part is null then 99 else @group_part end
	and a.use_flag in ('2','3')
	order by a.group_part, category
