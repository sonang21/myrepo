/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_chk_log_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-27 14:34:31.663
 *        Modify: 2018-05-03 17:23:34.587
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_chk_log_sel
	@sdate datetime
,	@edate datetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-09-26
	-- ��  �� : ap �����ڵ� ���� & db �����층 �α�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select shop_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, logdate
	from shoplist_ap_code_chk_log 
	where logdate >= @sdate and logdate < @edate+1
	order by shop_vcode, logdate asc

