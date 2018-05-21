/* *************************************************************************
 * NAME : dbo.udp_cm_alba_get_job_result
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-02 16:13:51.917
 *        Modify: 2015-11-19 17:17:27.8
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cm_alba_get_job_result
	@mm_id	varchar(12)
AS 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-07-07
	-- ��  �� : id�� ����.�۾���
	--		����ACM�� �Һз����� ����
	--		����CM, ���ø�Ī�� �ߺз����� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	
									
	*/
	declare @sdate smalldatetime
	set @sdate = cast(getdate() as date)

	-- ���з� : �Ϻ�, �ߺз�, ����ں�
	select * into #tbl_cm_alba_ref_real_mcate_manager
	from  openquery(OLTPLOG_196,'
		select category, mm_id, manage_date, mm_nm, alba_flag from oltplog.dbo.tbl_cm_alba_ref_real_mcate_manager  	where manage_date = cast(getdate() as date)
	')

	-- �з��� ��ǥ�� : �Ϻ�, �ߺз�
	select * into #tbl_cm_alba_goal
	from  openquery(OLTPLOG_196,'
		select item_no, category, goal_date, goal_cnt from oltplog.dbo.tbl_cm_alba_goal where  goal_date = cast(getdate() as date)
	')	


	select * into #tbl_cm_perf_goal
	from  openquery(OLTPLOG_196,'
		select item_no, category, goal_date, goal_cnt from oltplog.dbo.tbl_cm_perf_goal where  goal_date = cast(getdate() as date)
	')	
	
	create table #tbl_cm_alba_result_joblog_by_cate_id (item_no int, mm_id varchar(12), category varchar(12), result_date date, result_cnt  int)


	-- īŻ�α� �߰�����
	select g_modelno, jg_category as g_category, g_spec2, jg_id, jg_flag
	into #job_goods
	from 
	(
		select	jg_modelno, jg_flag, jg_id, max(jg_category) jg_category
		from	job_goods			
		where	jg_flag in ('0','1','8','B','9') -- 0-���߰�(�Ϲ�), 1-���īŻ, 8-���߰�(�׷��),  B-���߰�_SGM, 9-����->�Ϲ�
		and		jg_id = @mm_id
		group by jg_modelno, jg_flag, jg_id
	) a inner join eloc2001.dbo.goods b on jg_modelno = g_modelno	
	where g_jobcode>'0' and g_category+'' not like '00%' and g_category+'' like '[0123456789]___%'

	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, category, mm_id, result_date, result_cnt )
	select 	1 item_no, jg_id, left(g_category, 4), @sdate, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> '' and (jg_flag in ('0','8','B') or (jg_flag ='9' and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') ))  -- cm2��
	and	jg_id = @mm_id
	group by jg_id, left(g_category, 4) -- �ߺз�



	-- pricelist ��Ī����
	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 2 item_no, jp_id, left(jp_category,4) category, @sdate, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, jp_id, count(distinct jp_plistno) cnt, max(jp_category) jp_category
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6') 
		and jp_id = @mm_id
		group by jp_modelno, jp_id
	)  a
	group by jp_id, left(jp_category, 4) -- �ߺз�


	-- pricelist ��ȣ�̸�Ī
	insert into #tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 3 item_no, jp_id, left(jp_category,4) as category, @sdate, count(distinct jp_plistno) p_matching_cnt
	from job_pricelist 
	where jp_modelno=0 and jp_flag in ('0', '5', '2', '6') 
	and jp_id = @mm_id
	group by jp_id, left(jp_category,4)




	select isnull(yyyymmdd, '�հ�')  as yyyymmdd, isnull(sum(m_cnt),0), isnull(sum(m_goal_cnt),0), isnull(sum(p_cnt),0), isnull(sum(p_goal_cnt),0), isnull(sum(z_cnt),0)
	from 
	(
			select convert(varchar(10), manage_date, 120) yyyymmdd
				, sum(case when a.item_no =1 then result_cnt end)  m_cnt
				, sum(case when a.item_no =2 then result_cnt end)  p_cnt
				, sum(case when a.item_no =3 then result_cnt end)  z_cnt

				, sum(case when a.item_no =1 then goal_cnt end)  m_goal_cnt
				, sum(case when a.item_no =2 then goal_cnt end)  p_goal_cnt			
			from 
			(
				-- �۾���	: id��, �Ϻ�, �׸�, �з���
				select a.mm_id, a.manage_date, b.item_no, a.mcate, result_cnt, 0 goal_cnt
				from
				(
					select distinct manage_date , left(category,4) mcate, mm_id
					from #tbl_cm_alba_ref_real_mcate_manager
					where mm_id=@mm_id --and manage_date between @sdate and @edate
				) a
					inner join 
				(
					select item_no, left(category, 4) mcate, mm_id, result_date, sum(result_cnt) result_cnt 
					from #tbl_cm_alba_result_joblog_by_cate_id 
					where mm_id=@mm_id --and result_date between @sdate and @edate
					group by item_no, left(category, 4), mm_id, result_date
				) b on a.mcate = b.mcate and manage_date = result_date and a.mm_id = b.mm_id
				union all
				-- ��ǥ��	: id��, �Ϻ�, �׸�, �з���
				-- ����CM
				select  a.mm_id, a.manage_date, case b.item_no  when 6 then 1 when 8 then 2 end as item_no, a.mcate, 0 result_cnt, b.goal_cnt
				from 
				(
					select distinct manage_date , left(category,4) mcate, mm_id
					from #tbl_cm_alba_ref_real_mcate_manager
					where mm_id=@mm_id --and manage_date between @sdate and @edate
					and alba_flag = '1'
				) a inner join #tbl_cm_perf_goal b on a.manage_date = b.goal_date and a.mcate=b.category and b.item_no in (6,8) -- ���߰�, ��ȣ��Ī
				union all
				-- ����ACM, ���ø�Ī
				select  a.mm_id, a.manage_date, b.item_no, a.mcate, 0 result_cnt, b.goal_cnt
				from 
				(
					select distinct manage_date , left(category,4) mcate, mm_id
					from #tbl_cm_alba_ref_real_mcate_manager
					where mm_id=@mm_id --and manage_date between @sdate and @edate
					and alba_flag in ('2','3','4')
				) a inner join #tbl_cm_alba_goal b on a.manage_date = b.goal_date and category = mcate and b.item_no in (1,2) -- ���߰�, ��ȣ��Ī

			) a
			group by manage_date	
	) r
	group by yyyymmdd
	order by yyyymmdd
	
end


