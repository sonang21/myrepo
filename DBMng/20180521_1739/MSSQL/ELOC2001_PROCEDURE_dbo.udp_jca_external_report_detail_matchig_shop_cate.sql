/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_matchig_shop_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-23 12:53:52.307
 *        Modify: 2018-05-03 17:23:34.563
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_matchig_shop_cate
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
		, a.category,'',''
		 , [db 전송수]		= isnull(send_cnt, 0)
		 , [매칭수]			= isnull(matching_cnt, 0)
		 , [매칭 불가수]		= isnull(denied_cnt, 0)
		 , [미매칭수]			= isnull(send_cnt - matching_cnt - denied_cnt, 0)
		 , [작업수]			= isnull(matching_cnt + denied_cnt * 0.5, 0)
		 , [매칭률]			= isnull(matching_cnt * 100.0 / send_cnt, 0)
		 , [진행률]			= isnull((matching_cnt + denied_cnt * 0.5) * 100.0 / 3000000, 0)
		 , 0 ord
	from tbl_external_stats_gs  a 
		where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'

	union all

	-- 합계
	select '합계', '','',''
	,	isnull(sum(send_cnt), 0)
	,	isnull(sum(matching_cnt), 0)
	,	isnull(sum(denied_cnt), 0)
	,	isnull(sum(send_cnt - matching_cnt - denied_cnt), 0)
	,	isnull(sum(matching_cnt + denied_cnt * 0.5), 0)
	,	isnull(sum(matching_cnt) * 100.0 / sum(send_cnt), 0)
	,	isnull(sum(matching_cnt + denied_cnt * 0.5) * 100.0 / 3000000, 0)
	,	1 ord
	from tbl_external_stats_gs a
	where shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'
	order by ord, category


end

