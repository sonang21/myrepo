/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_bid_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-21 09:57:51.55
 *        Modify: 2018-05-03 17:23:35.887
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_jca_ap_report_bid_del
	@sale_date smalldatetime
,	@data_opt char(1) = '1'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013-08-21
	-- ��  �� : �������� ����,Ŭ�� ��ȸ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	delete tbl_ap_sales_bid 
	where sale_date = @sale_date
	and		data_opt = @data_opt
