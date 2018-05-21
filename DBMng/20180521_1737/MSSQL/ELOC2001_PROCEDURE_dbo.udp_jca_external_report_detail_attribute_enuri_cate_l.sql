/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_enuri_cate_l
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-08 16:34:24.79
 *        Modify: 2018-05-03 17:23:35.873
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_attribute_enuri_cate_l
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
	,	cl_name = isnull(cl_name,'') 
	,	cm_name = isnull(cm_name,'') 
	,	[상품수_ID별]	= isnull(attribute_plno_cnt, 0)
	,	[상품수_분류별]= isnull(plno_cnt, 0)
	,	[속성입력률]		= isnull(matching_rate, 0)
	,	0 ord
	from 
	(
		select left(category, isnull(len(@category), 0)+2) category
		, sum(attribute_plno_cnt) attribute_plno_cnt
		, sum(plno_cnt) plno_cnt
		, isnull(case when isnull(sum(attribute_plno_cnt),0) = 0 then 0 else (sum(attribute_plno_cnt)*100.0 / sum(plno_cnt)) end, 0) matching_rate
		from tbl_external_stats_attribute  a 
		where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'
		group by left(category, isnull(len(@category), 0)+2)
	)  a
		left outer join c_lcate b on substring(a.category,1,2) = b.cl_lcode and  len(a.category) >= 2
		left outer join c_mcate c on substring(a.category,1,2) = c.cm_lcode and substring(a.category,3,2) = c.cm_mcode and len(a.category) >= 4 and LEN(@category) >= 2 
	
	union all

	select '합계', '', ''
	, isnull(sum(attribute_plno_cnt),0) attribute_plno_cnt
	, isnull(sum(plno_cnt) ,0) plno_cnt
	, isnull(case when isnull(sum(attribute_plno_cnt),0) = 0 then 0 else (sum(attribute_plno_cnt)*100.0 / sum(plno_cnt)) end, 0) matching_rate
	, 1 ord
	from tbl_external_stats_attribute  a 
	where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'

	order by ord, category

end

