/* *************************************************************************
 * NAME : dbo.udp_goods_search_list_agg_sel_v2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-02-28 15:50:17.64
 *        Modify: 2018-05-03 17:23:34.783
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_goods_search_list_agg_sel_v2
	@sdate smalldatetime
,	@edate smalldatetime
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-02-28
	-- 설  명 : pricelist 상품매칭 일별 통계 집계
	-- 참  고 : udp_goods_search_list_agg_sel_v2
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select  
	  [주차] = datepart(ww, agg_date)
	, [집계일] = agg_date
	, [분류] = category
	, [분류명] = (select cm_name from c_mcate where cm_lcode = substring(category, 1,2) and cm_mcode = substring(category, 3,2))
	, [총그룹] =  g_raw_t_cnt
	,	[총그룹_추가] = g_raw_nm_cnt 
	,	[총그룹_매칭] = g_raw_vm_cnt 
	,	[총그룹_매칭_최저] = g_raw_vm_min_cnt 
	,	[총그룹_다중매칭] = g_raw_multi_cnt 

	, [처리그룹] = g_work_t_cnt 
	,	[유사상품]	 = g_work_auto_cnt
	,	[자동그룹매칭]	 =  g_work_auto_m_cnt
	,	[합계]			 = g_work_wm_cnt +g_work_mm_cnt +g_work_multi_cnt + g_work_etc_cnt
	,		[처리그룹_추가]  = g_work_wm_cnt 
	,		[처리그룹_매칭]  = g_work_mm_cnt 
	,		[처리그룹_매칭_최저]  = g_work_mm_min_cnt 
	,		[처리그룹_다중매칭]  = g_work_multi_cnt 
	,		[처리그룹_기타]  = g_work_etc_cnt

	, [총개수] = p_raw_t_cnt 
	,	[총개수_추가]  = p_raw_nm_cnt 
	,	[총개수_매칭]  = p_raw_vm_cnt
	,	[총개수_매칭_최저]  = p_raw_vm_min_cnt
	,	[총개수_다중매칭] = p_raw_multi_cnt

	, [처리] = p_work_t_cnt 
	,	[유사상품]	= p_work_auto_cnt
	,	[자동그룹매칭]	 =  p_work_auto_m_cnt
	,	[합계] = p_work_wm_cnt +p_work_mm_cnt +p_work_multi_cnt +p_work_etc_cnt
	,		[처리_추가] = p_work_wm_cnt 
	,		[처리_매칭] = p_work_mm_cnt 
	,		[처리_매칭_최저] = p_work_mm_min_cnt 
	,		[처리_다중매칭] = p_work_multi_cnt 
	,		[처리_기타] = p_work_etc_cnt

--	, [미처리그룹] = g_nwork_t_cnt 
--	,	[미처리그룹_추가] = g_nwork_nm_cnt 
--	,	[미처리그룹_매칭] = g_nwork_vm_cnt
--	,	[미처리그룹_다중매칭] = g_nwork_multi_cnt

--	, [미처리] = g_nwork_vm_cnt
--	,	[미처리_추가] = p_nwork_nm_cnt 
--	,	[미처리_매칭] = p_nwork_vm_cnt 
--	,	[미처리_다중매칭] = p_nwork_multi_cnt 

	-- 백화점
	, [총개수] = p_raw_s_t_cnt 
	,	[총개수_추가]  = p_raw_s_nm_cnt 
	,	[총개수_매칭]  = p_raw_s_vm_cnt
	,	[총개수_매칭_최저]  = p_raw_s_vm_min_cnt
	,	[총개수_다중매칭] = p_raw_s_multi_cnt

	, [처리] = p_work_s_t_cnt 
	,	[유사상품]	= p_work_s_auto_cnt
	,	[자동그룹매칭]	 =  p_work_s_auto_m_cnt
	,	[합계] = p_work_s_wm_cnt +p_work_s_mm_cnt +p_work_s_multi_cnt +p_work_s_etc_cnt
	,		[처리_추가] = p_work_s_wm_cnt 
	,		[처리_매칭] = p_work_s_mm_cnt 
	,		[처리_매칭_최저] = p_work_s_mm_min_cnt 
	,		[처리_다중매칭] = p_work_s_multi_cnt 
	,		[처리_기타] = p_work_s_etc_cnt

	from tbl_goods_search_list_agg_v2
	where agg_date >= @sdate and agg_date < @edate +1
	order by agg_date, category




