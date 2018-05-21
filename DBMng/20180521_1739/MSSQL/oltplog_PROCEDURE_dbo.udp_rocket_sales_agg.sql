/* *************************************************************************
 * NAME : dbo.udp_rocket_sales_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:11:26.76
 *        Modify: 2018-05-15 15:11:26.76
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_rocket_sales_agg
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-05-27
	-- 설  명 : 판매량 급상품
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2013.07.09		wookki25		오남석 - 3개월판매량 300개 이상만 노출
	2013.07.12		wookki25		오남석 - 패션 분류(14)만 3개월 판매량이 100개인 상품들로 선정
	2013.07.12		wookki25		오남석 - 제외분류 설정 : 0706, 040207, 0407
	2013.09.23		wooki25			오남석 - 중분류별 최대 2개만 노출되게 해주세요
	2013.10.18		wookki25		오남석 - 제외분류 : 1640 성인용품
	*/
	declare @agg_date smalldatetime
	declare @mcate varchar(4)
	declare @limit_od_cnt int
	set @agg_date =  convert(varchar(10), getdate(), 112)

	-- 결과저장 테이블
	create table #top_50_popular_goods
	(
		aggdate datetime
	,	g_modelno int
	,	point int
	,	mcate char(4)
	,	one_day_cnt int
	,	avg_day_cnt numeric(10,2)
	,	sale_cnt int
	,	c_code varchar(12)
	)
	-- top 5 결과 테이블
	create table #top7_categroup(
		rank int identity(1,1)
	,	modelno int not null
	,	cate_group char(1) not null
	,	one_day_cnt int
	,	avg_day_cnt numeric(10,2)
	,	sale_cnt int
	,	c_code varchar(12)
	)
	
	-- 특정분류 예외처리
	create table #extra_cate (modelno int not null)

	-- 서비스중인 중분류
	select cm_lcode+cm_mcode as mcate, 0 as is_ok, cast(300 as int) limit_od_cnt
	into #mcate
	from eloc188.eloc2001.dbo.c_mcate  where cm_seqno > 0

	update #mcate
	set limit_od_cnt = 100
	where mcate like '14%' -- 14분류는 3개월 판매량이 100개 이상

	
	-- 필요없는 분류 삭제
	delete #mcate where mcate in ('0706','0407','1640')
	update #mcate set is_ok = 1 where mcate = '0402' -- 040207 분류 삭제때문에 예외처리하려고 미리 완료 처리



	-- 중분류별 top 2위 입력
	select top 1 @mcate = mcate, @limit_od_cnt = limit_od_cnt from #mcate where is_ok = 0 order by mcate
	while @@rowcount>0 begin
		--select top 50 @agg_date, g_modelno, gpa_po_point from tbl_goods_popular_acc where gpa_date = @agg_date and g_category like @mcate+'%' order by gpa_po_point desc
		-- 가중치 적용 후 인기순위
		insert into #top_50_popular_goods(aggdate, g_modelno, point, mcate, sale_cnt, c_code)
		select top 2 @agg_date, gp_modelno, gp_sum_point, @mcate, gp_oda_vcnt, gp_category from goods_popular 
		where gp_category like @mcate+'%' 
		and gp_oda_vcnt >= @limit_od_cnt -- 사이트에 보여지는 판매량이 300개 이상인 상품만 대상으로 50개
		order by gp_sum_point desc

		update #mcate set is_ok = 1 where mcate = @mcate

		select top 1 @mcate = mcate, @limit_od_cnt = limit_od_cnt from #mcate where is_ok = 0 order by mcate
	end

	-- 중분류별 top 50위 입력 : 0402분류 예외처리 = 040207 삭제
	select top 1 @mcate = mcate, @limit_od_cnt = limit_od_cnt from #mcate where mcate='0402' order by mcate
	while @@rowcount>0 begin
		--select top 50 @agg_date, g_modelno, gpa_po_point from tbl_goods_popular_acc where gpa_date = @agg_date and g_category like @mcate+'%' order by gpa_po_point desc
		-- 가중치 적용 후 인기순위
		insert into #top_50_popular_goods(aggdate, g_modelno, point, mcate, sale_cnt, c_code)
		select top 2 @agg_date, gp_modelno, gp_sum_point, @mcate, gp_oda_vcnt, gp_category from goods_popular 
		where gp_category like @mcate+'%' and gp_category not like '040207%'
		and gp_oda_vcnt >= @limit_od_cnt -- 사이트에 보여지는 판매량이 300개 이상인 상품만 대상으로 50개
		order by gp_sum_point desc

		update #mcate set is_ok = 1 where mcate = @mcate

		select top 1 @mcate = mcate, @limit_od_cnt = limit_od_cnt from #mcate where is_ok = 0 order by mcate
	end




	-- 당일기준 전전일 주문데이터 없는 경우 입력제외
	-- 사이트에서는 가장 최근 데이터를 보이도록 처리 // 2013.07.01 오남석.
	if exists(select top 1 1 from tbl_orderdata where od_date >= @agg_date-2 and od_date <@agg_date-1 ) begin
		select 1
	end else begin
		return
	end

	-- 이전 전일 vs 이전 3일 평균 주문데이터 비교
	update a
	set one_day_cnt = b.one_day_cnt
	, avg_day_cnt = b.avg_day_cnt
	from #top_50_popular_goods a
		inner join 
	(
		select a.g_modelno
		,	one_day_cnt = 	sum(case when od_date >= @agg_date-2 then 1 else 0 end)
		,	avg_day_cnt = sum(case when od_date < @agg_date-2 then 1 else 0 end)/3.0
		from #top_50_popular_goods a 
				inner join 
			tbl_orderdata b 
		on a.g_modelno = b.pl_modelno
		where od_date >= @agg_date-5 and od_date <@agg_date-1
		group by a.g_modelno, a.mcate
	) b
	on a.g_modelno = b.g_modelno



	/*
	 개수 예외처리
	*리빙: 기저귀(1007), 분유(1005), 물티슈(1020)는 1개상품만 노출
	*패션: 화장품(08)은 최대 3개 노출 
	*컴퓨터 : 0702 : 외장하드, NAS, 0709 : 공유기, 네트워크장비 개만 노출 // 2013.08.14
	*/

	insert into #extra_cate
	select top 1 g_modelno from #top_50_popular_goods where mcate like '1007' order by (one_day_cnt - avg_day_cnt) desc

	insert into #extra_cate
	select top 1 g_modelno from #top_50_popular_goods where mcate like '1005' order by (one_day_cnt - avg_day_cnt) desc	

	insert into #extra_cate
	select top 1 g_modelno from #top_50_popular_goods where mcate like '1020' order by (one_day_cnt - avg_day_cnt) desc	

	insert into #extra_cate
	select top 3 g_modelno from #top_50_popular_goods where mcate like '08%' order by (one_day_cnt - avg_day_cnt) desc	

	insert into #extra_cate
	select top 1 g_modelno from #top_50_popular_goods where mcate like '0702' order by (one_day_cnt - avg_day_cnt) desc	

	insert into #extra_cate
	select top 1 g_modelno from #top_50_popular_goods where mcate like '0709' order by (one_day_cnt - avg_day_cnt) desc	

	delete #top_50_popular_goods 
	where (mcate like '1007' or mcate like '1005' or mcate like '1020' or mcate like '08%' or mcate like '0702' or mcate like '0709') 
	and g_modelno not in ( select modelno from #extra_cate )


	-- 그룹별 top 5개 지정
	/*
　	  ①가전: 02, 03, 04, 05, 06, 07, 21
　	  ②레저: 09
　	  ③유아리빙: 08,10,12,15,16, 18 
　	  ④패션: 14

	1. 가전: 02, 03, 05, 06
	2. 레저: 09, 21　	  
	3. 리빙: 10,12,15,16, 18 
	4. 패션: 14, 08
	5. 컴퓨터: 04, 07
	*/
	insert into #top7_categroup(modelno, cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code)
	select top 7 g_modelno, 'A' cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code  from #top_50_popular_goods where mcate like '0[2356]%' and one_day_cnt is not null order by (one_day_cnt - avg_day_cnt) desc

	DBCC CHECKIDENT (#top7_categroup, reseed,0)
	insert into #top7_categroup(modelno, cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code)
	select top 7 g_modelno, 'B' cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code from #top_50_popular_goods where (mcate like '09%' or mcate like '21%') and one_day_cnt is not null  order by (one_day_cnt - avg_day_cnt)   desc

	DBCC CHECKIDENT (#top7_categroup, reseed,0)
	insert into #top7_categroup(modelno, cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code)
	select top 7 g_modelno, 'C' cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code from #top_50_popular_goods where (mcate like '1[02568]%') and one_day_cnt is not null order by (one_day_cnt - avg_day_cnt) desc

	DBCC CHECKIDENT (#top7_categroup, reseed,0)
	insert into #top7_categroup(modelno, cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code)
	select top 7 g_modelno, 'D' cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code from #top_50_popular_goods where (mcate like '14%' or mcate like '08%') and one_day_cnt is not null order by (one_day_cnt - avg_day_cnt) desc

	DBCC CHECKIDENT (#top7_categroup, reseed,0)
	insert into #top7_categroup(modelno, cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code)
	select top 7 g_modelno, 'E' cate_group, one_day_cnt, avg_day_cnt, sale_cnt, c_code from #top_50_popular_goods where (mcate like '0[47]%') and one_day_cnt is not null order by (one_day_cnt - avg_day_cnt) desc

	-- 최종결과
	insert into tbl_rocket_sales(g_modelno, cate_group, rank, one_day_cnt, avg_day_cnt, aggdate, sale_cnt, c_code)
	select modelno, cate_group, rank, one_day_cnt, avg_day_cnt, @agg_date, sale_cnt, c_code from #top7_categroup 

	-- 모델번호
	update a
	set modelnm = g_modelnm
	from tbl_rocket_sales a inner join analstore.dbo.goods b on a. g_modelno = b.g_modelno
	where a.aggdate = @agg_date

	-- 중분류명 입히기..
	update tbl_rocket_sales
	set c_name = (select top 1 cm_name from simpledb.dbo.cate where category = c_code)
	where aggdate = @agg_date

	-- 최근 한달 데이터만 유지
	delete from tbl_rocket_sales where aggdate < getdate() - 90








