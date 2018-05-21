/* *************************************************************************
 * NAME : dbo.udp_cm_alba_get_job_result_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-02 16:13:51.857
 *        Modify: 2015-11-19 20:15:17.723
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_alba_get_job_result_excel
	@mm_id	varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.05.28
	-- 설  명 : cm  재택근무
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	declare @sdate smalldatetime
	set @sdate = cast(getdate() as date)

	-- 담당분류 : 일별, 중분류, 담당자별
	select * into #tbl_cm_alba_ref_real_mcate_manager
	from  openquery(OLTPLOG_196,'
		select category, mm_id, manage_date, mm_nm, alba_flag from oltplog.dbo.tbl_cm_alba_ref_real_mcate_manager  	where manage_date = cast(getdate() as date)
	')

	-- 분류별 목표량 : 일별, 중분류
	select * into #tbl_cm_alba_goal
	from  openquery(OLTPLOG_196,'
		select item_no, category, goal_date, goal_cnt from oltplog.dbo.tbl_cm_alba_goal where  goal_date = cast(getdate() as date)
	')	

	-- 분류별 목표량 : 일별, 중분류
	select * into #tbl_cm_perf_goal
	from  openquery(OLTPLOG_196,'
		select item_no, category, goal_date, goal_cnt from oltplog.dbo.tbl_cm_perf_goal where  goal_date = cast(getdate() as date)
	')	

	-- 항목명
	select * into #tbl_cm_alba_item 
	from openquery(oltplog_196, '
		select * from oltplog.dbo.tbl_cm_alba_item
	')

	create table #tbl_cm_alba_result_joblog_by_cate_id (item_no int, mm_id varchar(12), category varchar(12), result_date date, result_cnt  int)	

	-- 카탈로그 추가개수
	select g_modelno, jg_category as g_category, g_spec2, jg_id, jg_flag
	into #job_goods
	from 
	(
		select	jg_modelno, jg_flag, jg_id, max(jg_category) jg_category
		from	job_goods			
		where	jg_flag in ('0','8','B','9') -- 0-모델추가(일반), 1-요약카탈, 8-모델추가(그룹모델),  B-모델추가_SGM, 9-유사->일반
		and		jg_id = isnull(nullif(@mm_id, ''), jg_id)
		group by jg_modelno, jg_flag, jg_id
	) a inner join eloc2001.dbo.goods b on jg_modelno = g_modelno	
	where g_jobcode>'0' and g_category+'' not like '00%' and g_category+'' like '[0123456789]___%'

	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, category, mm_id, result_date, result_cnt )
	select 	1 item_no, jg_id, left(g_category, 4), @sdate, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> '' and	jg_id = isnull(nullif(@mm_id, ''), jg_id)
	group by jg_id, left(g_category, 4) -- 중분류



	-- pricelist 매칭개수
	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 2 item_no, jp_id, left(jp_category,4) category, @sdate, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, jp_id, count(distinct jp_plistno) cnt, max(jp_category) jp_category
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6') 
		and jp_id = isnull(nullif(@mm_id, ''), jp_id)
		group by jp_modelno, jp_id
	)  a
	group by jp_id, left(jp_category, 4) -- 중분류


	-- pricelist 번호미매칭
	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 3 item_no, jp_id, left(jp_category,4) as category, @sdate, count(distinct jp_plistno) p_matching_cnt
	from job_pricelist 
	where jp_modelno=0 and jp_flag in ('0', '5', '2', '6') 
	and jp_id = isnull(nullif(@mm_id, ''), jp_id)
	group by jp_id, left(jp_category,4)

	-- 리스트
	select a.manage_date, a.mcate, a.mm_id, a.mm_nm, sum(result_cnt), max(b.item_name) item_name, sum(goal_cnt)
	from 
	(
			
		-- 담당분류 : 일별, 중분류, 담당자별, 목표량
		-- 담당하지 않는 분류에서 작업한 건 포함하지 않는다.

		-- 작업량	: id별, 일별, 항목별, 분류별
		select a.mm_id, a.manage_date, b.item_no, a.mcate, result_cnt, 0 goal_cnt, mm_nm
		from
		(
			select distinct manage_date , left(category,4) mcate, mm_id, mm_nm
			from #tbl_cm_alba_ref_real_mcate_manager
			where mm_id=isnull(nullif(@mm_id,''), mm_id) --and manage_date between @sdate and @edate
		) a
			inner join 
		(
			select item_no, left(category, 4) mcate, mm_id, result_date, sum(result_cnt) result_cnt 
			from #tbl_cm_alba_result_joblog_by_cate_id 
			where mm_id=isnull(nullif(@mm_id,''), mm_id) --and result_date between @sdate and @edate
			group by item_no, left(category, 4), mm_id, result_date
		) b on a.mcate = b.mcate and manage_date = result_date and a.mm_id = b.mm_id
		union all
		-- 목표량	: id별, 일별, 항목별, 분류별
		-- 재택CM
		select  a.mm_id, a.manage_date, case b.item_no  when 6 then 1 when 8 then 2 end as item_no, a.mcate, 0 result_cnt, b.goal_cnt, mm_nm
		from 
		(
			select distinct manage_date , left(category,4) mcate, mm_id, mm_nm
			from #tbl_cm_alba_ref_real_mcate_manager
			where mm_id=isnull(nullif(@mm_id,''), mm_id) --and manage_date between @sdate and @edate
			and alba_flag = '1'
		) a inner join #tbl_cm_perf_goal b on a.manage_date = b.goal_date and a.mcate=b.category and b.item_no in (6,8) -- 모델추가, 번호매칭
		union all
		-- 재택ACM, 재택매칭
		select  a.mm_id, a.manage_date, b.item_no, a.mcate, 0 result_cnt, b.goal_cnt, mm_nm
		from 
		(
			select distinct manage_date , left(category,4) mcate, mm_id, mm_nm
			from #tbl_cm_alba_ref_real_mcate_manager
			where mm_id=isnull(nullif(@mm_id,''), mm_id) --and manage_date between @sdate and @edate
			and alba_flag in ('2','3','4')
		) a inner join #tbl_cm_alba_goal b on a.manage_date = b.goal_date and category = mcate and b.item_no in (1,2) -- 모델추가, 번호매칭

	) a inner join #tbl_cm_alba_item b on a.item_no = b.item_no
	group by a.mm_id, a.manage_date, a.item_no, a.mcate, a.mm_nm
	having isnull(sum(result_cnt),0) > 0 --  작업량이 있는 경우만

