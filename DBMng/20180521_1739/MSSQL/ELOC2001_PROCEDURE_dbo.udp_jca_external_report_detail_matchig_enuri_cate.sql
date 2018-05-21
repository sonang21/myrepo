/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_matchig_enuri_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-22 17:43:33.367
 *        Modify: 2018-05-03 17:23:34.323
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_matchig_enuri_cate
	@shop_code int
,	@sdate char(8)
,	@category varchar(12)
as  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.21
	-- 설  명 :  상세리포트 : 매칭진행사항
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/
	select [소분류]			= a.category
	,	isnull(cl_name, a.category) cl_name
	,	isnull(cm_name,'') cm_name
	, 	isnull(cs_name,'') cs_name
	,	 [db 전송수]		= send_cnt
	,	 [매칭수]			= matching_cnt
	,	 [매칭 불가수]	= denied_cnt
	,	 [미매칭수]		= not_matching_cnt
	,	 [작업수]			= job_cnt
	,	 [매칭률]			= matching_rate
	,	 [진행률]			= ing_rate
	,	0 ord
	from 
	(
		select left(category, isnull(len(@category), 0)+2) category
		,	isnull(sum(send_cnt), 0) send_cnt
		,	isnull(sum(matching_cnt), 0) matching_cnt
		,	isnull(sum(denied_cnt), 0) denied_cnt
		,	isnull(sum(send_cnt - matching_cnt - denied_cnt), 0) not_matching_cnt
		,	isnull(sum(matching_cnt + denied_cnt * 0.5), 0) job_cnt
		,	isnull(sum(matching_cnt) * 100.0 / sum(send_cnt), 0) matching_rate
		,	isnull(sum(matching_cnt + denied_cnt * 0.5) * 100.0 / 3000000, 0) ing_rate
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
	,	isnull(sum(send_cnt), 0)
	,	isnull(sum(matching_cnt), 0)
	,	isnull(sum(denied_cnt), 0)
	,	isnull(sum(send_cnt - matching_cnt - denied_cnt), 0)
	,	isnull(sum(matching_cnt + denied_cnt * 0.5), 0)
	,	isnull(sum(matching_cnt) * 100.0 / sum(send_cnt), 0)
	,	isnull(sum(matching_cnt + denied_cnt * 0.5) * 100.0 / 3000000, 0)
	,	1 ord
	from tbl_external_stats_enuri a
	where shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'
	order by ord, category


end


