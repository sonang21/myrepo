/* *************************************************************************
 * NAME : dbo.udp_cm_agg_vip_d
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:30:52.307
 *        Modify: 2018-05-10 15:30:52.307
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_cm_agg_vip_d
	@agg_date smalldatetime = null
as begin
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2018.02.06
	-- 설  명 : 소분류별 집계.작업량
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/
	if @agg_date is null begin
		set @agg_date = isnull(@agg_date, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime))
	end

	-- 로그저장 시점의 담당자
	/*
	select category, max(mm_id) mm_id
	into #mcate_manager
	from tbl_cm_perf_ref_real_mcate_manager where manage_date = @agg_date
	group by category
	*/

	-- pc
	-- 1000회 이상 hit ip
	select	userip
	into	#blacklist_pc
	from	tbl_model_log with (readuncommitted)
	where	regdate = convert(char(8),@agg_date, 112)
	group by userip
	having count(*) > 1000

	select 'P' device, modelno, count(*) as uhit, sum(hit) as mhit, max(category) category
	into #work_ord_step1
	from
	(
		select  modelno, sum(hit) as hit, max(category) category
		from
		(
			-- ip 중복제거
			select  modelno, max(tmpid) as tmpid, count(*) as hit, max(category) category
			from	tbl_model_log
			where	regdate = convert(char(8),@agg_date, 112)
			and		userip not in (
				-- 블랙 리스트 제외
				select userip from  #blacklist_pc
			)
			group by  modelno, userip
			union all

			-- ip 중복허용
			select	modelno, tmpid, 0 as hit, category
			from	tbl_model_log
			where	regdate = convert(char(8),@agg_date, 112)
			and		userip in(select userip from tbl_model_log_filterip)
			and		userip not in (
				-- 블랙 리스트 제외
				select userip from  #blacklist_pc
			)
		) a
		group by  modelno, tmpid
	)	b
	group by modelno
	option (maxdop 1)

	-- mobile
	-- 1000회 이상 hit ip
	select userip
	into #blacklist_mobile
	from tbl_model_log_mobile with (readuncommitted)
	where regdate >= @agg_date and regdate < dateadd(d, 1, @agg_date)
	group by userip
	having count(*) > 1000


	insert into #work_ord_step1
	select 'M', modelno, count(*) as uhit, sum(hit) as mhit, max(category) category
	from
		(
		select modelno,  sum(hit) as hit, max(category) category
		from
			(
			-- ip중복 제거
			select	modelno, max(tmpid) as tmpid, count(*) as hit, max(category) category
			from	tbl_model_log_mobile
			where	regdate >= @agg_date and regdate < dateadd(d, 1,  @agg_date)
			and userip not in (
				-- 블랙 리스트 제외
				select userip from  #blacklist_mobile
			)
			group by  modelno, userip
			union all
			-- ip중복 허용
			select	modelno, tmpid, 0 as hit, category
			from	tbl_model_log_mobile
			where	regdate >= @agg_date and regdate < dateadd(d, 1,  @agg_date)
			and userip not in (
				-- 블랙 리스트 제외
				select userip from  #blacklist_mobile
			)
			and userip in(select userip from tbl_model_log_filterip)
			) a
		group by modelno, tmpid
		) c
	group by modelno
	option (maxdop 1)


	select sign(g_modelno) sign_modelno
	,	ltrim(rtrim(isnull(g_category, a.category))) category
	,	device
	,	sum(uhit) uhit
	,	sum(mhit) mhit
	--,	c.mm_id
	into #work_ord
	from #work_ord_step1 a
			left outer join alnalstore.dbo.goods b on a.MODELNO = b.g_modelno and b.g_category not like '00%' -- 현시점
	--		left outer join #mcate_manager c on left(a.category,4) = c.category
	group by sign(g_modelno)
	,	isnull(g_category, a.category) 
	,	device
	--,	c.mm_id
	option (maxdop 1)

	--분류변경 cursor처리 : 현시점
	if datediff(d, @agg_date, getdate()) > 30 begin
		-- 과거 데이터 (오늘 기준 30일 이전)를 집계할 때만 현시점 적용
		-- 득보다 실이 클 것 같아서 개발자가 추가한 제한 사항임
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
			and isnull(sign_modelno,0) = 0 -- 일반상품만

			fetch next from chg_category_cursor into @old_category, @new_category

		end

		close chg_category_cursor
		deallocate chg_category_cursor

	end

	-- 2차 최종집계
	delete from tbl_cm_agg_vip_d where agg_date = @agg_date
	insert into tbl_cm_agg_vip_d(agg_date, device, category, mhit, uhit)--, mm_id)
	select @agg_date, device, left(category+'00000000', 6), sum(mhit), sum(uhit)--, mm_id
	from #work_ord
	group by device
	, left(category+'00000000', 6)
	--, mm_id
end




