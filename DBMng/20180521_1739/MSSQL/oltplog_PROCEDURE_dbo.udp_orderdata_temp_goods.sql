/* *************************************************************************
 * NAME : dbo.udp_orderdata_temp_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:07:34.277
 *        Modify: 2018-05-15 15:07:34.277
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_orderdata_temp_goods
	@category varchar(13)
,	@sdate smalldatetime	
,	@edate smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-12-09
	-- 설  명 : 임시상품 주문 모니터링
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
		where g_category like @category
		and g_imgchk='8' AND g_partcode = '0' 
	) a on pl_modelno = g_modelno
	where od_date >= @sdate
	and od_date < dateadd(d, 0, @edate)
	group by g_modelno
	order by yyyymm, total_price desc


