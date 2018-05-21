/* *************************************************************************
 * NAME : dbo.udp_price_shop_popular_v2_agg_sel_lcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-07-06 13:25:07.65
 *        Modify: 2018-05-03 17:23:35.36
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_price_shop_popular_v2_agg_sel_lcate
	@cate varchar(4) 
,	@shop_vcode int
,	@sdate smalldatetime
,	@edate smalldatetime
,	@hour smallint
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

	select max(cl_name) as cate_name, left(cate,2) as cate, sum(sum_cnt) as sum_cnt, sum(match) as match
	,	case when isnull(sum(sum_cnt),0) =0 then 0 else (isnull(sum(match),0)*1.0/isnull(sum(sum_cnt),0)*1.0)*100.0 end as match_ratio
	from tbl_price_shop_popular_v2_agg
	where cate like @cate+'%' and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour
	group by left(cate,2)
	order by cate asc



	select case when isnull(sum(sum_cnt),0) =0 then 0 else (isnull(sum(match),0)*1.0/isnull(sum(sum_cnt),0)*1.0)*100.0 end as match_ratio, isnull(sum(sum_cnt),0), isnull(sum(match),0)
	from tbl_price_shop_popular_v2_agg
	where cate like @cate+'%' and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour
