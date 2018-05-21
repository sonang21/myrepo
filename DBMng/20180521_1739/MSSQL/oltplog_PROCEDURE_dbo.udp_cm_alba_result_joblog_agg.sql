/* *************************************************************************
 * NAME : dbo.udp_cm_alba_result_joblog_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:33:27.03
 *        Modify: 2018-05-10 15:33:27.03
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_alba_result_joblog_agg
	@agg_date smalldatetime = null
as 
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
	set @agg_date = cast(isnull(@agg_date, getdate()-1) as date)


	delete from tbl_cm_alba_result_joblog_by_cate_id where result_date = @agg_date

	select mm_id, alba_flag 
	into #cm_alaba 
	-- select *
	from openquery(SEARCHKEY_193, 'select mm_id, alba_flag from enuridb.dbo.mm_enuri where mm_flag =''1'' and mm_partcode like ''_________429'' and alba_flag in (''1'',''2'',''3'',''4'')')


	-- īŻ�α� �߰�����
	select g_modelno, jg_category as g_category, g_spec2, jg_id, jg_flag
	into #job_goods
	from 
	(
		select	jg_modelno, jg_flag, jg_id, max(jg_category) jg_category
		from	job_goods			
		where	jg_flag in ('0','8','B','9') -- 0-���߰�(�Ϲ�), 8-���߰�(�׷��),  B-���߰�_SGM, 9-����->�Ϲ�
		and		jg_date >= @agg_date and jg_date < dateadd(d, 1, @agg_date)
		and		jg_id in (select mm_id from #cm_alaba)
		group by jg_modelno, jg_flag, jg_id
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	where g_jobcode>'0' 
	and g_category+'' not like '00%' and g_category+'' like '[0123456789]___%'

	insert into tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 	1 item_no, jg_id, left(g_category, 6), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''
	and	jg_id in (select mm_id from #cm_alaba where alba_flag in ('2','4') ) -- ����ACM
	group by jg_id, left(g_category, 6) -- �Һз�

	insert into tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 	1 item_no, jg_id, left(g_category, 4), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''
	and	jg_id in (select mm_id from #cm_alaba where alba_flag not in ('2','4') )
	group by jg_id, left(g_category, 4) -- �ߺз�



	-- pricelist ��Ī����
	insert into tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 2 item_no, jp_id, left(jp_category,6) category, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_id, jp_modelno, count(distinct jp_plistno) cnt, max(jp_category) as jp_category
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6') 
		and jp_date>=@agg_date and jp_date <  dateadd(d, 1, @agg_date)
		and jp_id in (select mm_id from #cm_alaba where alba_flag in ('2','4') ) -- ����ACM
		group by jp_id, jp_modelno
	) a
	group by jp_id, left(jp_category, 6) -- �Һз�


	insert into tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 2 item_no, jp_id, left(jp_category,4) category, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_id, jp_modelno, count(distinct jp_plistno) cnt, max(jp_category) jp_category
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6') 
		and jp_date>=@agg_date and jp_date <  dateadd(d, 1, @agg_date)
		and jp_id in (select mm_id from #cm_alaba where alba_flag not in ('2','4') )
		group by jp_id, jp_modelno
	) a
	group by jp_id, left(jp_category, 4) -- �ߺз�


	-- pricelist ��ȣ�̸�Ī : ���ø�Ī��..
	insert into tbl_cm_alba_result_joblog_by_cate_id( item_no, mm_id, category, result_date, result_cnt )
	select 3 item_no, jp_id, left(jp_category,4) as category, @agg_date, count(distinct jp_plistno) p_matching_cnt
	from job_pricelist 
	where jp_modelno=0 and jp_flag in ('0', '5', '2', '6') 
	and jp_id in (select mm_id from #cm_alaba where alba_flag ='3' ) -- ���ø�Ī
	and jp_date>=@agg_date and jp_date < dateadd(d, 1, @agg_date)
	group by jp_id, left(jp_category,4)
	
end








