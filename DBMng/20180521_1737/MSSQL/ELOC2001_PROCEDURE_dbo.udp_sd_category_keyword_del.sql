/* *************************************************************************
 * NAME : dbo.udp_sd_category_keyword_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-08-09 15:31:38.39
 *        Modify: 2018-05-03 17:23:34.75
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_sd_category_keyword_del
	@seqno		int
as
	-- ---------------------------------------------------
	-- wookki25 / 2016.08.09
	-- ���� �����̾ 00 �з� ��Ī�� �����ϴ� Ű����
	-- ---------------------------------------------------
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	delete tbl_sd_category_keyword where seqno	= @seqno
