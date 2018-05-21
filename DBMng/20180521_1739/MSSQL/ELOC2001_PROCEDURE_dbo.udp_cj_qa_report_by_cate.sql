/* *************************************************************************
 * NAME : dbo.udp_cj_qa_report_by_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-31 11:43:59.227
 *        Modify: 2018-05-03 17:23:35.867
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_qa_report_by_cate
	@sdate smalldatetime
,	@edate smalldatetime
,	@order int
,	@cate  varchar(12)
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017-03-31
	-- 설  명 : cj qa 로그
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	

		-- 카테고리별
		select a.cj_ca_code3, b.cj_ca_name3, d_cnt, c_cnt, u_cnt, u_cnt*100.0/t_cnt
		 ,ordercol = case @order -- 항상 select 컬럼의 마지막 컬럼이 되면 된다.
					when 2 then d_cnt
					when 3 then u_cnt
					else (u_cnt*100.0/t_cnt) end
		from 
		(
			select  a.cj_ca_code3 
			,	sum(case when job_flag ='d' then cnt else 0 end) d_cnt
			,	sum(case when job_flag ='c' then cnt else 0 end) c_cnt
			,	sum(case when job_flag ='u' then cnt else 0 end) u_cnt
			,	SUM(cnt) t_cnt
			from 
			(
				select cj_ca_code3, job_flag, COUNT(*) cnt
				from tbl_cj_qa_log
				where job_date>=@sdate and job_date < @edate+1
				and cj_ca_code2 like @cate+'%'
				group by  cj_ca_code3, job_flag
			) a 
			group by cj_ca_code3
		) a inner join tbl_cj_cate b on a.cj_ca_code3 = b.cj_ca_code
		order by ordercol desc
end

