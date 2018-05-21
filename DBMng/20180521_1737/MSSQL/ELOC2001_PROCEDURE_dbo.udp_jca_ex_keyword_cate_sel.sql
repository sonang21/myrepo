/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_cate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-07 16:20:08.353
 *        Modify: 2018-05-03 17:23:34.85
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ex_keyword_cate_sel]
	@cate varchar(9)
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

	select category
	, 	case when len(category) >= 2 and category <> '00' then
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
	,	is_group_ex, is_first, is_ex, is_pattern,shop_code,price_range
	,	first_group_cnt, ex_group_cnt, '', data_sel_opt
	, 	data_sel_sdate, data_sel_edate, is_all_cate,is_spec, is_inc_matching,
		ex_shop_code, price_limit, group_part -- 20
	,	group_list_cnt, is_spec_search, raw_data_ref_cnt, price_limit_max, group_part_sort
	,	is_spec_search_group	, is_color_search, is_color_search_group, is_auto_srv, is_auto_srv2 --30
	,	week_day, is_serial_no, serial_no_week_day, duple_model_del_week_day, is_duple_model_del
	,	 is_duple_model_del_all, is_serial_no_cate, is_built_on	
	,	is_gs2 --gs2 플래그 이주현 추가
	,	gs2_week_day -- gs2 요일 체크 -- 40
	,	builton_week_day, is_builton_qa, is_duple_model_del_text
	from tbl_ex_keyword_cate
	where category like @cate 
--	and use_flag <> case when len(@cate)= 3 then 0 else -1 end
	order by category

