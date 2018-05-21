/* *************************************************************************
 * NAME : dbo.udp_cj_report_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-21 11:39:41.027
 *        Modify: 2018-05-03 17:23:34.687
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_report_ins
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.21
	-- ��   �� : cj �Ӽ� ������.����Ʈ �Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/

	-- ����Ʈ ������ ����.
	--delete  from tbl_cj_report where report_date =  cast(getdate()-1 as date) 
	insert into tbl_cj_report (cj_ca_code1, cj_ca_code2, cj_ca_code3, cj_ca_code4, p_status, cnt, report_date)
	select cj_ca_code1, cj_ca_code2, cj_ca_code3, cj_ca_code4, p_status
	, count(case when p_date < cast(cast(getdate() as date) as datetime) then 1 else 0 end) cnt
	, cast(getdate()-1 as date) as report_date
	from tbl_cj_goods 
	group by cj_ca_code1, cj_ca_code2, cj_ca_code3, cj_ca_code4, p_status
	option (maxdop 1)

end
