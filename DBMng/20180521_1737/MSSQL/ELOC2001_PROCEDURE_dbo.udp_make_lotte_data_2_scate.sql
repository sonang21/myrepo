/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_2_scate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-24 09:57:11.127
 *        Modify: 2018-05-03 17:23:36.153
 *        Backup: 20180521_1737
 ************************************************************************* */


create proc udp_make_lotte_data_2_scate
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-06-21
	-- 설  명 : 롯데닷컴 제공 데이터 만들기
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	-- ------------------------------
	-- 2. 중분류별 전체 상품 기준 종합몰 서비스 현황
	-- ------------------------------
	select scate as [소분류코드],
		(select cm_name from c_mcate where cm_lcode+cm_mcode = left(scate,4)) as [중분류명],
		'제조사수' as [항목],
		isnull(sum(sh_49),0) as [롯데닷컴],
		isnull(round((sum(sh_49)/(max(all_cnt)*1.0))*100,0),0) as [대비율],
		isnull(sum(sh_47),0) as [A사],--[신세계몰],
		isnull(round((sum(sh_47)/(max(all_cnt)*1.0))*100,0),0) as [A_대비율],
		isnull(sum(sh_57),0) as [B사],--[HMall],
		isnull(round((sum(sh_57)/(max(all_cnt)*1.0))*100,0),0) as [B_대비율],
		isnull(sum(sh_75),0) as [C사],--[GSShop],
		isnull(round((sum(sh_75)/(max(all_cnt)*1.0))*100,0),0) as [C_대비율],
		isnull(sum(sh_663),0) as [D사],--[롯데홈쇼핑],
		isnull(round((sum(sh_663)/(max(all_cnt)*1.0))*100,0),0) as [D_대비율],
		isnull(sum(sh_806),0) as [E사],--[CJMall],
		isnull(round((sum(sh_806)/(max(all_cnt)*1.0))*100,0),0) as [E_대비율],
		(select cl_name from c_lcate where cl_lcode = left(scate,2)) as [대분류명],
		(select cs_name from c_scate where cs_lcode+cs_mcode+cs_scode = left(scate,6)) as [소분류명]

	from
	(
		select scate,
			case when pl_vcode = 49 then count(distinct factory) end as sh_49,
			case when pl_vcode = 47 then count(distinct factory) end as sh_47,
			case when pl_vcode = 57 then count(distinct factory) end as sh_57,
			case when pl_vcode = 75 then count(distinct factory) end as sh_75,
			case when pl_vcode = 663 then count(distinct factory) end as sh_663,
			case when pl_vcode = 806 then count(distinct factory) end as sh_806,
			count(distinct factory) as all_cnt
		from tmp_shop_agg_base
		group by pl_vcode, scate
	) tmp
	group by scate
	union all
	select scate as [소분류코드],
	(select cm_name from c_mcate where cm_lcode+cm_mcode = left(scate,4)) as [중분류명],
		'등록상품수' as [항목],
		isnull(sum(sh_49),0) as [롯데닷컴],
		isnull(round((sum(sh_49)/(max(all_cnt)*1.0))*100,0),0) as [대비율],
		isnull(sum(sh_47),0) as [A사],--[신세계몰],
		isnull(round((sum(sh_47)/(max(all_cnt)*1.0))*100,0),0) as [A_대비율],
		isnull(sum(sh_57),0) as [B사],--[HMall],
		isnull(round((sum(sh_57)/(max(all_cnt)*1.0))*100,0),0) as [B_대비율],
		isnull(sum(sh_75),0) as [C사],--[GSShop],
		isnull(round((sum(sh_75)/(max(all_cnt)*1.0))*100,0),0) as [C_대비율],
		isnull(sum(sh_663),0) as [D사],--[롯데홈쇼핑],
		isnull(round((sum(sh_663)/(max(all_cnt)*1.0))*100,0),0) as [D_대비율],
		isnull(sum(sh_806),0) as [E사],--[CJMall],
		isnull(round((sum(sh_806)/(max(all_cnt)*1.0))*100,0),0) as [E_대비율],
		(select cl_name from c_lcate where cl_lcode = left(scate,2)) as [대분류명],
		(select cs_name from c_scate where cs_lcode+cs_mcode+cs_scode = left(scate,6)) as [소분류명]

	from
	(
		select scate,
			case when pl_vcode = 49 then count(modelno) end as sh_49,
			case when pl_vcode = 47 then count(modelno) end as sh_47,
			case when pl_vcode = 57 then count(modelno) end as sh_57,
			case when pl_vcode = 75 then count(modelno) end as sh_75,
			case when pl_vcode = 663 then count(modelno) end as sh_663,
			case when pl_vcode = 806 then count(modelno) end as sh_806,
			count(distinct modelno) as all_cnt
		from tmp_shop_agg_base
		group by pl_vcode, scate
	) tmp
	group by scate
	order by scate, [항목]

