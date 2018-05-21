/* *************************************************************************
 * NAME : dbo.udp_goods_reference_monitor_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-10-08 16:21:17.857
 *        Modify: 2018-05-03 17:23:35.477
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC udp_goods_reference_monitor_sel
	@cate varchar(6)
,	@group_flag1 varchar(1)
,	@group_flag2 varchar(1)
,	@model_cnt_limit int
,	@url_flag varchar(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012.10.08
	-- 설  명 : 상세문의 모니터링
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select g_category
	,	g_factory
	,	gref_no
	,	goods_cnt
	,	gref_telnm
	,	gref_tel
	,	gref_url1
	,	gref_url1nm 
	,	gref_url2
	,	gref_url2nm	
	,	group_flag1
	,	group_flag2
	,	regdate
	from 
		(
			select  g_refid, g_factory
			, left(g_category, len(@cate)) as g_category
			, sum(goods_cnt) as goods_cnt
			, max(group_flag1) as group_flag1
			, max(group_flag2) as group_flag2
			, max(regdate) as regdate
			from goods_reference_monitor 
			where  g_category like @cate+'%'
			group by g_refid, g_factory, left(g_category, len(@cate))
		) a 
			inner join 
		goods_reference b 
			on a.g_refid = b.gref_no 
	where group_flag1 like @group_flag1+'%'
	and group_flag2 like @group_flag2+'%'
	and goods_cnt <= @model_cnt_limit
	and isnull(isnull(gref_url1,'')+isnull(gref_url2,''), '') like @url_flag	
	order by g_factory	
