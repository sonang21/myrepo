/* *************************************************************************
 * NAME : dbo.UDP_EXCEL_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:31:40.96
 *        Modify: 2018-05-13 19:31:40.96
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_EXCEL_1
	@sdate smalldatetime
,	@edate smalldatetime
AS begin
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 20161122
	-- 설  명 : 유사상품.gmv
	-- 실  행 : 
	-- ----------------------------------------------------------------------------------

	-- ------------------
	-- 유사상품 기준 분류코드
	-- ------------------
	-- drop table #tmp_cate
	select * 
	into #tmp_cate
	from openquery(oradb_144, 'select ca_code from TBL_GRMATCHING_AUTO_MODEL_CATE ')

	-- ------------------
	-- 빌트온 모델
	-- ------------------
	begin
		-- drop table #auto_b_modelno
		select jg_modelno, left(jg_category,4) jg_category
		into #auto_b_modelno
		from JOB_goods where jg_id = 'ENURI_AUTO_B' and jg_flag ='n'
		and jg_date>= '2016-11-01'-- and jg_date < '2017-02-03'

		-- 유사상품 기준 분류에 없는 모델은 삭제
		delete from a
		--select	* 
		from	#auto_b_modelno a 
					left outer join 
				#tmp_cate b on a.jg_category = b.ca_code
		where b.ca_code is null
	end

	

	-- ------------------
	-- 주문관련 집계
	-- ------------------	
	-- pc.체결1
	-- drop table #tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	--, sum(a.od_cnt*a.od_price*sign(isnull(b.jg_modelno,0))) as built_on_total_price
	--, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)*sign(isnull(b.jg_modelno,0))) as auto_model_built_on_total_price	
	into	#tmp_gmv 
	from	tbl_orderdata a-- left outer join #auto_b_modelno b on a.pl_modelno = b.jg_modelno
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	and		shop_vcode not in (55, 536, 5910, 4027)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)

	-- pc.체결3
	insert into	#tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt
	, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	from	tbl_orderdata_gmarket_auction a
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	and		shop_vcode in (55, 536, 5910, 4027)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)

	-- 모바일.체결1
	insert into	#tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt
	, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	from	tbl_orderdata_ord_mobile a
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)


	-- ------------------
	--	결과파일
	-- ------------------
	-- 집계.모델별
	select yyyymmdd, mcate, PL_MODELNO, g_modelnm, od_cnt, auto_model_total_price
	, convert(varchar(10), getdate(), 120) as '파일생성일'
	from 
	(
		select yyyymmdd, mcate, pl_modelno, sum(od_cnt) od_cnt
		, sum(auto_model_total_price) auto_model_total_price		
		from #tmp_gmv
		where auto_model_total_price>0
		group by mcate, yyyymmdd, pl_modelno
	) a  inner join analstore.dbo.goods on pl_modelno = g_modelno
	
	

	-- 집계.중분류별
	select mcate
	, sum(total_price)								-- 유사분류.전체주문액		
	, sum(auto_model_total_price)					-- 유사분류.유사상품.전체주문액
	, sum(total_price*sign(isnull(b.jg_modelno,0)))	-- 유사분류.빌트온전체
	, cast(getdate() as date) as '파일생성일'
	from 
	(
		select left(mcate,4) mcate
			, sum(total_price) as total_price							
			, sum(auto_model_total_price)	auto_model_total_price					
			, pl_modelno
		from #tmp_gmv
		group by left(mcate,4), pl_modelno
	) a left outer join #auto_b_modelno b on a.pl_modelno = b.jg_modelno
	group by mcate
	order by mcate
end



