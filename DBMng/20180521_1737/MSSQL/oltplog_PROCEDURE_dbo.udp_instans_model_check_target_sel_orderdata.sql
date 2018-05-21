/* *************************************************************************
 * NAME : dbo.udp_instans_model_check_target_sel_orderdata
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:59:01.013
 *        Modify: 2018-05-13 19:59:01.013
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_instans_model_check_target_sel_orderdata
	@sdate smalldatetime	
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-06-22
	-- 설  명 : 즉시서비스(임시상품) 상품 주문데이터
	-- 참  고 : udp_instans_model_check_target_sel_dhit : 즉시서비스 hit 주문 데인터
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2012.11.26		wookki25		주문개수 삭제, 단가 30만원 --> 3만원으로 수정
	*/

	-- 모델별 집계..
	select	convert(char(6), max(od_date), 112) as yyyymm
	,		g_modelno
	,		max(g_modelnm) modelnm
	,		max(g_category) category
	,		count(*) total_cnt
	,		sum(od_cnt) total_amount
	,		sum(od_cnt*od_price) total_price
	,		sum(od_cnt*od_price)/sum(od_cnt) unit_price
	into	#worker
	from	(
				select od_date, od_cnt, od_price, pl_modelno from tbl_orderdata where od_date >= @sdate and od_date < @sdate+1 and od_cnt>0 and shop_vcode not in (536, 55, 5910,4027)
				union all
				select od_date, od_cnt, od_price, pl_modelno from tbl_orderdata_gmarket_auction where od_date >= @sdate and od_date < @sdate+1 and od_cnt>0 and shop_vcode in (536, 55, 5910,4027)
			) b
				inner join	
			(
				select g_modelnm, g_category, g_modelno 
				from analstore.dbo.goods 
				where charindex('  /  ', g_spec) > 0 and g_partcode = '0' and g_imgchk in ('8', '4')
				and g_category not like '93%'
				and g_category not like '14%'
				and g_category not like '15%'
		--		and g_category not like '0313%'
		--		and g_category not like '0344%'
		--		and g_category not like '0343%'
		--		and g_category not like '0313%'
		--		and g_category not like '0335%'
		--		and g_category not like '0337%'
		--		and g_category not like '0339%'
		--		and g_category not like '0341%'
		--		and g_category not like '0346%'
				and g_category not like '1640%'
			) a on pl_modelno = g_modelno	
	group by g_modelno
--	order by category, total_price desc

	select * from #worker a 
	where total_cnt >= 2 and 
		(
			select count(*) 
			from #worker b 
			where left(a.category, 4) = left(b.category, 4) and a.g_modelno <> b.g_modelno 
			and (b.total_cnt*100000000.0)+b.total_price >= (a.total_cnt*100000000.0)+a.total_price
		) < 10
	order by left(category,4), total_cnt desc, total_price desc





