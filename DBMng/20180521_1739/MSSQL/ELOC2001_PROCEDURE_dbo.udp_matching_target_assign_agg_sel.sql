/* *************************************************************************
 * NAME : dbo.udp_matching_target_assign_agg_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-03 15:42:10.48
 *        Modify: 2018-05-03 17:23:34.94
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_matching_target_assign_agg_sel
	@mm_id	varchar(12)
,	@sdate	smalldatetime
,	@edate	smalldatetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.06.03
	-- 설  명 : 매칭 할당 집계
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select mm_id, isnull(category,'합계') as category, round(goods_cnt/sum_goods_cnt*100,0), goods_cnt, round(price_cnt/sum_price_cnt*100,0), price_cnt
	, (select top 1 cm_name from c_mcate where cm_lcode+cm_mcode = category) as cm_name
	from
	(	
		select mm_id, isnull(category,'합계') as category,  sum(goods_cnt) goods_cnt, sum(price_cnt) price_cnt
		from tbl_matching_target_assign_agg
		where mm_id = @mm_id
		and regdate between @sdate and @edate
		group by mm_id, category
		with rollup
		having mm_id is not null
	) tmp_id_sum  cross join (
		select sum(goods_cnt)*1.0 as sum_goods_cnt, sum(price_cnt)*1.0 as sum_price_cnt
		from tbl_matching_target_assign_agg 
		where regdate between @sdate and @edate	

	) tmp_total_sum 

	order by category
