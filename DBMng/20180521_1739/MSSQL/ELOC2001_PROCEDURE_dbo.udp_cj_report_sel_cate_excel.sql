/* *************************************************************************
 * NAME : dbo.udp_cj_report_sel_cate_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-23 17:10:05.737
 *        Modify: 2018-05-03 17:23:34.59
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_report_sel_cate_excel
	@report_date date
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
			select cj_ca_code4
			,	isnull(sum(cnt), 0) t_cnt
			,	isnull(sum(case when p_status='0' then cnt end), 0) t_cnt_0
			,	isnull(sum(case when p_status='1' then cnt end), 0) t_cnt_1
			,	isnull(sum(case when p_status='2' then cnt end), 0) t_cnt_2
			,	grouping(cj_ca_code4) ord
			from tbl_cj_report
				where report_date = @report_date
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
	,	cj_ca_code_full = isnull(cj_ca_code1, '')+isnull(cj_ca_code2, '')+isnull(cj_ca_code3, '')+isnull(cj_ca_code4, '')
	from cte_summary a  
		left outer join tbl_cj_cate b on a.cj_ca_code = b.cj_ca_code
	order by ord, cj_ca_code_full
	
end






