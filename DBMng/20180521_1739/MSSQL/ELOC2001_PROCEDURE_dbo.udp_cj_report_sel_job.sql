/* *************************************************************************
 * NAME : dbo.udp_cj_report_sel_job
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-21 12:02:07.34
 *        Modify: 2018-05-03 17:23:35.877
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_report_sel_job
	@mm_id		varchar(12)
,	@report_sdate datetime
,	@report_edate datetime
as  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.21
	-- 설   명 : cj 속성 컨설팅.레포트.작업자별
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	;with cte_summary (cj_ca_code, t_cnt,  t_cnt_1, t_cnt_2, t_cnt_qa, ord) 
	as
	(
			select cj_ca_code4
			,	isnull(count(*), 0) t_cnt			
			,	isnull(sum(case when job_flag='1' then 1 end), 0) t_cnt_1
			,	isnull(sum(case when job_flag='2' then 1 end), 0) t_cnt_2
			,	isnull(sum(case when qa_status='u' then 1 end), 0) t_cnt_qa
			,	grouping(cj_ca_code4) ord
			from (
			
				-- 일별, 작업자별, 작업구분 중복 제거
				select  mm_id, goodscode, job_flag, cast(job_date as DATE) job_date, max(cj_ca_code4) cj_ca_code4, max(old_qa_status) qa_status
				from	tbl_cj_job_log			
				where job_date >= @report_sdate
				and	 job_date < @report_edate + 1
				and	mm_id like @mm_id
				and	mm_id  <> 'db_batch'
				and	job_flag in ('1', '2')
				group by mm_id, goodscode, job_flag, cast(job_date as DATE)
			
			) a
			group by cj_ca_code4
			with rollup
	)
	select isnull(cj_ca_name1, '합계')
	,	cj_ca_name2
	,	cj_ca_name3
	,	cj_ca_name4
	,	t_cnt, t_cnt_1, t_cnt_2, t_cnt_qa
	,	n_p_ratio = (t_cnt_2)*100.0 / t_cnt
	,	q_p_ratio = (t_cnt_qa)*100.0 / t_cnt
	,	cj_ca_code_full = isnull(cj_ca_code1, '')+isnull(cj_ca_code2, '')+isnull(cj_ca_code3, '')+isnull(cj_ca_code4, '')
	from cte_summary a  
				left outer join tbl_cj_cate  b on a.cj_ca_code = b.cj_ca_code
	order by ord, cj_ca_code_full
end




