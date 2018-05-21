/* *************************************************************************
 * NAME : dbo.udp_jca_web_search_config_batch_modelnm_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-12-29 15:42:04.027
 *        Modify: 2018-05-03 17:23:34.66
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_web_search_config_batch_modelnm_sel]
	@modelnm_batch_group tinyint
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.12.28
	-- 설  명 : 자동그룹핑 에누리 모델명 병렬처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select a.modelnm_batch_group, b.group_cnt, category, 
		--case when len(category) >= 2 and category <> '00' then
		--	(select top 1 cl_name from c_lcate where cl_lcode = left(category,2))
		--else ''	end +
		case when len(category) >= 4 then
			(select top 1 cm_name from c_mcate 
			where cm_lcode = left(category,2) and cm_mcode = right(left(category, 4), 2))
		else '' end +
		case when len(category) >= 6 then
			(select top 1 ' > '+cs_name from c_scate 
			where cs_lcode = left(category,2) and cs_mcode = right(left(category, 4), 2) 
			and cs_scode = right(left(category, 6), 2))
		else ''	end	+
		case when len(category) >= 8 then
			(select top 1 ' > '+cd_name from c_dcate 
			where cd_lcode = left(category,2) and cd_mcode = right(left(category, 4), 2) 
			and cd_scode = right(left(category, 6), 2)
			and cd_dcode = right(left(category, 8), 2))
		else ''	end	as cate_name
	,	''
	,	''
	,	modelnm_batch_sort
	,	isnull(max_modelnm_batch_sort,0)
	from tbl_web_search_config a 
			inner join 
		( 
			select modelnm_batch_group, count(*) as group_cnt, max(modelnm_batch_sort) max_modelnm_batch_sort 
			from tbl_web_search_config 
			where data_kind = 'g'
			--and use_flag in ('2','3') 
			and search_group = 0
			group by modelnm_batch_group 
		) b on a.modelnm_batch_group = b.modelnm_batch_group
	where a.modelnm_batch_group between case when @modelnm_batch_group is null then 0 else @modelnm_batch_group end and case when @modelnm_batch_group is null then 99 else @modelnm_batch_group end
	--and a.use_flag in ('2','3')
	and a.data_kind = 'g'
	and a.search_group = 0
	order by a.modelnm_batch_group, category


