/* *************************************************************************
 * NAME : dbo.goods_ref_mobile_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-06 14:06:35.25
 *        Modify: 2018-05-03 17:23:34.683
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc goods_ref_mobile_agg_ins
as 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.08.06
	-- 설  명 : 모바일 주문건수, 클릭아웃//Mp에서 모델 정렬할 때 사용
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	create table #tbl_mobile_order (
		modelno int not null-- primary key
	,	ord_cnt	int null
	,	clickout	int null
	)

	insert into #tbl_mobile_order(modelno, ord_cnt)
	select pl_modelno, ord_cnt from openquery(OLTPLOG_196, '	
		select pl_modelno, count(*) ord_cnt from oltplog.dbo.tbl_orderdata_ord_mobile where pl_modelno >0 and od_date>= dateadd(d, -10, cast(cast(getdate() as date) as smalldatetime)) and od_date < dateadd(d, -3, cast(cast(getdate() as date) as smalldatetime)) group by pl_modelno
	')

	insert into #tbl_mobile_order(modelno, clickout)
	select modelno, clickout from openquery(OLTPLOG_196, '	
		select modelno, sum(uhit) clickout from oltplog.dbo.tbl_move_log_mobile_agg_day_by_modelno where modelno>0  and regdate between dateadd(d, -10, cast(cast(getdate() as date) as smalldatetime)) and dateadd(d, -4, cast(cast(getdate() as date) as smalldatetime))  group by modelno
	')

	truncate table goods_ref_mobile_agg

	insert into goods_ref_mobile_agg(g_modelno, g_category, ord_cnt, clickout)
	select modelno, g_category , ord_cnt, clickout
	from 
	(
		select modelno, sum(ord_cnt) ord_cnt, sum(clickout) clickout
		from #tbl_mobile_order
		group by modelno
	) a inner join goods b on a.modelno = b.g_modelno

End
