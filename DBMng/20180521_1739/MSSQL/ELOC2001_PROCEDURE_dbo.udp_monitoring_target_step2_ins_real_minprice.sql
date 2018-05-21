/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step2_ins_real_minprice
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-12-03 16:47:56.623
 *        Modify: 2018-05-03 17:23:34.563
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_step2_ins_real_minprice
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.12.03
	-- 설  명 : 모니터링 데이터 수집.CTU & MINIBot 최저가
	-- ----------------------------------------------
	-- 수  정
	-- ----------------------------------------------
	-- wookki25 / 2016.02.26		중분류 1~60위 -> 중분류 1~30위
	-- wookki25 / 2016.02.26		중분류 1~30위 -> 중분류별 인기순위 차등적용
	-- wookki25 / 2016.08.17		단종1만 모니터링 대상으로 처리	
	-- ----------------------------------------------


	declare @qry varchar(8000)

	-- 데이터 가져올 시간 설정
		declare @sdate varchar(16)
		declare @edate varchar(16)
		set @edate = convert(varchar(15), getdate(), 120)+'0'
		set @sdate = convert(varchar(16), dateadd(mi , -10, cast(@edate as smalldatetime)), 120)



	-- 예외처리 / 8시 첫타임은 전일 23시부터~금일 08시까지 데이터로 처리		
	--	if right(@edate, 5) = '08:00' begin
	--		set @sdate = convert(varchar(16), dateadd(hh, -9, cast(@edate as smalldatetime)), 120)
	--	end
		

	-- 쿼리 생성 / 최저가 동일가도 포함
		set @qry = 'select pl_no, up_price, min_price, regdate ,modelno from tbl_mini_nuribot_log tm 
		where  tm.up_price <= tm.min_price and regdate >= to_date('''''+ @sdate +''''', ''''YYYY-MM-DD HH24:MI'''') 
			and regdate < to_date('''''+ replace(replace(replace(@edate,'-',''), ':', ''), ' ','') +''''', ''''YYYY-MM-DD HH24:MI'''')'


	-- 오라클에서 데이터 이전
		create table #target_pl_no(
			pl_no bigint
		,	modelno int
		,	assign_mm_id varchar(12)
		,	comp_order smallint
		,	monitor_no smallint
		,	today_first_date datetime default(getdate())
		)

		insert into #target_pl_no(pl_no, modelno)
		exec ('select distinct pl_no, modelno from openquery(oradb, '''+@qry+''')')

	-- 중분류별 n개 모델 // 2015.12.08 기능추가 // 중분류 1~60위 모델 데이터만 사용
		delete from #target_pl_no where modelno not in (
			-- select modelno from tbl_mcate_popular_rank where mcate_group_rank between 1 and 30 -- 
			-- 중분류별 인기순위 차등 적용
			select modelno
			from tbl_mcate_popular_rank a 
				inner join tbl_monitoring_target_cate_set  b on left(a.category,4) = b.category
			where a.mcate_group_rank between b.pop_s_rank and b.pop_e_rank

		)



		-- 단종1만 모니터링 대상으로 처리 : http://58.234.199.100/redmine/issues/17499
		delete a from #target_pl_no a inner join goods b on a.modelno = b.g_modelno where g_constrain <> '1'



		-- 우선순위 설정
		update a
		set comp_order = b.comp_order
		, monitor_no = b.monitor_no 
		from #target_pl_no a cross join (select comp_order, monitor_no from tbl_monitoring_team_agg_name where monitor_no=23) b 


		-- 당일 최초 입력시점 저장
		update a -- tbl_monitoring_target_raw_new
		set today_first_date = b.today_first_date
		from #target_pl_no a inner join tbl_monitoring_target b on a.pl_no = b.pl_no 
		where b.today_first_date >= cast(cast(getdate() as date) as datetime)
		and b.p_status = 'i'


		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
		delete a -- tbl_monitoring_target_raw_new
		from #target_pl_no a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
		where b.p_status = 'i'

		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
		delete b --tbl_monitoring_target
		from #target_pl_no a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
		where b.p_status = 'i'

		-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
		delete b --tbl_monitoring_target
		from #target_pl_no a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
		where b.p_status in ('u', 'd')



	-- 분배(= 할당)
		select identity(int, 1, 1) seqno, mm_id
		into #mm_id
		from
		(
			select distinct cast(substring(vals, s, e-s) as varchar(12)) as mm_id
			from 
			(  
				select  min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
				from  (select top 1 replace(assign_mm_id_add,' ','') vals from tbl_mc_manager_set) a  -- 사내직원만
				inner join master.dbo.spt_values b 
				on len(a.vals) >= b.number and type='p'
				group by charindex (',',vals+',',number)
			) a
		) b

		declare @id_cnt int
		select @id_cnt = count(*) from #mm_id

		update x
		set assign_mm_id = y.mm_id
		from #target_pl_no x
				inner join
			(
				select pl_no, mm_id
				from (
					select pl_no, rank() over(order by pl_no) nrank
					from #target_pl_no
					where assign_mm_id is null
				) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
			) y on x.pl_no = y.pl_no
		option (maxdop 1)

	-- 기존 데이터 삭제
		--delete from tbl_monitoring_target where p_status ='i' and pl_no in (
		--	select pl_no from #target_pl_no	
		--)


	-- 신규 데이터 입력
		insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, assign_mm_id, today_first_date)
		select b.pl_no, b.pl_vcode, b.pl_category, b.pl_goodsnm, comp_order, monitor_no, assign_mm_id, today_first_date
		from #target_pl_no a 
				inner join pricelist b on a.pl_no = b.pl_no
				inner join tbl_monitoring_inc_cate c on left(isnull(b.pl_category,''), 4) = c.ca_code		


		-- -----------------------------
		-- 임시// 2016-05-16~2016-05-20
		-- -----------------------------
		--insert into tmp_20160516_20160520_wookki25(pl_no, chg_type)
		--select b.pl_no, monitor_no
		--from #target_pl_no a 
		--		inner join pricelist b on a.pl_no = b.pl_no




	-- 우선순위 조정
	--	update a set a.comp_order = b.comp_order from tbl_monitoring_target a inner join tbl_monitoring_team_agg_name b  on a.chg_type = b.monitor_no









