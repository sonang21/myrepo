/* *************************************************************************
 * NAME : dbo.udp_auto_matching_price_agg_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-09-26 13:36:44.337
 *        Modify: 2018-05-03 17:23:35.05
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_auto_matching_price_agg_excel
	@sdate smalldatetime
,	@edate smalldatetime
,	@cate  varchar(12)
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-07-25
	-- 설  명 : pricelist 동일상품명  일별 통계 집계
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select  
		aggdate
	,	category
	,	cm_name
	,	g_raw_t_cnt
	,	g_raw_t_minprice_cnt
	,	g_work_m_add_cnt
	,	g_work_m_auto_cnt
	,	g_work_m_manu_cnt
	,	g_work_m_manu_minprice_cnt
	,	g_nwork_t_cnt
	,	p_raw_t_cnt
	,	p_raw_t_minprice_cnt
	,	p_work_m_add_cnt
	,	p_work_m_auto_cnt
	,	p_work_m_manu_cnt
	,	p_work_m_manu_minprice_cnt
	,	p_nwork_t_cnt
	from tbl_auto_matching_price_agg left outer join (select cm_lcode + cm_mcode mcate, cm_name from c_mcate) mcate on category = mcate
	where aggdate >= @sdate and aggdate < @edate +1
	and category like @cate+'%'
	order by aggdate, category



