/* *************************************************************************
 * NAME : dbo.udp_cj_report_denied_goodscode_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-23 16:44:58.207
 *        Modify: 2018-05-03 17:23:34.527
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_report_denied_goodscode_sel
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.23
	-- ��   �� : cj �Ӽ� ������.��Ī�Ұ� ����Ʈ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/
	select p_date 	
	, b.cj_ca_name1, b.cj_ca_name2, b.cj_ca_name3, b.cj_ca_name4
	, goodscode, factory, brand, goodsnm, p_memo
	, c.cj_ca_name1, c.cj_ca_name2, c.cj_ca_name3, c.cj_ca_name4
	from tbl_cj_goods a 
		inner join tbl_cj_cate b on a.cj_ca_code4 = b.cj_ca_code4
		inner join tbl_cj_cate c on a.cj_ca_code4_job = c.cj_ca_code4
	where p_status = '2' -- �Ұ�
end