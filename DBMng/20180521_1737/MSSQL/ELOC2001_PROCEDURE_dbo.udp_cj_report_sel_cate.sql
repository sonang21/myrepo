/* *************************************************************************
 * NAME : dbo.udp_cj_report_sel_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-22 19:16:33.787
 *        Modify: 2018-05-03 17:23:34.72
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_report_sel_cate
	@report_date date
,	@cj_ca_code char(6)	
,	@cj_ca_level  tinyint
as  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.21
	-- 설   명 : cj 속성 컨설팅.레포트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	;with cte_summary (cj_ca_code, t_cnt, t_cnt_0, t_cnt_1, t_cnt_2, ord) 
	as
	(

			select cj_ca_code1 
			,	isnull(sum(cnt), 0) t_cnt
			,	isnull(sum(case when p_status='0' then cnt end), 0) t_cnt_0
			,	isnull(sum(case when p_status='1' then cnt end), 0) t_cnt_1
			,	isnull(sum(case when p_status='2' then cnt end), 0) t_cnt_2
			,	grouping(cj_ca_code1) ord
			from tbl_cj_report
			where report_date = @report_date  and @cj_ca_level = 1
			group by cj_ca_code1
			with rollup

			union all

			select cj_ca_code2 
			,	isnull(sum(cnt), 0) t_cnt
			,	isnull(sum(case when p_status='0' then cnt end), 0) t_cnt_0
			,	isnull(sum(case when p_status='1' then cnt end), 0) t_cnt_1
			,	isnull(sum(case when p_status='2' then cnt end), 0) t_cnt_2
			,	grouping(cj_ca_code2) ord
			from tbl_cj_report
			where report_date = @report_date and cj_ca_code1=@cj_ca_code and @cj_ca_level = 2
			group by cj_ca_code2
			with rollup


			union all


			select cj_ca_code3
			,	isnull(sum(cnt), 0) t_cnt
			,	isnull(sum(case when p_status='0' then cnt end), 0) t_cnt_0
			,	isnull(sum(case when p_status='1' then cnt end), 0) t_cnt_1
			,	isnull(sum(case when p_status='2' then cnt end), 0) t_cnt_2
			,	grouping(cj_ca_code3) ord
			from tbl_cj_report
			where report_date = @report_date and cj_ca_code2=@cj_ca_code and @cj_ca_level = 3
			group by cj_ca_code3
			with rollup

			union all

			select cj_ca_code4
			,	isnull(sum(cnt), 0) t_cnt
			,	isnull(sum(case when p_status='0' then cnt end), 0) t_cnt_0
			,	isnull(sum(case when p_status='1' then cnt end), 0) t_cnt_1
			,	isnull(sum(case when p_status='2' then cnt end), 0) t_cnt_2
			,	grouping(cj_ca_code4) ord
			from tbl_cj_report
				where report_date = @report_date and cj_ca_code3=@cj_ca_code and @cj_ca_level = 4
			group by cj_ca_code4
			with rollup


	)
	select isnull(b.cj_ca_name1, '합계')
	,	b.cj_ca_name2
	,	b.cj_ca_name3
	,	b.cj_ca_name4
	,	t_cnt, t_cnt_0, t_cnt_1, t_cnt_2
	,	t_p_ratio = (t_cnt_1+t_cnt_2)*100.0 / t_cnt
	,	n_p_ratio = (t_cnt_2)*100.0 / t_cnt
	,	y_p_ratio = (t_cnt_1)*100.0 / t_cnt
	,	cj_ca_code_full = isnull(cj_ca_code1, '')+isnull(cj_ca_code2, '')+isnull(cj_ca_code3, '')+isnull(cj_ca_code4, '')
	from cte_summary a  
		left outer join tbl_cj_cate b on a.cj_ca_code = b.cj_ca_code

	order by ord, cj_ca_code_full
	
end





