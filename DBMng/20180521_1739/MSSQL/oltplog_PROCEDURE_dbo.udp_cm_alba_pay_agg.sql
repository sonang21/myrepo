/* *************************************************************************
 * NAME : dbo.udp_cm_alba_pay_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:32:03.223
 *        Modify: 2018-05-10 15:32:03.223
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_alba_pay_agg
as 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-07-15
	-- ��  �� : cm �˹� �޿� ����
	--          �ſ� ������ ��¥�� ������ �Ⱓ������ ������ ����
	--			�Ⱓ : ���� 22�� ~ ��� 21��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/


	declare @sdate smalldatetime
	declare @edate smalldatetime
	set @sdate = cast(convert(varchar(7), dateadd(m, -1, getdate()),120)+'-22' as datetime) 
	set @edate = cast(convert(varchar(7), getdate(),120)+'-21' as datetime) 
--	set @sdate = cast('2015-07-10' as datetime) 
--	set @edate = cast('2015-07-16' as datetime) 

	select mm_id, mm_nm, alba_flag 
	into #cm_alba 
	from openquery(SEARCHKEY_193, 'select mm_id, mm_nm, alba_flag from enuridb.dbo.mm_enuri where mm_partcode like ''_________429'' and alba_flag in(''1'', ''2'', ''3'', ''4'')')


	create table #tbl_cm_alba_agg_alba_desc_goods(
		mm_id varchar(12) not null,
		g_modelno int not null
	)

	create table #tbl_cm_alba_agg_alba_desc_price(
		mm_id				varchar(12) not null,
		pl_no				bigint			not null,
		day_last_modelno	int			not null default(0)
	)


	-- īŻ�α� �߰�����
	insert into #tbl_cm_alba_agg_alba_desc_goods
	select distinct jg_id, g_modelno
	from
	(
		select	distinct jg_id, jg_modelno, left(jg_category, 4) mcate, convert(varchar(10), jg_date, 120) jg_date
		from	job_goods			
		where	jg_flag in ('0','8','B','9') -- 0-���߰�(�Ϲ�), 8-���߰�(�׷��),  B-���߰�_SGM, 9-����->�Ϲ�
		and		jg_date >= @sdate and jg_date < @edate+1
		and		jg_id in  (
				select mm_id from #cm_alba
		)
	) a
		inner join 
	(
		--  �ڱ� ��� �з��϶���
		select distinct manage_date, mm_id, left(category, 4) mcate
		from tbl_cm_alba_ref_real_mcate_manager where manage_date between @sdate and @edate		
	) b on a.jg_id = b.mm_id and a.mcate = b.mcate and jg_date = convert(varchar(10), manage_date, 120)
		inner join analstore.dbo.goods c on jg_modelno = g_modelno
	where g_jobcode>'0' and g_category+'' not like '00%' and g_category+'' like '[0123456789]___%'
	and isnull(g_spec2,'') <> '' 

	-- pricelist ��Ī����. �Ϻ� �۾���
	insert into #tbl_cm_alba_agg_alba_desc_price(mm_id, pl_no)
	select distinct jp_id, jp_plistno
	from
	(
		select  distinct jp_id, jp_plistno, left(jp_category, 4) mcate, convert(varchar(10), jp_date, 120) jp_date
		from	job_pricelist
		where	jp_modelno>0 and jp_flag in ('0', '5', '2', '6')
		and		jp_date>=@sdate and jp_date < @edate+1
		and		jp_id in  (
				select mm_id from #cm_alba
		)
	) a
	inner join 
	(
		--  �ڱ� ��� �з��϶���
		select distinct manage_date, mm_id, left(category, 4) mcate
		from tbl_cm_alba_ref_real_mcate_manager where manage_date between @sdate and @edate		
	) b on a.jp_id = b.mm_id and a.mcate = b.mcate and jp_date = convert(varchar(10), manage_date, 120)

	-- �۾��� �α׿��� pl_no �� ���� �𵨹�ȣ
	update #tbl_cm_alba_agg_alba_desc_price
	set day_last_modelno = isnull((select top 1 jp_modelno from job_pricelist where jp_plistno = pl_no and jp_date >= @sdate  and jp_flag in ('0','5','2','6') order by jp_date desc), 0)

	-- ------------------------
	-- �۾���, ��ǥ��
	-- ------------------------
	select a.item_no, a.mm_id, all_cnt, fix_cnt, goal_cnt

	, round(all_cnt*100.0/goal_cnt,0) as all_goal_rate
	, round(fix_cnt*100.0/goal_cnt,0) as fix_goal_rate	

	, cast(0 as money) all_bonus
	, cast(0 as money) fix_bonus
	into #tmp_result
	from 
	(	
		-- �۾���
		select item_no, mm_id, sum(all_cnt) all_cnt, sum(fix_cnt) fix_cnt
		from
		(
			-- �۾��� : �ߺ�����
			select 1 item_no, mm_id, count(*) fix_cnt, 0 all_cnt
			from #tbl_cm_alba_agg_alba_desc_goods
			group by mm_id

			union all

			select 2 item_no, mm_id, count(*) fix_cnt, 0 all_cnt
			from #tbl_cm_alba_agg_alba_desc_price
			where day_last_modelno > 0 -- ������� ���� �𵨹�ȣ
			group by mm_id

			union all

			-- �۾��� : �ߺ�����
			select b.item_no, a.mm_id, 0 fix_cnt, sum(result_cnt) all_cnt
			from
			(
				select distinct manage_date , left(category,4) mcate, mm_id
				from tbl_cm_alba_ref_real_mcate_manager
				where manage_date between @sdate and @edate
			) a
				inner join 
			(
				select item_no, left(category, 4) mcate, mm_id, result_date, sum(result_cnt) result_cnt 
				from tbl_cm_alba_result_joblog_by_cate_id 
				where result_date between @sdate and @edate
				group by item_no, left(category, 4), mm_id, result_date
			) b on a.mcate = b.mcate and manage_date = result_date and a.mm_id = b.mm_id	
			group by a.mm_id, b.item_no
		) a 
		group by item_no, mm_id

	) a 
		inner join 
	(
		-- ��ǥ��
		select mm_id, item_no, sum(goal_cnt) goal_cnt
		from
		(
			-- ����CM
			select  a.mm_id, case b.item_no  when 6 then 1 when 8 then 2 end as item_no, b.goal_cnt
			from 
			(
				select distinct manage_date , left(category,4) mcate, mm_id
				from tbl_cm_alba_ref_real_mcate_manager
				where manage_date between @sdate and @edate
				and alba_flag = '1'
			) a inner join tbl_cm_perf_goal b on a.manage_date = b.goal_date and a.mcate=b.category and b.item_no in (6,8) -- ���߰�, ��ȣ��Ī
			union all
			-- ����ACM(����,����), ���ø�Ī
			select  a.mm_id, b.item_no, b.goal_cnt
			from 
			(
				select distinct manage_date , left(category,4) mcate, mm_id
				from tbl_cm_alba_ref_real_mcate_manager
				where manage_date between @sdate and @edate 
				and alba_flag in ('2','3','4')
			) a inner join tbl_cm_alba_goal b on a.manage_date = b.goal_date and category = mcate and b.item_no in (1,2) -- ���߰�, ��ȣ��Ī
		) a
		group by mm_id, item_no
	) b on a.item_no = b.item_no and a.mm_id = b.mm_id



	-- ------------------------
	-- ������ ���
	-- ------------------------
	-- ������ // 100% �޼��� �⺻ 10���� + 1% �ʰ��ø��� 5000����( �ִ� 15�������� )
	update #tmp_result 
	set	fix_bonus = (case when fix_goal_rate >=100 then 100000 + (fix_goal_rate - 100)*5000 else 0 end)
	,	all_bonus = (case when all_goal_rate >=100 then 100000 + (all_goal_rate - 100)*5000 else 0 end)
	where mm_id in (select mm_id from #cm_alba where alba_flag in ('1','2')) -- ����CM, ����ACM(����)��.

	-- �� �������� �׸�� 15������ �ʰ��� �� ����.
	update #tmp_result 	
	set fix_bonus = case when fix_bonus > 150000 then 150000 else fix_bonus end
	,	all_bonus = case when all_bonus > 150000 then 150000 else all_bonus end

	

	-- ���� ����Է�
	insert into tbl_cm_alba_pay(mm_id, mm_nm, base_pay, g_goal_cnt, g_all_cnt, p_all_cnt, all_bonus, p_goal_cnt, g_fix_cnt, p_fix_cnt, fix_bonus)
	select a.mm_id, a.mm_nm, a.base_pay, g_goal_cnt, g_all_cnt, p_all_cnt, all_bonus, p_goal_cnt, g_fix_cnt, p_fix_cnt, fix_bonus
	from 
	(
		-- �⺻��
		select mm_id, mm_nm, base_pay =
			case alba_flag
				when '1' then 1200000		-- ����CM
				when '2' then 1000000		-- ����ACM(����)
				when '3' then 600000		-- ���ø�Ī
				when '4' then 600000		-- ����ACM(����)
			end
		from #cm_alba
	) a	
	inner join 
	(
		select mm_id
		,	sum(case when item_no = 1 then goal_cnt end) g_goal_cnt
		,	sum(case when item_no = 1 then all_cnt end) g_all_cnt
		,	sum(case when item_no = 1 then fix_cnt end) g_fix_cnt	

		,	sum(case when item_no = 2 then goal_cnt end) p_goal_cnt
		,	sum(case when item_no = 2 then all_cnt end) p_all_cnt
		,	sum(case when item_no = 2 then fix_cnt end) p_fix_cnt

		,	sum(fix_bonus) fix_bonus
		,	sum(all_bonus) all_bonus
		from #tmp_result 
		where item_no in (1,2)
		group by mm_id
	) b on a.mm_id = b.mm_id
end






