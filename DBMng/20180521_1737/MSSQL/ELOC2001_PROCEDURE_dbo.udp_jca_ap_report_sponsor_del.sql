/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 10:07:25.363
 *        Modify: 2018-05-03 17:23:35.61
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_jca_ap_report_sponsor_del
	@shopcode int
,	@sale_date smalldatetime
,	@data_opt char(1) = '1'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-08-11
	-- ��  �� : ��������ũ ����,Ŭ�� �Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	delete tbl_ap_sales_sponsor 
	where sale_date = @sale_date and shop_vcode = @shopcode
	and		data_opt = @data_opt



