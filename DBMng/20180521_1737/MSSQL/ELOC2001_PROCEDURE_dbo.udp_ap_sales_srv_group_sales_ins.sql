/* *************************************************************************
 * NAME : dbo.udp_ap_sales_srv_group_sales_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-30 16:59:58.213
 *        Modify: 2018-05-03 17:23:34.34
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_ap_sales_srv_group_sales_ins
	@sales_date	date
,	@sales		numeric(15,0)
,	@group_code	smallint
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

	-- �����ϰ�
	delete from tbl_ap_sales_srv_group where sale_date = @sales_date and group_code = @group_code
	

	-- �����Է�
	insert into tbl_ap_sales_srv_group(sale_date, sales, group_code)
	select  @sales_date, @sales, @group_code where @sales > 0
