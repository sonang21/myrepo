/* *************************************************************************
 * NAME : dbo.udp_cj_qa_report_assign
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-31 13:41:34.093
 *        Modify: 2018-05-03 17:23:34.383
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_qa_report_assign
	@sdate smalldatetime
,	@edate smalldatetime
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017-03-31
	-- ��  �� : ����͸� ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	

	select CAST(p_date as date),  COUNT(*) 
	from tbl_cj_goods 
	where qa_assign_mm_id is not null  
	and p_date>= @sdate  and p_date < @edate+1
	group by CAST(p_date as date)
	order by 1 , 2
	
end

