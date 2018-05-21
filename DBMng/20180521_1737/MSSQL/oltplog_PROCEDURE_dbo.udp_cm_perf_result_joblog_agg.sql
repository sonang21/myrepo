/* *************************************************************************
 * NAME : dbo.udp_cm_perf_result_joblog_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:36:57.8
 *        Modify: 2018-05-10 15:36:57.8
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cm_perf_result_joblog_agg
	@agg_date smalldatetime = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-06-27
	-- ��  �� : id�� ����.�۾���
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2014.10.01		wookki25		����ó�� : �з����� ���� http://58.234.199.100/redmine/issues/2494
	2016.10.19		wookki25		[ ����->�Ϲ� ] Ư�� �з������� �۾������� ǥ�� -> ��ü �з�
									
	*/
	set @agg_date = isnull(@agg_date, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime))

	-- �������
	select g_modelno, g_category, g_spec2, jg_id, jg_flag
	into #job_goods
	from 
	(
		select	distinct jg_modelno, jg_flag, jg_id
		from	job_goods			
		where	jg_flag in ('0','8','B','9','p','m') -- 0-���߰�(�Ϲ�), 1-���īŻ, 8-���߰�(�׷��),  B-���߰�_SGM, 9-����->�Ϲ�, p-������ǰ��, m-�������𵨸�
		and		jg_date >= @agg_date and jg_date < @agg_date+1
		and		jg_id in (select mm_id from simpledb.dbo.mm_enuri_cm)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	where g_jobcode>'0' 

	
	-- īŻ�α� �߰�����
	-- jg_flag = '0' : ���߰�=���īŻ=Catal �߰�
	
	-- �з���
	delete from tbl_cm_perf_result_joblog where item_no = 6 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 	6 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''-- and (jg_flag in ('0','8','B','p','m') or (jg_flag ='9' and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') ))  -- cm2��
	group by left(g_category,4)

	-- ���̵�
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 6 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 	6 item_no, jg_id, @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''-- and (jg_flag in ('0','8','B','p','m') or (jg_flag ='9' and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') ))  -- cm2��
	group by jg_id


--	2014.12.04 // �����Ѵٰ��ؼ� �ּ�ó����.
--	--jg_flag = '1' : �Ϲ�īŻ=��īŻ : �з���
--	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
--	select 	7 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
--	from #job_goods 
--	where jg_flag = '1'  and isnull(g_spec2,'') <> ''
--	and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') -- cm2��
--	/* 2014.07.09
--	2. ������(09) �� �з� �ڵ�īŻ�α� �Һз� ���� ������ ��û.. 
--		��īŻ�α�īŻ�� �ش�
--
--	- �ڵ�īŻ�α״� �ش� �з� �� ����� ������ ���Ե��� �ʵ��� ��û�帳�ϴ�.
--	  �ش�з�)		 ������ȭ/��ȭ(0919) > ����ȭ(091902), ĳ�־�ȭ(091901), ����,������(091904), Ʈ���̴�ȭ(091911), ��ŷȭ(091914)
--					���ȭ/����ǰ(0903) > ����ȭ(090317), �ߵ��ȭ(090318), Ʈ��ŷ,Ʈ���Ϸ���ȭ(090319). ����,�Ϻ�ȭ(090320), �賶(090302), ��꽺ƽ(090323)
--					�ƿ�����/����Ƿ�(0923) > ����_����(092302), ����_����(092303), ����_����(092318), ����_����(092319), ����_����(092320), ����_����(092321)
--	*/
--	and g_category not like '09190[124]%'
--	and g_category not like '09191[14]%'
--
--	and g_category not like '09031[789]%'
--	and g_category not like '09032[03]%'
--	and g_category not like '09030[2]%'
--
--	and g_category not like '09230[23]%'
--	and g_category not like '09231[89]%'
--	and g_category not like '09232[01]%'
--	group by left(g_category,4)

--	2014.12.04 // �����Ѵٰ��ؼ� �ּ�ó����.
--	--jg_flag = '1' : �Ϲ�īŻ=��īŻ : ���̵�
--	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
--	select 	7 item_no, jg_id, @agg_date, count(*) g_add_cnt 
--	from #job_goods 
--	where jg_flag = '1'  and isnull(g_spec2,'') <> ''
--	and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') -- cm2��
--	/* 2014.07.09
--	2. ������(09) �� �з� �ڵ�īŻ�α� �Һз� ���� ������ ��û.. 
--		��īŻ�α�īŻ�� �ش�
--
--	- �ڵ�īŻ�α״� �ش� �з� �� ����� ������ ���Ե��� �ʵ��� ��û�帳�ϴ�.
--	  �ش�з�)		 ������ȭ/��ȭ(0919) > ����ȭ(091902), ĳ�־�ȭ(091901), ����,������(091904), Ʈ���̴�ȭ(091911), ��ŷȭ(091914)
--					���ȭ/����ǰ(0903) > ����ȭ(090317), �ߵ��ȭ(090318), Ʈ��ŷ,Ʈ���Ϸ���ȭ(090319). ����,�Ϻ�ȭ(090320), �賶(090302), ��꽺ƽ(090323)
--					�ƿ�����/����Ƿ�(0923) > ����_����(092302), ����_����(092303), ����_����(092318), ����_����(092319), ����_����(092320), ����_����(092321)
--	*/
--	and g_category not like '09190[124]%'
--	and g_category not like '09191[14]%'
--
--	and g_category not like '09031[789]%'
--	and g_category not like '09032[03]%'
--	and g_category not like '09030[2]%'
--
--	and g_category not like '09230[23]%'
--	and g_category not like '09231[89]%'
--	and g_category not like '09232[01]%'
--	group by jg_id



	--jg_flag = '8' : �׷��Ī �߰�
	-- �з���
	delete from tbl_cm_perf_result_joblog where item_no = 10 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 	10 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where jg_flag = '8' 
	group by left(g_category,4)

	-- ���̵�
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 10 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 	10 item_no, jg_id, @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where jg_flag = '8' 
	group by jg_id
	
/*
job_pricelist.jp_flag 
0 : ��ȣ�Է� (=�𵨹�ȣ)
1 : �������� (=��Ÿ)
2 : �����߰� (=�߰�)
3 : ���ݻ��� (=����)
4 : �з����� (=�з�����)
5 : ��ȣ�Է�(�׷��Ī)
6 : ��ȣ�Է�(���ϻ�ǰ�׷��Ī)
*/

	-- pricelist ��Ī���� : �з���
	delete from tbl_cm_perf_result_joblog where item_no = 8 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 8 item_no, left(g_category,4) category, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, count(distinct jp_plistno) cnt
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6','p','m') 
		and jp_date>=@agg_date and jp_date < @agg_date+1
		and jp_id in (select mm_id  from simpledb.dbo.mm_enuri_cm)
		group by jp_modelno
	) a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	group by left(g_category, 4)

	-- pricelist ��Ī���� : ���̵�
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 8 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 8 item_no, jp_id, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, jp_id, count(distinct jp_plistno) cnt
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6','p','m') 
		and jp_date>=@agg_date and jp_date < @agg_date+1
		and jp_id in (select mm_id  from simpledb.dbo.mm_enuri_cm)
		group by jp_modelno, jp_id
	) a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	group by jp_id


	-- ����з� ����
	update tbl_cm_perf_result_joblog set is_realcate = 0 
	where not exists(select top 1 1 from tbl_cm_perf_ref_real_mcate where left(tbl_cm_perf_result_joblog.category, 4)  = tbl_cm_perf_ref_real_mcate.category)
	and result_date = @agg_date


	-- ---------------------------------------------------
	-- �߰��� �� ������ �Է�: ����� �ȵ� ���� �������Ѵ�. 
	-- ---------------------------------------------------
	insert into tbl_cm_perf_ref_add_model
	select @agg_date, g_category, g_modelno
	from 
	(
		select	distinct jg_modelno
		from	job_goods			
		where	jg_flag = '0'
		and		jg_date >= @agg_date and jg_date < @agg_date+1
		and		jg_id in (select mm_id from simpledb.dbo.mm_enuri_cm)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	where g_jobcode>'0' and isnull(g_spec2,'') <> ''
	and g_category not like '00%' and g_category like '[0123456789]___%'


	-- ---------------------------------------------------
	-- ����ó�� : �з�����
	-- ---------------------------------------------------
	-- �з�����1 : - 2211: 2211 + 2212 + 2213 + 2222 + 2223 + 2226 + 2227 + 2228
--	select item_no, '2211' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	into #x
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('2211','2212','2213','2222','2223','2227','2228')
--	group by item_no
--	union all
	-- �з�����2 : - 2241: 2241 + 2242 + 2243 + 2244
--	select item_no, '2241' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('2241', '2242','2243','2244')
--	group by item_no
--
--	delete from tbl_cm_perf_result_joblog where result_date = @agg_date and category in ('2211','2241')
--
--	insert into tbl_cm_perf_result_joblog(item_no, category, result_date, result_cnt, is_realcate)
--	select item_no, category, result_date, result_cnt, is_realcate from #x


--if @agg_date between cast('2014-08-27' as smalldatetime) and cast('2014-08-31' as smalldatetime) begin
--	-- ---------------------------------------------------
--	-- ����ó�� : �з�����..�Ⱓ����
--	-- ---------------------------------------------------
--	-- �з�����1 : - 1614 : 1614 + 2303
--	select item_no, '1614' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	into #y
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('1614','2303')
--	group by item_no
	

--	delete from tbl_cm_perf_result_joblog where result_date = @agg_date and category in ('1614')

--	insert into tbl_cm_perf_result_joblog(item_no, category, result_date, result_cnt, is_realcate)
--	select item_no, category, result_date, result_cnt, is_realcate from #y
--end






