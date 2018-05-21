/* *************************************************************************
 * NAME : dbo.udp_cm_perf_ord_rate_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:34:57.1
 *        Modify: 2018-05-10 15:34:57.1
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_perf_ord_rate_agg
	@agg_date smalldatetime = null
as
begin
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25
	-- ��  �� : ������ȯ��
	-- ��  �� : �ֹ��� & Ŭ���ƿ�������
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted

	if @agg_date is null begin
		-- �ſ� 1��
		set @agg_date = cast(convert(varchar(10), dateadd(d, -day(getdate())+1, getdate()), 120) as smalldatetime)
	end


	if object_id('tmp_cm_perf_ord_rate_worktable_20150428') is not null
		drop table tmp_cm_perf_ord_rate_worktable_20150428

	create table tmp_cm_perf_ord_rate_worktable_20150428(
		g_modelno	int
	,	category	varchar(8)
	,	clickout	int
	,	od_cnt		int
	,	device		char(1)
	)
	create nonclustered index cl_clickout on tmp_cm_perf_ord_rate_worktable_20150428(g_modelno)
	

	delete from tbl_cm_perf_goal_order_rate where  goal_date = @agg_date

	-- ---------------------
	-- PC.Clickout.������.��Ī
	-- ---------------------
	insert into tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, clickout, device)
	select g_modelno, left(g_category,4) category, sum(mh_uhit), 'p' device	
	from tbl_move_hit with (readuncommitted)
	where mh_date >= dateadd(m, -3, @agg_date) and mh_date < @agg_date
	group by g_modelno, left(g_category,4) 


	-- ---------------------
	-- PC.Clickout.������.�̸�Ī
	-- ---------------------
	insert tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, clickout, device)
	select 0, ltrim(rtrim(pl_category)) category, nrh_uhit, 'p' device
	from
	(
		select pl_no, nrh_date, pl_category, nrh_uhit, nrh_hit from tbl_nonreg_hit where nrh_date >= dateadd(m, -3, @agg_date) and nrh_date < @agg_date and pl_category like '____%'
		union all
		select pl_no, msh_date, pl_category, msh_uhit, msh_hit from tbl_mixsingle_hit where msh_date >= dateadd(m, -3, @agg_date) and msh_date < @agg_date and pl_category like '____%'
	) a	

	-- ---------------------
	-- �����.Clickout.������
	-- ---------------------
	insert tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, clickout, device)
	select modelno, left(category,4) category, sum(uhit), 'm' device
	from tbl_move_log_mobile_agg_day_by_modelno
	where regdate >= dateadd(m, -3, @agg_date) and regdate < @agg_date
	group by modelno, left(category,4) 


	-- ---------------------
	-- PC.�ֹ�.������.��Ī
	-- ---------------------
	insert tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, od_cnt, device)
	select pl_modelno, left(od_category,4) category, count(*), 'p' device
	from tbl_orderdata 
	where od_date >= dateadd(m, -3, @agg_date) and od_date < @agg_date
	and shop_vcode not in (536,55,5910)
	group by pl_modelno, left(od_category,4) 

	insert tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, od_cnt, device)
	select pl_modelno, left(od_category,4)  category, count(*), 'p' device
	from tbl_orderdata_gmarket_auction
	where od_date >= dateadd(m, -3, @agg_date) and od_date < @agg_date
	group by pl_modelno, left(od_category,4) 

	-- ---------------------	
	-- �����.�ֹ�.������.��Ī
	-- ---------------------
	insert tmp_cm_perf_ord_rate_worktable_20150428(g_modelno, category, od_cnt, device)
	select pl_modelno, left(od_category,4) category, count(*), 'm' device
	from tbl_orderdata_ord_mobile
	where od_date >= dateadd(m, -3, @agg_date) and od_date < @agg_date
	group by pl_modelno, left(od_category,4) 


	-- ---------------------
	-- ������ �з� ���� �Է�
	-- ---------------------
	update a
	set  category = ltrim(rtrim(left(b.g_category,4)))
	from tmp_cm_perf_ord_rate_worktable_20150428 a inner join analstore.dbo.goods  b on a.g_modelno = b.g_modelno
	where g_category not like '00%' -- �������� ������ ������Ʈ ���� �ʴ´�.
	and g_category like '____%'

	-- -------------------------------
	-- �з����� �����丮
	-- -------------------------------
	-- Ŀ���� ����
	declare @sql nvarchar(4000)
	declare chg_cate cursor for 
	select 'update tmp_cm_perf_ord_rate_worktable_20150428 set category  = '''+new_category+''' where  category like  '''+old_category+'%''' as qry
	from tbl_cate_change_history with (nolock) 
	where change_date >= dateadd(m, -3, @agg_date) and change_date < @agg_date
	order by change_date asc, len(new_category) desc

	open chg_cate
	fetch next from chg_cate 
	into @sql

	while @@fetch_status = 0
	begin
		
		
		exec (@sql)

		-- get the next category.
		fetch next from chg_cate 
		into @sql
	end 
	close chg_cate
	deallocate chg_cate


	-- -------------------------------
	-- ��ǥ �Է�
	-- -------------------------------
	insert into tbl_cm_perf_goal_order_rate(category, clickout, od_cnt, device, goal_date)
	select left(category, 4), sum(clickout) clickout, sum(od_cnt), device, @agg_date
	from tmp_cm_perf_ord_rate_worktable_20150428
	where category not like '00%' and category like '____%'
	group by left(category, 4), device

	-- -------------------------------
	-- ����з� ����
	-- -------------------------------
	update tbl_cm_perf_goal_order_rate set is_realcate = 0 
	where not exists(select top 1 1 from tbl_cm_perf_ref_real_mcate where left(tbl_cm_perf_goal_order_rate.category, 4)  = tbl_cm_perf_ref_real_mcate.category)
	and goal_date = @agg_date

	-- -------------------------------
	-- �۾� ���̺� ����
	-- -------------------------------
--	if object_id('tmp_cm_perf_ord_rate_worktable_20150428') is not null
--		drop table tmp_cm_perf_ord_rate_worktable_20150428
end

