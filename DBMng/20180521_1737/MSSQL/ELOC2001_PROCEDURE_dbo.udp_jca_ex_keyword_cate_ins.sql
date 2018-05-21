/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_cate_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-28 15:19:47.92
 *        Modify: 2018-05-03 17:23:34.207
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ex_keyword_cate_ins	
	@cate varchar(12)
,	@use_flag bit
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-04-28
	-- ��  �� : �ڵ��׷��� ī�װ�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	delete tbl_ex_keyword_cate where category = @cate
	insert into tbl_ex_keyword_cate(category, use_flag) values(@cate, @use_flag)
