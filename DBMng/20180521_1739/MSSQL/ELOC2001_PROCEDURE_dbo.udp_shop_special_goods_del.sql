/* *************************************************************************
 * NAME : dbo.udp_shop_special_goods_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-20 17:29:54.077
 *        Modify: 2018-05-03 17:23:34.93
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_shop_special_goods_del
	@seqno_csv varchar(1000)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-06-18
	-- ��  �� : ���θ� Ư�� ��ǰ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	if @seqno_csv is null
		return 0

	exec('delete from tbl_shop_special_goods where seqno in ('+@seqno_csv+')')	

