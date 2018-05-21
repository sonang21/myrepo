/* *************************************************************************
 * NAME : dbo.udp_pricelist_danawa_copy
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-07-16 16:21:00.823
 *        Modify: 2018-05-03 17:23:34.69
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_pricelist_danawa_copy
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-07-16
	-- ��  �� : oracle�� �ִ� tbl_pricelist_danawa ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	truncate table pricelist_danawa

	insert into pricelist_danawa(pl_vcode, pl_goodscode)
	select shop_code, goodscode
	from openquery(ORADB,'select to_char(shop_code) shop_code, goodscode from tbl_pricelist_danawa where flag in (''0'',''1'')')

