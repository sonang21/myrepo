/* *************************************************************************
 * NAME : dbo.udp_jca_7871_job_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:58:14.607
 *        Modify: 2018-05-13 19:58:14.607
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_7871_job_agg
	@sdate date
as begin
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017-06-19
	-- 설  명 : 7871 작업량 확인
	-- http://58.234.199.100/redmine/issues/22994
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/


	--set @sdate = dateadd(d, 0, '2017-06-13')
	declare @edate date = dateadd(d, 1, @sdate)


	-- cm 정보. id,이름,부서명
	select epa_name, mm_nm, mm_id, mm_partcode 
	into #mm_id
	from openquery(searchkey_193, 'select  epa_name, mm_nm, mm_id, mm_partcode 
	from enuridb.dbo.mm_enuri a inner join enuridb.dbo.tbl_enuri_part b on right(a.mm_partcode,3) = epa_code
	where (mm_partcode like ''101202304%'' or mm_partcode like ''101202312%'' )')

	-- 대카
	select * into #lcate_name from openquery(eloc188, 'select cl_lcode lcate, cl_name, cl_flag from eloc2001.dbo.c_lcate')

	-- 중카테
	select * into #mcate_name from openquery(eloc188, 'select cm_lcode+cm_mcode mcate, cm_name, cm_flag from eloc2001.dbo.c_mcate')


	-- 모델추가.금년
	select g_modelno, g_category, jg_id, 'n' yyyy_flag
	into #target_goods
	from 
	(
		select	distinct jg_modelno, jg_flag, jg_id
		from	job_goods			
		where 	jg_flag in ('0','8','B','9','p','m') -- 0-모델추가(일반), 1-요약카탈, 8-모델추가(그룹모델),  B-모델추가_SGM, 9-유사->일반, p-제조사품번, m-에누리모델명
		and		jg_date >= @sdate and jg_date < @edate
		and		jg_id in (select mm_id from #mm_id)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	and isnull(g_spec2,'') <> ''
	and g_jobcode>'0'
	union all
	-- 모델추가.전년.같은 요일	
	select g_modelno, g_category, jg_id, 'o' yyyy_flag
	from 
	(
		select	distinct jg_modelno, jg_flag, jg_id
		from	job_goods			
		where 	jg_flag in ('0','8','B','9','p','m') -- 0-모델추가(일반), 1-요약카탈, 8-모델추가(그룹모델),  B-모델추가_SGM, 9-유사->일반, p-제조사품번, m-에누리모델명
		and		jg_date >= dateadd(wk, -52, @sdate) and jg_date < dateadd(wk, -52, @edate)
		and		jg_id in (select mm_id from #mm_id)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	and isnull(g_spec2,'') <> ''
	and g_jobcode>'0'



	
	-- 가격매칭.금년
	select jp_modelno, g_category, jp_id, jp_plistno, 'n' yyyy_flag, jp_vcode, dense_rank() over(partition by jp_modelno order by jp_date) nrank
	into #target_pricelist
	from oltplog.dbo.job_pricelist a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	where  jp_modelno > 0  and jp_flag in ('0', '5', '2', '6','p','m') 
	and jp_date >= @sdate and jp_date < @edate
	and jp_id in (select mm_id from #mm_id)
	and g_category not like '00%' and g_category like '[0123456789]___%'
	union all
	-- 가격매칭.전년.같은 요일	
	select jp_modelno, jp_category, jp_id, jp_plistno,  'o' yyyy_flag, jp_vcode, dense_rank() over(partition by jp_modelno order by jp_date) nrank
	from oltplog.dbo.job_pricelist a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	where  jp_modelno > 0  and jp_flag in ('0', '5', '2', '6','p','m') 
	and jp_date >= dateadd(wk, -52, @sdate) and jp_date < dateadd(wk, -52, @edate)
	and jp_id in (select mm_id from #mm_id)
	and g_category not like '00%' and g_category like '[0123456789]___%'


	-- 중복데이터 삭제!


	-- 모델추가 : 최종
	select	@sdate, epa_name, jg_id, mm_nm, a.mcate, d.cl_name, c.cm_name
	,	n_t_cnt, n_t_cnt - n_s_cnt, n_s_cnt
	,	o_t_cnt, o_t_cnt - o_s_cnt, o_s_cnt
	,	'모델추가'
	from 
	(
		select jg_id, mcate
		,	n_t_cnt = isnull(sum(case when yyyy_flag = 'n' then t_cnt end), 0)
		,	n_s_cnt = isnull(sum(case when yyyy_flag = 'n' then s_cnt end), 0)
		,	o_t_cnt = isnull(sum(case when yyyy_flag = 'o' then t_cnt end), 0)
		,	o_s_cnt = isnull(sum(case when yyyy_flag = 'o' then s_cnt end), 0)
		from 
		(
			select  a.yyyy_flag,  jg_id, left(a.g_category,4) mcate
			, t_cnt = count(*) 
			, s_cnt = sum(nrank)
			from #target_goods a left outer join #target_pricelist b on a.g_modelno = b.jp_modelno  and a.yyyy_flag=b.yyyy_flag and b.nrank = 1  and b.jp_vcode = 7871
			group by  jg_id, left(a.g_category,4), a.yyyy_flag
		) a
		group by  jg_id, mcate
	) a inner join #mm_id b on a.jg_id = b.mm_id
	left outer join #mcate_name c on a.mcate = c.mcate
	left outer join #lcate_name d on left(a.mcate,2) = d.lcate

	union all


	-- 가격매칭 최종
	select		@sdate, epa_name, jp_id, mm_nm, a.mcate, d.cl_name, c.cm_name
	,	n_t_cnt, n_t_cnt - n_s_cnt, n_s_cnt
	,	o_t_cnt, o_t_cnt - o_s_cnt, o_s_cnt
	,	'가격매칭'
	from 
	(
		select jp_id, mcate
		,	n_t_cnt = isnull(sum(case when yyyy_flag = 'n' then t_cnt end), 0)
		,	n_s_cnt = isnull(sum(case when yyyy_flag = 'n' then s_cnt end), 0)
		,	o_t_cnt = isnull(sum(case when yyyy_flag = 'o' then t_cnt end), 0)
		,	o_s_cnt = isnull(sum(case when yyyy_flag = 'o' then s_cnt end), 0)
		from 
		(
			select a.yyyy_flag,  jp_id, left(g_category,4) mcate
			, t_cnt = count(*) 
			, s_cnt = sum(case when jp_vcode=7871 then 1 else 0 end)
			from (
			
				select distinct  jp_modelno, g_category, jp_id, jp_plistno, yyyy_flag, jp_vcode
				from #target_pricelist
			
			) a
			group by jp_id, left(g_category,4), a.yyyy_flag
		) a
		group by  jp_id, mcate
	) a inner join #mm_id b on a.jp_id = b.mm_id
		left outer join #mcate_name c on a.mcate = c.mcate
		left outer join #lcate_name d on left(a.mcate,2) = d.lcate
end




