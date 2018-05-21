/* *************************************************************************
 * NAME : dbo.udp_ap_sales_srv_group_code_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-30 14:58:39.807
 *        Modify: 2018-05-03 17:23:35.61
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_ap_sales_srv_group_code_sel	
	@set_date date
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.11.30
	-- ��  �� : �濵��.���ϸ�.���� �׷� ����Ʈ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	select a.group_code, group_name, sales
	from tbl_ap_sales_srv_group_code a left outer join tbl_ap_sales_srv_group b on a.group_code = b.group_code  and b.sale_date = @set_date
	where a.group_code < 99


	select a.group_code, group_name, month_cost 
	from tbl_ap_sales_srv_group_code a left outer join tbl_ap_sales_srv_group_cost b on a.group_code = b.group_code  and b.cost_yyyymm = convert(char(6), @set_date, 112)
	where a.group_code < 99
