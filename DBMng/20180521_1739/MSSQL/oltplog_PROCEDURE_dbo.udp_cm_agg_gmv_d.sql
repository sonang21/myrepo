/* *************************************************************************
 * NAME : dbo.udp_cm_agg_gmv_d
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 20:04:22.63
 *        Modify: 2018-05-13 20:05:37.843
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_agg_gmv_d
	@agg_date smalldatetime = null
as
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2018.02.05
	-- ��  �� : �Һз��� ����.�۾���
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

	-- ��ǥ�� ������
	exec udp_cm_agg_goal_d @agg_date

	-- �α����� ������ �����
	/*
	select category, max(mm_id) mm_id
	into #mcate_manager
	from tbl_cm_perf_ref_real_mcate_manager where manage_date = @agg_date
	group by category
	*/

	-- 1�� ����
	select sign(g_modelno) sign_modelno
	,	rtrim(ltrim(isnull(g_category, a.category))) category
	,	device
	,	sum(od_cnt) od_admunt
	,	sum(od_total) od_total
	,	count(*) od_cnt
	--,	c.mm_id
	into #work_ord
	from
	(
		select 'P' device, pl_modelno modelno, od_category category, od_cnt, (od_cnt * od_price) od_total
		from tbl_orderdata
		where od_date>= @agg_date and od_date < @agg_date+1
		and shop_vcode not in (55, 536, 5910, 4027)
		union all

		select 'P' device, pl_modelno, od_category, od_cnt, (od_cnt * od_price) od_total
		from tbl_orderdata_gmarket_auction
		where od_date>= @agg_date and od_date < @agg_date+1
		and shop_vcode in (55, 536, 5910, 4027)
		union all

		select 'M' device, pl_modelno, od_category, od_cnt, (od_cnt * od_price) od_total
		from tbl_orderdata_ord_mobile
		where od_date>= @agg_date and od_date < @agg_date+1
	) a
		left outer join analstore.dbo.goods b on a.modelno = b.g_modelno  and b.g_category not like '00%' -- ������
	--	left outer join #mcate_manager c on left(a.category,4) = c.category
	group by sign(g_modelno)
	,	isnull(g_category, a.category)
	,	device
	--,	c.mm_id

	--������ : �з����� cursoró��
	if datediff(d, @agg_date, getdate()) > 2 begin
		-- ���� ������ (���� ���� 30�� ����)�� ������ ���� ������ ����
		-- �溸�� ���� Ŭ �� ���Ƽ� �����ڰ� �߰��� ���� ������
		select old_category, new_category
		into #change_cate
		from tbl_cate_change_history
		where change_date >= @agg_date
		order by change_date asc, len(new_category) desc

		declare @old_category varchar(12)
		declare @new_category varchar(12)

		declare chg_category_cursor cursor for (
			select old_category, new_category from #change_cate
		)

		open chg_category_cursor
		fetch next from chg_category_cursor into @old_category, @new_category

		while (@@fetch_status=0) begin

			update #work_ord
			set category = @new_category
			where category like @old_category+'%'
			and isnull(sign_modelno,0) = 0 -- �Ϲݻ�ǰ��

			fetch next from chg_category_cursor into @old_category, @new_category

		end

		close chg_category_cursor
		deallocate chg_category_cursor

	end

	-- 2�� ��������
	delete from tbl_cm_agg_gmv_d where agg_date = @agg_date
	insert into tbl_cm_agg_gmv_d(agg_date, device, category, od_amount, od_cnt, od_total)--, mm_id)
	select @agg_date, device, left(category, 6), sum(od_admunt), sum(od_cnt), sum(od_total)--, mm_id
	from #work_ord
	group by device, left(category, 6)--, mm_id



