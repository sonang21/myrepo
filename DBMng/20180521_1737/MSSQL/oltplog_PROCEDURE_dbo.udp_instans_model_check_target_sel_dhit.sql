/* *************************************************************************
 * NAME : dbo.udp_instans_model_check_target_sel_dhit
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:58:40.027
 *        Modify: 2018-05-13 19:58:40.027
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_instans_model_check_target_sel_dhit
	@sdate smalldatetime	
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-06-22
	-- 설  명 : 즉시서비스(임시상품) 모델 hit 데이터
	-- 참  고 : udp_instans_model_check_target_sel_orderdata : 즉시서비스 모델 주문 데인터
	-- ----------------------------------------------
	select top 100 md_dd, b.g_modelno, b.g_modelnm, b.g_category, md_hit, isnull(md_dup_hit,0)
	from tbl_model_dhit a inner join (
		select g_modelnm, g_category, g_modelno 
		from analstore.dbo.goods 
		where is_instant_spec=1 and g_partcode = '0' and g_imgchk in ('8', '4')
		and g_category not like '93%'
		and g_category not like '14%'
		and g_category not like '15%'
--		and g_category not like '0313%'
--		and g_category not like '0344%'
--		and g_category not like '0343%'
--		and g_category not like '0313%'
--		and g_category not like '0335%'
--		and g_category not like '0338%'
--		and g_category not like '0337%'
--		and g_category not like '0339%'
--		and g_category not like '0341%'
--		and g_category not like '0340%'
--		and g_category not like '0346%'
		and g_category not like '1640%'
	) b on a.g_modelno = b.g_modelno 
	where md_dd = convert(char(8), @sdate, 112)
	order by md_dup_hit desc, md_hit desc





