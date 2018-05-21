/* *************************************************************************
 * NAME : dbo.udp_orderdata_dashboard_sel_cm2_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 13:54:01.21
 *        Modify: 2018-05-14 13:54:01.21
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_orderdata_dashboard_sel_cm2_excel
	@sdate smalldatetime
,	@category varchar(12)
,	@top_cnt int = 100
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014.06.12
	-- 설  명 : 매출확인 다운로드
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	create table #tmp_popular(g_modelno int, gpa_po_point money)

	if @top_cnt = 200 begin
		insert into #tmp_popular
--		select top 200 g_modelno, gpa_po_point 
--		from tbl_goods_popular_acc where gpa_date = @sdate and g_category like  @category+'%' order by GPA_PO_POINT desc

		select top 200 modelno, popular 
		from tbl_cm_perf_ref_site_popular where pop_date = @sdate and category like  @category+'%' order by popular desc
	end else if @top_cnt = 300 begin
		insert into #tmp_popular
		select top 300 modelno, popular 
		from tbl_cm_perf_ref_site_popular where pop_date = @sdate and category like  @category+'%' order by popular desc
	end else if @top_cnt = 400 begin
		insert into #tmp_popular
		select top 400 modelno, popular 
		from tbl_cm_perf_ref_site_popular where pop_date = @sdate and category like  @category+'%' order by popular desc
	end else if @top_cnt = 500 begin
		insert into #tmp_popular
		select top 500 modelno, popular 
		from tbl_cm_perf_ref_site_popular where pop_date = @sdate and category like  @category+'%' order by popular desc
	end else begin
		insert into #tmp_popular
		select top 100 modelno, popular 
		from tbl_cm_perf_ref_site_popular where pop_date = @sdate and category like  @category+'%' order by popular desc
	end

	
	select b.modelno, pl_no, g_modelnm, g_factory, total_price, total_amount, uhit, p_point, mcate_group_rank, move_uhit, total_cnt, device
	from
	(
		select modelno, max(p_point) p_point, max(total_amount) total_amount, max(total_price) total_price, max(uhit) uhit, pl_no, sum(move_uhit) move_uhit, sum(total_cnt) total_cnt, 'PC' device
		from 
		(
			select modelno, -100 p_point, total_amount, total_price, uhit, pl_no, isnull(move_uhit,0) move_uhit, total_cnt 
			from tbl_orderdata_dashboard 
			where od_date = @sdate and category_now like @category+'%' 
			union all
			select g_modelno, gpa_po_point, 0, 0, 0, 0, 0, 0 from #tmp_popular
		) a
		group by modelno, pl_no

		union all 

		select modelno, max(p_point) p_point, max(total_amount) total_amount, max(total_price) total_price, max(uhit) uhit, pl_no, sum(move_uhit) move_uhit, sum(total_cnt) total_cnt, '모바일' device
		from 
		(
			select modelno, -100 p_point, total_amount, total_price, uhit, pl_no, isnull(move_uhit,0) move_uhit, total_cnt 
			from tbl_orderdata_dashboard_mobile 
			where od_date = @sdate and category_now like @category+'%' 
			union all
			select g_modelno, gpa_po_point, 0, 0, 0, 0, 0, 0 from #tmp_popular
		) a
		group by modelno, pl_no
	) b left outer join analstore.dbo.goods c on b.modelno = c.g_modelno
	left outer join tbl_cm_perf_ref_site_popular d on b.modelno = d.modelno and pop_date = @sdate
	order by device, p_point desc, total_price desc

