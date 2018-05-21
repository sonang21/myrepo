/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step2_ins_attribute_contract
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-27 16:33:09.913
 *        Modify: 2018-05-03 17:23:34.463
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_step2_ins_attribute_contract
as
begin	
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.03
	-- 설  명 : 모니터링 데이터 수집.GSShop 속성 모니터링.도급직원
	--			tbl_external_send_target_plno : 새벽 3시 이전 당일 발송 데이터 입력.
	--				L 입력 담당 : 김형준
	--			스케쥴링은 그 이후에 돌아야 함.
	-- ----------------------------------------------
	-- 수  정
	-- ----------------------------------------------
	-- 2017.05.12	wookki25	GS 속성 모니터링 데이터생성 로직 추가 및 변경
	--									http://58.234.199.100/redmine/issues/22339
	-- ----------------------------------------------

	--drop table #target_pl_no
	create table #target_pl_no(
		shop_code int
	,	pl_no bigint
	,	modelno int
	,	assign_mm_id varchar(12)
	,	comp_order smallint
	,	monitor_no smallint
	,	today_first_date datetime default(getdate())
	,	job_id varchar(12)
	,	rnk int
	)



	-- 당일 발송 데이터를 소분류별 랭킹으로 전체 top 1000개 모델
	insert into #target_pl_no(shop_code, modelno, job_id, rnk)
	select shop_code, modelno, job_id, rnk
	from 
	(
			-- 작업 로그만 찾는다.
			select 7871 shop_code, modelno, job_id
			, rank() over (partition by job_id  order by newid()) rnk -- 아이디별 랜덤 17개
			from 
			(
					select modelno, max(mm_id) job_id 
					from 
					(
						--select jp_modelno modelno, jp_id  job_id from logdb.dbo.job_pricelist_old where  jp_id like 'enuri[01][123456789]' and jp_modelno > 0
						--union
						--select jg_modelno, jg_id from logdb.dbo.job_goods_old where jg_id like 'enuri[01][123456789]' and jg_modelno > 0
						--union

						-- GS 속성 작업용 별도 로그 :  http://58.234.199.100/redmine/issues/22097
						select modelno, mm_id from tbl_external_work_model where shop_code = 7871 and mm_id like 'enuri[01][123456789]' and regdate > cast(cast(getdate()-1 as date) as datetime) 

						union all

						-- 속성은 작업로그가 아니고, 마지막 작업자만 알 수 있다.
						select g_modelno, upd_oprt 
						from goods_catalog_attribute a where upd_oprt like 'enuri[01][123456789]' and upd_date > cast(cast(getdate()-1 as date) as datetime) and g_modelno > 0
						and exists (select attribute_id from tbl_external_attribute b where a.attribute_id = b.attribute_id and shop_code = 7871 ) -- 주요속성 여부 확인
					) a
					group by modelno

			) a
	) a
	--where rnk <= case when DATEPART(dw, getdate()) = 5 then 37 else 17 end ---- 목요일 예외처리 // 2017.05.12
	--where rnk <= 57 ---- 매일 // http://58.234.199.100/redmine/issues/23912
	--where rnk <= 17 ---- 매일 // http://58.234.199.100/redmine/issues/24063
	where rnk <= 65 ---- 매일 // http://58.234.199.100/redmine/issues/24219
	option (maxdop 1)


	-- 검증 : 소분류별 개수
	-- select job_id, count(*)  from #target_pl_no group by left(job_id,6)


	update #target_pl_no
	set pl_no = (
		-- 아무 조건 없이 1개만
		select top 1 pl_no 
		from pricelist with (index = NCL_PRICELIST_NEW_05)
		where pl_modelno =  modelno 
		and pl_vcode = 7871
		--order by newid()
	) 

	-- pl_no 없는 경우 삭제처리
	delete from #target_pl_no where pl_no is null


	-- 우선순위 설정
	update a
	set comp_order = b.comp_order
	, monitor_no = b.monitor_no 
	from #target_pl_no a cross join (select comp_order, monitor_no from tbl_monitoring_team_agg_name where monitor_no=25) b 



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

	update x	 set assign_mm_id = 'enuri01'	from #target_pl_no x where assign_mm_id is null and rnk <= 17


	--update x	 set assign_mm_id = 'j9ken'	from #target_pl_no x where assign_mm_id is null and rnk >= 18  and DATEPART(dw, getdate()) = 5 -- 목요일 예외처리 // 2017.05.12
	-- 분배(= 할당) //http://58.234.199.100/redmine/issues/23912
	-- 삭제 // http://58.234.199.100/redmine/issues/24063
	/*
		select identity(int, 1, 1) seqno, mm_id
		into #mm_id
		from
		(
			select distinct cast(substring(vals, s, e-s) as varchar(12)) as mm_id
			from 
			(  
				select  min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
				from (select top 1 replace('mjkim8713,lw_wizdes',' ','') vals from tbl_mc_manager_set) a  
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
					where assign_mm_id is null and rnk >= 18
				) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
			) y on x.pl_no = y.pl_no
		where assign_mm_id is null and rnk >= 18
		option (maxdop 1)

	*/

	-- http://58.234.199.100/redmine/issues/24219
	-- http://58.234.199.100/redmine/issues/24618
	update x
	set assign_mm_id = 'naya3327'
	from #target_pl_no x
	where assign_mm_id is null and rnk >= 18
	option (maxdop 1)


-- 신규 데이터 입력
	insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, assign_mm_id, today_first_date)
	select b.pl_no, b.pl_vcode, b.pl_category, b.pl_goodsnm, comp_order, monitor_no, assign_mm_id, today_first_date
	from #target_pl_no a 
			inner join pricelist b on a.pl_no = b.pl_no
	where assign_mm_id is not null
End

