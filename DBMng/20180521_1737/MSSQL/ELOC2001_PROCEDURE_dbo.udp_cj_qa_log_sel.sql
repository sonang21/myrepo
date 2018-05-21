/* *************************************************************************
 * NAME : dbo.udp_cj_qa_log_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-20 11:04:31.973
 *        Modify: 2018-05-03 17:23:35.19
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_qa_log_sel
	@goodscode varchar(10)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.16
	-- ��   �� : cj �Ӽ� ������.qa �۾��α� Ȯ��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/
	select mm_id, job_flag, job_date, factory, brand, goodsnm, qa_memo
	from tbl_cj_qa_log
	where goodscode = @goodscode
	order by job_date desc
end


