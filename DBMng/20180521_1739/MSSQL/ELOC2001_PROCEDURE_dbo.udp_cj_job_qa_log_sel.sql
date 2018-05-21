/* *************************************************************************
 * NAME : dbo.udp_cj_job_qa_log_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-29 10:22:28.26
 *        Modify: 2018-05-03 17:23:34.22
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_job_qa_log_sel
	@goodscode varchar(10)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.16
	-- ��   �� : cj �Ӽ� ������.�۾��α� Ȯ��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/
	select mm_id, job_flag, job_date, factory, brand, goodsnm, p_memo, 'cm', old_qa_err_code qa_memo
	from tbl_cj_job_log
	where goodscode = @goodscode


	union all

	select mm_id, job_flag, job_date, factory, brand, goodsnm, qa_memo, 'qa',  qa_err_code
	from tbl_cj_qa_log
	where goodscode = @goodscode
	order by job_date desc

end

