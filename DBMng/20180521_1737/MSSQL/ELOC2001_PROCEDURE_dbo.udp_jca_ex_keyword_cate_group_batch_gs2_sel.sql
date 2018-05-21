/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_cate_group_batch_gs2_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-09 21:17:40.143
 *        Modify: 2018-05-03 17:23:34.67
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[udp_jca_ex_keyword_cate_group_batch_gs2_sel]
	@gs2_batch_group tinyint
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : nova23 / 2017.03.09
	-- ��  �� : �ڵ��׷��� GS2 ����ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	select a.gs2_batch_group, b.group_cnt, category, 
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
	,	use_flag
	,	use_flag_pre_day
	,	gs2_batch_sort
	,	isnull(max_gs2_batch_sort,0)
	from tbl_ex_keyword_cate a 
			inner join 
		( 
			select gs2_batch_group, count(*) as group_cnt, max(gs2_batch_sort) max_gs2_batch_sort 
			from tbl_ex_keyword_cate 
			where is_gs2 = 1
			--and use_flag in ('2','3') 
			group by gs2_batch_group 
		) b on a.gs2_batch_group = b.gs2_batch_group
	where a.gs2_batch_group between case when @gs2_batch_group is null then 0 else @gs2_batch_group end and case when @gs2_batch_group is null then 99 else @gs2_batch_group end
	--and a.use_flag in ('2','3')
	and a.is_gs2 = 1
	order by a.gs2_batch_group, category
	