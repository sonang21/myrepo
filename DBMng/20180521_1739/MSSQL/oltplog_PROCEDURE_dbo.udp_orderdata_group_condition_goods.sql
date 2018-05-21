/* *************************************************************************
 * NAME : dbo.udp_orderdata_group_condition_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 16:33:07.903
 *        Modify: 2018-05-14 16:33:07.903
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_orderdata_group_condition_goods
	@condition varchar(30)
,	@category varchar(13)
,	@sdate smalldatetime	
,	@edate smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-12-09
	-- 설  명 : 그룹조건(리퍼,전시상품)상품 주문 모니터링
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select	convert(char(6), max(od_date), 112) as yyyymm
	,		g_modelno
	,		max(g_modelnm) modelnm
	,		max(g_category) category
	,		count(*) total_cnt
	,		sum(od_cnt) total_amount
	,		sum(od_cnt*od_price) total_price
	from	tbl_orderdata inner join (
		select g_modelnm, g_category, g_modelno 
		from analstore.dbo.goods 
		where g_modelnm like @condition
		and g_category like @category
	) a on pl_modelno = g_modelno
	where od_date >= @sdate
	and od_date < dateadd(d, 1, @edate)
	group by g_modelno
	order by yyyymm, total_price desc

