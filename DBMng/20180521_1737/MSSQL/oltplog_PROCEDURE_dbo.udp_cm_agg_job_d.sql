/* *************************************************************************
 * NAME : dbo.udp_cm_agg_job_d
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:28:37.57
 *        Modify: 2018-05-10 15:28:37.57
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cm_agg_job_d
	@agg_date smalldatetime = null
as begin
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2018.02.05
	-- ��  �� : id�� �з��� ����.�۾���
	-- ��  �� : udp_cm_perf_result_joblog_agg - ������ǥ �۾���
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/*
	������:			������:			��������:
	-------------------------------------------------

	*/
	if @agg_date is null begin
		set @agg_date = isnull(@agg_date, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime))
	end

	-- goods
	insert into tbl_cm_agg_job_d(agg_date, mm_id, category, is_pg, job_cnt)
	select @agg_date, jg_id, left(jg_category+'00000000', 6), 'G', count(*)
	from
	(
		select	jg_modelno, jg_flag, jg_id, left(max(isnull(jg_category,'000000')), 6) jg_category
		from	job_goods
		where	jg_flag in ('0','8','B','9','p','m') -- 0-���߰�(�Ϲ�), 1-���īŻ, 8-���߰�(�׷��),  B-���߰�_SGM, 9-����->�Ϲ�, p-������ǰ��, m-�������𵨸�
		and		jg_date >= @agg_date and jg_date < @agg_date+1

		and		jg_id not like 'book[_]%'
		and		jg_id not like 'enuri[_]%'
		and		jg_id not like 'mp[_]%'
		and		jg_id not like 'nuribot[_]%'
		and		jg_id not like 'sdu[_]%'
		and		jg_id not like 'direct[_]%'

		group by jg_modelno, jg_flag, jg_id
		--and		jg_id in (select mm_id from simpledb.dbo.mm_enuri_cm)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	where isnull(g_spec2,'') <> '' and g_jobcode>'0' -- ������� ������ ����
	group by jg_id, left(jg_category+'00000000', 6)

	-- pricelist
	insert into tbl_cm_agg_job_d(agg_date, mm_id, category, is_pg, job_cnt)
	select @agg_date, jp_id, left(jp_category+'00000000', 6) category, 'P', sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, jp_id, count(distinct jp_plistno) cnt, max(isnull(jp_category, '000000')) jp_category
		from	job_pricelist
		where	jp_modelno>0 and jp_flag in ('0', '5', '2', '6','p','m')
		and		jp_date>=@agg_date and jp_date < @agg_date+1

		and		jp_id not like 'book[_]%'
		and		jp_id not like 'enuri[_]%'
		and		jp_id not like 'mp[_]%'
		and		jp_id not like 'nuribot[_]%'
		and		jp_id not like 'sdu[_]%'
		and		jp_id not like 'direct[_]%'

		--and jp_id in (select mm_id  from simpledb.dbo.mm_enuri_cm)
		--and g_category not like '00%' and g_category like '[0123456789]___%'
		group by jp_modelno, jp_id
	) a
	group by jp_id, left(jp_category+'00000000', 6)

	-- ��ī�� ����� ���� ǥ��
	update a
	set is_cate_manager = 1
	from tbl_cm_agg_job_d a 
		inner join tbl_cm_perf_ref_real_mcate_manager b 
			on a.agg_date = b.manage_date and a.mm_id = b.mm_id and left(a.category,4) = b.category
	where a.agg_date = @agg_date
end


