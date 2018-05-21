/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_work
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-01-02 15:37:00.343
 *        Modify: 2018-05-03 17:23:35.47
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_work
	@agg_date smalldatetime = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-12-07
	-- 설  명 : 모니터링팀 작업로그 통계
	--			monitoring_team_agg_work.monitor_no	
	--			1 : 쇼핑몰 상품명 변경 : tbl_strange_list
	--			2 : 쇼핑몰 최저가 변경 : tbl_strange_list
	--			3 : 전일저 최저 : tbl_strange_list
	--			4 : 무료<유료 최저가 : tbl_strange_list
	--			5 : 최저가경고창 : pricelist_matching_alarm_srch
	--			6 : 옵션품절 : tbl_pricelist_option_ctu_detail
	--			7 : 옵션변경 : tbl_pricelist_option_diff_detail
	--			8 : 전일저 : pricelist_dml_log
	--			9 : 최고가경고창 : pricelist_matching_alarm_srch
	--			10 : 실시간 최저가: pricelist_dml_log
	--			11 : 옵션변경_분할상품 : tbl_pricelist_option_diff_copyplno
	-- ----------------------------------------------
	--declare @agg_date smalldatetime
	if @agg_date is null begin
		set @agg_date = cast(convert(char(10), getdate()-1, 120) as smalldatetime)
	end



	-- 입력된 데이터 삭제
	delete from tbl_monitoring_team_agg_work where agg_date = @agg_date


	-- tbl_strange_list
--	exec udp_monitoring_team_agg_work_case1 1
--	exec udp_monitoring_team_agg_work_case1 2
--	exec udp_monitoring_team_agg_work_case1 3
	/*
	-- 2014.06.26 삭제처리. 권혁준 요청. 사용안함
	-- 추후 사용할 수 있어 주석처리함.	
	exec udp_monitoring_team_agg_work_case1 4
	*/


	-- ---------------------------------------------
	-- 데이터 통합 적용시 아래 집계 방식 사용해야함
	-- 1, 2, 3, 5, 8, 12, 13, 14, 15, 16, 17,10	
	-- ---------------------------------------------
	-- 193 error_report에서 수정량 데이터 가져온다.
	--drop table #tbl_monitoring_team_agg_alba_desc

	select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
	into #tbl_monitoring_team_agg_alba_desc
	from openquery(SEARCHKEY_193, '
			select mm_id, refer_route, left(category,4) category, 0 u_cnt
			from enuridb.dbo.tbl_error_report with (nolock) 
			where 1=0
			')



	if datediff(d, @agg_date, getdate()) = 0 begin

		insert into #tbl_monitoring_team_agg_alba_desc
		select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
		from openquery(SEARCHKEY_193, '
				select mm_id, refer_route, left(category,4) category, count(*) u_cnt
				from enuridb.dbo.tbl_error_report with (nolock) 
				where pl_no >0
				and refer_route is not null
				and refer_route <> ''''
				and mm_id in (select mm_id from enuridb.dbo.mm_enuri where (mm_partcode like ''_________411'' or mm_partcode like ''_________437'' or mm_partcode like ''_________429'' or mm_partcode like ''_________464'')) 
				and regdate >=cast(convert(varchar(10), getdate()-0, 120) as datetime) 
				and regdate < cast(convert(varchar(10), getdate()+1, 120) as datetime) 
				group by mm_id, refer_route, left(category,4)
				')

			-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 1, ''

	end else begin

		insert into #tbl_monitoring_team_agg_alba_desc
		select cast(isnull(refer_route,0) as int) monitor_no, cast(category  as char(4)) category, mm_id, u_cnt
		from openquery(SEARCHKEY_193, '
				select mm_id, refer_route, left(category,4) category, count(*) u_cnt
				from enuridb.dbo.tbl_error_report with (nolock) 
				where pl_no >0
				and refer_route is not null
				and refer_route <> ''''
				and mm_id in (select mm_id from enuridb.dbo.mm_enuri where (mm_partcode like ''_________411'' or mm_partcode like ''_________437'' or mm_partcode like ''_________429'' or mm_partcode like ''_________464'')) 
				and regdate >=cast(convert(varchar(10), getdate()-1, 120) as datetime) 
				and regdate < cast(convert(varchar(10), getdate()-0, 120) as datetime) 
				group by mm_id, refer_route, left(category,4)
				')

			-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 2, ''
	end





	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt, assign_cnt)
	select monitor_no, @agg_date, category, mm_id, sum(d_cnt), sum(u_cnt), sum(a_cnt)
	from 
	(
		select monitor_no, category, mm_id, 0 d_cnt, u_cnt, 0 a_cnt  from #tbl_monitoring_team_agg_alba_desc
	
		union all

		-- 확인
		select chg_type
		,	left(pl_category , 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end) d_cnt
		,	0 u_cnt
		,	0 a_cnt
		--,	sum(case when p_status = 'u' then 1 else 0 end) u_cnt
		from tbl_monitoring_target_job_log a
		where a.p_status = 'd' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
		and	p_date>= cast(convert(char(8), @agg_date,112) as datetime) -- 처리일
		and p_date < cast(convert(char(8), @agg_date+1,112) as datetime) -- 처리일
		group by chg_type, left(pl_category,4), mm_id

		union all

		-- 할당
		select chg_type
		,	left(pl_category , 4) mcate
		,	assign_mm_id
		,	0 d_cnt
		,	0 u_cnt
		,	count(*) a_cnt
		--,	sum(case when p_status = 'u' then 1 else 0 end) u_cnt
		from tbl_monitoring_target a
		where exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
		and	regdate>= cast(convert(char(8), @agg_date,112) as datetime) -- 등록일
		and regdate< cast(convert(char(8), @agg_date+1,112) as datetime) -- 등록일
		and assign_mm_id is not null
		group by chg_type, left(pl_category,4), assign_mm_id


		union all


		-- 5. 최저가 경고창//pricelist_matching_alarm_srch // mp에서 입력
		select 5
		,	left(ca_code , 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	0 u_cnt
		,	0 a_cnt
		from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
		where a.p_status in ('u', 'd')
		and	p_date>= cast(convert(char(8), @agg_date,112) as datetime)
		and p_date < cast(convert(char(8), @agg_date+1,112) as datetime)
		and ca_code is not null
		and	alarm_flag = '2'
		group by left(ca_code , 4), mm_id

		union all

		--10. 실시간 최저가
		select 10
		,	left(a.pl_category, 4) mcate
		,	mm_id
		,	sum(case when p_status = 'd' then 1 else 0 end)
		,	0 u_cnt
		,	0 a_cnt
		from
		(
			select pl_no, max(pl_category) as pl_category
			,	max(pl_modelno) as pl_modelno
			,	max(p_status) as p_status
			,	max(mm_id) as mm_id
			from pricelist_dml_log
			where p_status in ('u', 'd')
			and	p_date>= cast(convert(char(8), @agg_date,112) as datetime)
			and p_date < cast(convert(char(8), @agg_date+1,112) as datetime)		
			and pl_category is not null
			and log_flag=2
			group by pl_no
		) a 
		inner join pricelist b on a.pl_no = b.pl_no
		group by left(a.pl_category , 4), mm_id	

	) a
	group by monitor_no, category, mm_id

			-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 3, ''

	-- 최저가 경고창 : 예외처리 
	-- 실시간 쌓이는 데이터이기 때문에 처리하는 시점에 따라서 오전에 캡처한 작업할 총량보다
	-- 작업한 총량이 많을 수 있다. 현업에서는 mp에서 한번 목록을 확인할 때 100프로 처리되므로 작업량=총량으로 처리하기로 함.
--	delete from tbl_monitoring_team_agg_target where monitor_no=5 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=5 and agg_date = @agg_date



	-- 6 : 옵션품절 : tbl_pricelist_option_ctu_detail // 대분류단위집계 2015.01.14
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 6
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(ca_code) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_ctu_detail
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and ca_code is not null
--		group by convert(char(8), regdate,112), pl_no
--	) x
--	group by mcate, mm_id



	-- 7 : 옵션변경 : tbl_pricelist_option_diff_detail  // 대분류단위집계 2015.01.14
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 7
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(ca_code) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_diff_detail
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and ca_code is not null
--		group by convert(char(8), regdate,112), pl_no
--	) x
--	group by mcate, mm_id


	-- 8. 전일저 //pricelist.pl_status='8' // mp에서 입력
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 8
--	,	@agg_date
--	,	left(a.pl_category, 2) mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from pricelist_dml_log a inner join pricelist b on a.pl_no = b.pl_no
--	where a.p_status in ('u', 'd')
--	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--	and p_date < cast(convert(char(8), getdate(),112) as datetime)
--	and a.pl_category is not null
--	and log_flag=1
--	group by left(a.pl_category , 2), mm_id

	-- 전일저 : 예외처리 
	-- 실시간 쌓이는 데이터이기 때문에 처리하는 시점에 따라서 오전에 캡처한 작업할 총량보다
	-- 작업한 총량이 많을 수 있다. 현업에서는 mp에서 한번 목록을 확인할 때 100프로 처리되므로 작업량=총량으로 처리하기로 함.
--	delete from tbl_monitoring_team_agg_target where monitor_no=8 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=8 and agg_date = @agg_date


	-- 9. 최고가 경고창//pricelist_matching_alarm_srch // mp에서 입력
	/*
	-- 2014.06.26 삭제처리. 권혁준 요청. 사용안함
	-- 추후 사용할 수 있어 주석처리함.
	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
	select 9
	,	@agg_date
	,	left(ca_code , 2)
	,	mm_id
	,	sum(case when p_status = 'd' then 1 else 0 end)
	,	sum(case when p_status = 'u' then 1 else 0 end)
	from pricelist_matching_alarm_srch a inner join pricelist b on a.pl_no = b.pl_no
	where a.p_status in ('u', 'd')
	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
	and p_date < cast(convert(char(8), getdate(),112) as datetime)
	and ca_code is not null
	and	alarm_flag = '3'
	group by left(ca_code , 2), mm_id

	-- 최고가 경고창 : 예외처리 
	-- 실시간 쌓이는 데이터이기 때문에 처리하는 시점에 따라서 오전에 캡처한 작업할 총량보다
	-- 작업한 총량이 많을 수 있다. 현업에서는 mp에서 한번 목록을 확인할 때 100프로 처리되므로 작업량=총량으로 처리하기로 함.
	delete from tbl_monitoring_team_agg_target where monitor_no=9 and agg_date=@agg_date
	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
	select monitor_no, category, delete_cnt+update_cnt, agg_date
	from tbl_monitoring_team_agg_work where monitor_no=9 and agg_date = @agg_date
	*/


	-- 10. 실시간 최저가
	--insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
	--select 10
	--,	@agg_date
	--,	left(a.pl_category, 4) mcate
	--,	mm_id
	--,	sum(case when p_status = 'd' then 1 else 0 end)
	--,	sum(case when p_status = 'u' then 1 else 0 end)
	--from
	--(
	--	select pl_no, max(pl_category) as pl_category
	--	,	max(pl_modelno) as pl_modelno
	--	,	max(p_status) as p_status
	--	,	max(mm_id) as mm_id
	--	from pricelist_dml_log
	--	where p_status in ('u', 'd')
	--	and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
	--	and p_date < cast(convert(char(8), getdate(),112) as datetime)		
	--	and pl_category is not null
	--	and log_flag=2
	--	group by pl_no
	--) a 
	--inner join pricelist b on a.pl_no = b.pl_no
	--group by left(a.pl_category , 4), mm_id	

	-- 실시간 최저가 : 예외처리 
	-- 실시간 쌓이는 데이터이기 때문에 처리하는 시점에 따라서 오전에 캡처한 작업할 총량보다
	-- 작업한 총량이 많을 수 있다. 현업에서는 mp에서 한번 목록을 확인할 때 100프로 처리되므로 작업량=총량으로 처리하기로 함.
	--delete from tbl_monitoring_team_agg_target where monitor_no=10 and agg_date=@agg_date
	--insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
	--select monitor_no, category, delete_cnt+update_cnt, agg_date
	--from tbl_monitoring_team_agg_work where monitor_no=10 and agg_date = @agg_date


	-- 11 : 옵션변경_분할상품 : tbl_pricelist_option_diff_copyplno
--	insert into tbl_monitoring_team_agg_work (monitor_no, agg_date, category, mm_id, delete_cnt, update_cnt)
--	select 11
--	,	@agg_date
--	,	mcate
--	,	mm_id
--	,	sum(case when p_status = 'd' then 1 else 0 end)
--	,	sum(case when p_status = 'u' then 1 else 0 end)
--	from (
--		select left(max(pl_category) , 4) as mcate
--		,	max(p_status) p_status
--		,	max(mm_id) as mm_id
--		from tbl_pricelist_option_diff_copyplno
--		where p_status in ('u', 'd')
--		and	p_date>= cast(convert(char(8), dateadd(dd, -1, getdate()),112) as datetime)
--		and p_date < cast(convert(char(8), getdate(),112) as datetime)
--		and pl_category is not null
--		group by convert(char(8), regdate,112), pl_goodscode
--	) x
--	group by mcate, mm_id
--	-- 옵션변경_분할상품 : 예외처리 
--	-- 요일마다 처리하는 분류가 달라서 예외처리한다. 전체 분류 처리하게되면 예외처리는 없애야한다.
--	-- 작업량=총량으로 처리하기로 함. with 박효성 2014.05.16	
--	delete from tbl_monitoring_team_agg_target where monitor_no=11 and agg_date=@agg_date
--	insert into tbl_monitoring_team_agg_target (monitor_no, category, target_cnt, agg_date)
--	select monitor_no, category, delete_cnt+update_cnt, agg_date
--	from tbl_monitoring_team_agg_work where monitor_no=11 and agg_date = @agg_date

if datediff(d, @agg_date, getdate())>= 0 begin



	-- -------------------
	-- 원본데이터 삭제
	-- -------------------
	-- 전일저, 실시간 최저가
	delete from pricelist_dml_log  -- 최근 8일 데이터만 유지
	where p_date < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as smalldatetime)
	and log_flag in (1, 2)
	and p_status in ('u', 'd')

				-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 4, ''
	-- 쇼핑몰 상품명 변경, 쇼핑몰 최저가 변경, 전일저_최저, 무료<유료 최저가
--	-- 처리된 놈들만
--	delete from tbl_strange_list -- 최근 8일 데이터만 유지
--	where sl_date < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as smalldatetime)
--	and sl_srvflag in( 'p', '8', 'f') --'c' : 6개월 보관으로 설정
--	--and p_status in ('u', 'd')  
--	-- i 까지 모두 지우게 설정 // 2014.11.25 김형준 요청
--	-- i도 mc에서 삭제하고 있었다.



	-- 데이터 통합 적용시 아래 집계 방식 사용해야함
	-- 최근 4주만 보관
	delete from tbl_monitoring_target
	where regdate < cast(convert(char(8), dateadd(ww, -4, getdate()),112) as smalldatetime)

				-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 5, ''

	delete from tbl_monitoring_target_job_log
	where regdate < cast(convert(char(8), dateadd(ww, -4, getdate()),112) as smalldatetime)


	-- 최저가 경고창, 최고가 경고창
	-- 처리된 놈들만
	delete from pricelist_matching_alarm_srch  -- 최근 30주 데이터만 유지
	where regdate < cast(convert(char(8), dateadd(ww, -30, getdate()),112) as smalldatetime)
	and isnull(p_date, regdate) < cast(convert(char(8), dateadd(ww, -30, getdate()),112) as smalldatetime)
	and alarm_flag in ('2','3')
	and p_status in ('u', 'd')

				-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 6, ''

	-- 옵션품절 - 옵션내용있는 것.
	-- 처리유무 상관 없이
	delete from tbl_pricelist_option_ctu_detail-- 최근 8일 데이터만 유지
	where regdate < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as datetime)


				-- 모니터링
			insert into tbl_dba_udp_monitor(udp_name,step,memo)
			select 'udp_monitoring_team_agg_work', 7, ''

	-- 옵션변경
	-- 처리유무 상관 없이
	delete from tbl_pricelist_option_diff_detail-- 최근 8일 데이터만 유지
	where regdate < cast(convert(char(8), dateadd(ww, -1, getdate()),112) as datetime)

end



