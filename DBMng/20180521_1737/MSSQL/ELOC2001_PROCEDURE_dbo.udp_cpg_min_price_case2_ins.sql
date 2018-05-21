/* *************************************************************************
 * NAME : dbo.udp_cpg_min_price_case2_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-11-17 14:32:29.32
 *        Modify: 2018-05-03 17:23:35.893
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE proc udp_cpg_min_price_case2_ins
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.07.11
	-- 설   명 : 주요 업체별 최저가 개수
	--		동일 업체에 최저가 상품코드가 여러개인 경우 1개만 카운팅
	--		여러 업체에 동일 최저가 있는 경우 각 업체별 1개씩 카운팅 
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	select *
	into #target
	from 
	(
		--where cateflag='0' and mallcnt>0 and popular>0
		select left(category,4) mcate, modelno, ROW_NUMBER() over (partition by left(category, 4) order by mcate_group_rank asc) rnum
		from tbl_mcate_popular_rank  
		where mcate_group_rank <=60
	) a
	where rnum <= 60
	option (maxdop 1)

	declare @all_model_cnt int  = @@rowcount

	insert into TBL_CPG_MIN_PRICE_CNT_CASE2(shop_vcode, mcate, min_cnt, base_model_cnt)
	select pl_vcode, LEFT(pl_category, 4), count(distinct  pl_modelno), @all_model_cnt
	from
	(
		select pl_category, pl_modelno, pl_no, pl_vcode, rank() over(partition by modelno order by pl_price asc) min_price_rank
		from pricelist  with (readuncommitted) inner join #target on pl_modelno = modelno
		where pl_modelno>0 and pl_status in ('0','1','2','8') and pl_srvflag in ('0','r','l','b','s') and option_flag2 ='0' 
	) a
	where min_price_rank = 1 and pl_vcode in (5910, 536, 4027, 6508, 6641
	, 55, 75, 7692, 663, 49, 47
	)
	group by pl_vcode, LEFT(pl_category, 4)
	option (maxdop 1)
end


