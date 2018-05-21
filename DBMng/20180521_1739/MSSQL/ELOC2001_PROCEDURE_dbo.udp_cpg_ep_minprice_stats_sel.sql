/* *************************************************************************
 * NAME : dbo.udp_cpg_ep_minprice_stats_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-03-09 14:13:04.327
 *        Modify: 2018-05-03 17:23:34.933
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cpg_ep_minprice_stats_sel
	@sdate date
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작 성 자: wookki25 / 2018.03.09
	-- 설    명: ep_minprice_stats sel
	-- 참    고: 쿼리 작성은 김형준 수석.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	select shop_code [쇼핑몰]
	, category
	, isnull(cl_name, '') + case when ltrim(rtrim(isnull(cm_name, ''))) = '' then '' else ' > ' + isnull(cm_name, '') end [중분류]
	, total_cnt [전체 상품수]
	, match_cnt [가격비교 상품수]
	, min_cnt [최저가 상품수]
	, non_match_cnt [일반 상품수] 
	from ep_minprice_stats
	inner join c_lcate on substring(category, 1, 2) = cl_lcode
	left join c_mcate on substring(category, 1, 2) = cm_lcode and substring(category, 3, 2) = cm_mcode
	where yyyymmdd = @sdate
	order by yyyymmdd, shop_code, category
	option (maxdop 1)
end 