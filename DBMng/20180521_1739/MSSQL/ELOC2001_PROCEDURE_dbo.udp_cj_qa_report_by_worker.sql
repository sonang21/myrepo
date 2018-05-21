/* *************************************************************************
 * NAME : dbo.udp_cj_qa_report_by_worker
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-31 11:50:58.077
 *        Modify: 2018-05-03 17:23:34.29
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_cj_qa_report_by_worker
	@sdate smalldatetime
,	@edate smalldatetime
,	@order int
,	@mm_id  varchar(12)
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017-03-31
	-- ��  �� : cj qa �α�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	

	
		-- �۾��ں�
		select '' mm_nm, mm_id, d_cnt, c_cnt, u_cnt, u_cnt*100.0/t_cnt

		 ,ordercol = case @order -- �׻� select �÷��� ������ �÷��� �Ǹ� �ȴ�.
					when 2 then d_cnt
					when 3 then u_cnt
					else (u_cnt*100.0/t_cnt) end
		from
		(
			select '' mm_nm, mm_id 
			,	sum(case when job_flag ='d' then cnt else 0 end) d_cnt
			,	sum(case when job_flag ='c' then cnt else 0 end) c_cnt
			,	sum(case when job_flag ='u' then cnt else 0 end) u_cnt
			,	SUM(cnt) t_cnt
			from 
			(
				select mm_id, job_flag, COUNT(*) cnt
				from tbl_cj_qa_log
				where job_date>=@sdate and job_date < @edate+1
				group by mm_id, job_flag
			) a 
			group by mm_id
		) a 
		order by ordercol desc
	
end

