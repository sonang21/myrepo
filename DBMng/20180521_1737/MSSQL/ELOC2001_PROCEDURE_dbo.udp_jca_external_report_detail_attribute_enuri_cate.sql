/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_enuri_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-22 17:43:33.397
 *        Modify: 2018-05-03 17:23:34.337
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_attribute_enuri_cate
	@shop_code int
,	@sdate char(8)
,	@category varchar(12)
as  begin 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.21
	-- 설  명 :  상세리포트 : 속성입력사항
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/
	-- 리스트
	select [소분류]			= a.category
	,	isnull(cl_name,'') cl_name
	,	isnull(cm_name,'') cm_name
	, 	isnull(cs_name,'') cs_name
	,	[주요 속성수]	= set_cnt
	,	[상품코드수]		= plno_cnt
	,	[입력 속성수]	= attribute_matching_cnt
	,	[전체 속성수]	= attribute_total_cnt
	,	[속성입력률]		= matching_rate
	,	0 ord
	from 
	(
		select left(category, isnull(len(@category), 0)+2) category
		,	isnull(sum(set_cnt), 0) set_cnt
		,	isnull(sum(plno_cnt), 0) plno_cnt
		,	isnull(sum(attribute_cnt), 0) attribute_matching_cnt
		,	isnull(sum(plno_cnt * set_cnt), 0) attribute_total_cnt
		,	isnull(case when (sum(plno_cnt * set_cnt)) = 0 then 0 else sum(attribute_cnt) * 100.0 / (sum(plno_cnt * set_cnt)) end, 0) matching_rate
		from tbl_external_stats_enuri  a 
		where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'
		group by left(category, isnull(len(@category), 0)+2)
	)  a
		left outer join c_lcate b on substring(a.category,1,2) = b.cl_lcode and  len(a.category) >= 2
		left outer join c_mcate c on substring(a.category,1,2) = c.cm_lcode and substring(a.category,3,2) = c.cm_mcode and len(a.category) >= 4 and LEN(@category) >= 2 
		left outer join c_scate d on substring(a.category,1,2) = d.cs_lcode and substring(a.category,3,2) = d.cs_mcode  and substring(a.category,5,2) = d.cs_scode and len(a.category) >= 6 and LEN(@category) >= 4

	union all
	-- 합계
	select '합계', '', '', ''
	,	isnull(sum(set_cnt), 0) set_cnt
	,	isnull(sum(plno_cnt), 0) plno_cnt
	,	isnull(sum(attribute_cnt), 0) attribute_matching_cnt
	,	isnull(sum(plno_cnt * set_cnt), 0) attribute_total_cnt
	,	isnull(case when (sum(plno_cnt * set_cnt)) = 0 then 0 else sum(attribute_cnt) * 100.0 / (sum(plno_cnt * set_cnt)) end, 0) matching_rate
	,	1 ord
	from tbl_external_stats_enuri a
	where model_cnt > 0 and shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'
	order by ord, category

end
