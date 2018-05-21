/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step2_ins_attribute
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-07 16:57:13.443
 *        Modify: 2018-05-03 17:23:34.787
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step2_ins_attribute
as
begin	
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.03
	-- 설  명 : 모니터링 데이터 수집.GSShop 속성 모니터링
	--			tbl_external_send_target_plno : 새벽 3시 이전 당일 발송 데이터 입력.
	--				L 입력 담당 : 김형준
	--			스케쥴링은 그 이후에 돌아야 함.
	-- ----------------------------------------------
	-- 수  정
	-- ----------------------------------------------
	-- 2017.03.28	wookki25		조건추가 : enuri01에 분배된 모델은 제외 
	-- ----------------------------------------------

	create table #target_pl_no(
		shop_code int
	,	pl_no bigint
	,	modelno int
	,	assign_mm_id varchar(12)
	,	comp_order smallint
	,	monitor_no smallint
	,	today_first_date datetime default(getdate())
	)



	-- 당일 발송 데이터를 소분류별 랭킹으로 전체 top 1000개 모델
	insert into #target_pl_no(shop_code, modelno)
	--select top 1000 shop_code, modelno--, b.g_category  -- 1000개로 재조정 http://58.234.199.100/redmine/issues/24063
	--select top 400 shop_code, modelno -- 400개로 조정 http://58.234.199.100/redmine/issues/23912
	select top 400 shop_code, modelno--, b.g_category  -- 1000개로 재조정 http://58.234.199.100/redmine/issues/24219
	from 
	(
		-- 당일 발송 모델 (TBL_EXTERNAL_SEND_TARGET_MODEL)
		-- 참조 : UDP_GOODS_EXTERNAL_TARGET
		select shop_code, modelno, category
		, rank() over (partition by left(category,6) order by newid()) rnk -- 소분류별 랜덤으로 랭킹 정한다.
		from tbl_external_send_target_model
		where yyyymmdd= convert(char(8), getdate()-1, 112) and shop_code = 7871
		and MODELNO not in (
		
			-- enuri01에 분배된 모델은 제외
			select pl_modelno 			
			from tbl_monitoring_target a inner join pricelist b on a.pl_no = b.pl_no 
			where assign_mm_id in ( 'enuri01', 'banchick' )
			and p_status = 'i'
		
		)

	) a
	order by rnk
	option (maxdop 1)

	-- 검증 : 소분류별 개수
	-- select left(category,6), count(*)  from #aaa group by left(category,6)


	-- pricelist 정보 입력
	;with cte_attr_shop(shop_group, shop_code) as (
		-- GSShop 속성
		select 7871, 7871  --union all
		--select 7871,   75  -- http://58.234.199.100/redmine/issues/21443

		-- CJ몰 속성

	)
	update #target_pl_no
	set pl_no = (
		-- 아무 조건 없이 1개만
		select top 1 pl_no 
		from pricelist  with (index = NCL_PRICELIST_NEW_05)
		where pl_modelno =  modelno 
		and pl_vcode in (
			select shop_code from cte_attr_shop where shop_group = #target_pl_no.shop_code
		)
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



-- 분배(= 할당)
/*
	select identity(int, 1, 1) seqno, mm_id
	into #mm_id
	from
	(
		select distinct cast(substring(vals, s, e-s) as varchar(12)) as mm_id
		from 
		(  
			select  min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
			from  (select top 1 replace(assign_mm_id_add,' ','') vals from tbl_mc_manager_set) a  
			--from  (select 'banchick' vals ) a -- http://58.234.199.100/redmine/issues/23912
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
*/

	-- http://58.234.199.100/redmine/issues/24219
	-- http://58.234.199.100/redmine/issues/24618
	update x
	set assign_mm_id = 'oh26222' 
	from #target_pl_no x
	option (maxdop 1)

-- 신규 데이터 입력
	insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, assign_mm_id, today_first_date)
	select b.pl_no, b.pl_vcode, b.pl_category, b.pl_goodsnm, comp_order, monitor_no, assign_mm_id, today_first_date
	from #target_pl_no a 
			inner join pricelist b on a.pl_no = b.pl_no
End














