/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 14:41:13.64
 *        Modify: 2018-05-03 17:23:34.317
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_sel
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-09-26
	-- ��  �� : ap �����ڵ� ���� & db �����층���� üũ�� �� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select shop_vcode, shop_apcode1, shop_apcode2, memo from shoplist_ap_code order by shop_vcode
