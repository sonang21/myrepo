/* *************************************************************************
 * NAME : dbo.udp_auto_matching_price_agg_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-25 14:23:20.333
 *        Modify: 2018-05-03 17:23:34.233
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_auto_matching_price_agg_sel
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
			category
		,	cm_name
		,	isnull(g_raw_t_cnt,0)
		,	isnull(g_raw_t_minprice_cnt,0)
		,	isnull(g_work_m_add_cnt,0)
		,	isnull(g_work_m_auto_cnt,0)
		,	isnull(g_work_m_manu_cnt,0)
		,	isnull(g_work_m_manu_minprice_cnt,0)
		,	isnull(g_nwork_t_cnt,0)
		,	isnull(p_raw_t_cnt,0)
		,	isnull(p_raw_t_minprice_cnt,0)
		,	isnull(p_work_m_add_cnt,0)
		,	isnull(p_work_m_auto_cnt,0)
		,	isnull(p_work_m_manu_cnt,0)
		,	isnull(p_work_m_manu_minprice_cnt,0)
		,	isnull(p_nwork_t_cnt,0)
		,	s_rundate
		,	e_rundate
		,	s_g_rundate
		,	e_g_rundate
	from 
	(
	
		select 	category
			,	sum(g_raw_t_cnt)                 g_raw_t_cnt
			,	sum(g_raw_t_minprice_cnt)		 g_raw_t_minprice_cnt
			,	sum(g_work_m_add_cnt)			 g_work_m_add_cnt
			,	sum(g_work_m_auto_cnt)			 g_work_m_auto_cnt
			,	sum(g_work_m_manu_cnt)			 g_work_m_manu_cnt
			,	sum(g_work_m_manu_minprice_cnt)	 g_work_m_manu_minprice_cnt
			,	sum(g_nwork_t_cnt)				 g_nwork_t_cnt
			,	sum(p_raw_t_cnt)				 p_raw_t_cnt
			,	sum(p_raw_t_minprice_cnt)		 p_raw_t_minprice_cnt
			,	sum(p_work_m_add_cnt)			 p_work_m_add_cnt
			,	sum(p_work_m_auto_cnt)			 p_work_m_auto_cnt
			,	sum(p_work_m_manu_cnt)			 p_work_m_manu_cnt
			,	sum(p_work_m_manu_minprice_cnt)	 p_work_m_manu_minprice_cnt
			,	sum(p_nwork_t_cnt)				 p_nwork_t_cnt
			,	min(s_rundate) s_rundate
			,	max(e_rundate) e_rundate
			,	min(s_g_rundate) s_g_rundate
			,	max(e_g_rundate) e_g_rundate
		from
		(
			select  
				category
			,	sum(g_raw_t_cnt)                 g_raw_t_cnt
			,	sum(g_raw_t_minprice_cnt)		 g_raw_t_minprice_cnt
			,	sum(g_work_m_add_cnt)			 g_work_m_add_cnt
			,	sum(g_work_m_auto_cnt)			 g_work_m_auto_cnt
			,	sum(g_work_m_manu_cnt)			 g_work_m_manu_cnt
			,	sum(g_work_m_manu_minprice_cnt)	 g_work_m_manu_minprice_cnt
			,	sum(g_nwork_t_cnt)				 g_nwork_t_cnt
			,	sum(p_raw_t_cnt)				 p_raw_t_cnt
			,	sum(p_raw_t_minprice_cnt)		 p_raw_t_minprice_cnt
			,	sum(p_work_m_add_cnt)			 p_work_m_add_cnt
			,	sum(p_work_m_auto_cnt)			 p_work_m_auto_cnt
			,	sum(p_work_m_manu_cnt)			 p_work_m_manu_cnt
			,	sum(p_work_m_manu_minprice_cnt)	 p_work_m_manu_minprice_cnt
			,	sum(p_nwork_t_cnt)				 p_nwork_t_cnt
			,	null s_rundate
			,	null e_rundate
			,	min(s_regdate) s_g_rundate
			,	max(e_regdate) e_g_rundate
			from tbl_auto_matching_price_agg
			where aggdate >= @sdate and aggdate < @edate +1
			and category like @cate + '%'
			group by category

			union all

			select ca_code, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			 0, 0, 0, 0, s_rundate, e_rundate, s_g_rundate, e_g_rundate
			from tbl_auto_matching_price_run_history 
			where  rundate=@sdate and rundate = @edate
		) k
		group by category

	) a left outer join (select cm_lcode + cm_mcode mcate, cm_name from c_mcate) mcate on category = mcate
	order by category




 





