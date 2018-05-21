/* *************************************************************************
 * NAME : dbo.udp_price_shop_popular_v2_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-09-30 15:38:05.46
 *        Modify: 2018-05-03 17:23:36.113
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_price_shop_popular_v2_agg_ins
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-09-30
	-- 설  명 : 쇼핑몰 인기상품 일별 총량/작업량 통계
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	-- 작업내역 업데이트
	/* 
	-- 중복포함 버전
	select	x.shop_code, y.pl_category, y.pl_modelno
	into	#tmp_worker
	from	tbl_price_shop_popular_v2 x 
				left outer join 
			pricelist y on x.goodscode = y.pl_goodscode and checksum(x.goodscode) = y.pl_goodscode_cs and x.shop_code = y.pl_vcode
	option (maxdop 1)
    */


    -- 중복제거 버전
	select distinct shop_code, goodscode into #tmp_worker from tbl_price_shop_popular_v2
	alter table #tmp_worker add pl_category varchar(12) default('00')
	alter table #tmp_worker add pl_modelno int default(0)
	alter table #tmp_worker add pl_srvflag char(1) default('O')

	update #tmp_worker
	set pl_modelno = y.pl_modelno
	,	pl_category = y.pl_category
	,	pl_srvflag =  y.pl_srvflag
	from #tmp_worker x inner join pricelist y on x.goodscode = y.pl_goodscode and checksum(x.goodscode) = y.pl_goodscode_cs and x.shop_code = y.pl_vcode
	option (maxdop 1)
    

-- select top 10 * from tbl_price_shop_popular_v2
-- select top 10 * from tbl_price_shop_popular_v2_agg

	insert into tbl_price_shop_popular_v2_agg (shop_vcode, cate, sum_cnt, match, not_match_zero, not_match_minus, not_match_srv_O)
	-- 9x 대분류이하 통계에서 제외
	select	shop_code
	, left(pl_category,4) mcate
	, count(*) cnt
	, sum(case when pl_modelno>0 then 1 else 0 end) match 
	, sum(case when pl_modelno=0 and pl_srvflag<>'O' then 1 else 0 end) not_match_zero
	, sum(case when pl_modelno<0 and pl_srvflag<>'O' then 1 else 0 end) not_match_minus
	, sum(case when pl_modelno<=0 and pl_srvflag='O' then 1 else 0 end) not_match_srv_O
	from	#tmp_worker 
	where	len(pl_category) >= 2  and pl_category not like '9%' and pl_category not like '147[123]%'
	group by shop_code, left(pl_category,4) 

	union all

	-- 1471, 1472, 1473 분류는 분류코드가 10자리일 때 매칭으로 본다.
	select	a.shop_code
	, left(pl_category,4) mcate
	, count(*) cnt
	, sum(case when len(isnull(ca_code, pl_category)) = 10 or pl_modelno>0 then 1 else 0 end) match 
	, sum(case when len(isnull(ca_code, pl_category)) <>10 and pl_modelno=0 and pl_srvflag<>'O' then 1 else 0 end) not_match_zero
	, sum(case when len(isnull(ca_code, pl_category)) <>10 and pl_modelno<0 and pl_srvflag<>'O' then 1 else 0 end) not_match_minus
	, sum(case when len(isnull(ca_code, pl_category)) <>10 and pl_modelno<=0 and pl_srvflag='O' then 1 else 0 end) not_match_srv_O
	from	#tmp_worker a left outer join TBL_PRICE_SHOP_POPULAR b on a.shop_code = b.shop_code and a.goodscode=b.goodscode and b.status='f'
	where	len(pl_category) >= 2  and pl_category like '147[123]%'
	group by a.shop_code, left(pl_category,4)


	-- 분류명입력
	update a 
	set cl_name = l.cl_name
	,	cm_name = m.cm_name 
	from tbl_price_shop_popular_v2_agg a 
			left outer join c_lcate l on left(cate, 2) = cl_lcode
			left outer join c_mcate m on left(cate, 4) = cm_lcode+cm_mcode 
	where agg_date >= cast(convert(varchar(10), getdate(), 120) as smalldatetime)

	-- 최근 1주일 데이터만 유지
	delete from tbl_price_shop_popular_v2_agg where agg_date < getdate() - 9
