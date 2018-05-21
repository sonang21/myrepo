/* *************************************************************************
 * NAME : dbo.udp_web_search_config_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-09-15 10:30:59.93
 *        Modify: 2018-05-03 17:23:35.153
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_web_search_config_del
	@category varchar(8)
,	@search_group	int
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.09.14
	-- ��  �� : ���˻� ���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	delete from tbl_web_search_config where category = @category and search_group = @search_group

