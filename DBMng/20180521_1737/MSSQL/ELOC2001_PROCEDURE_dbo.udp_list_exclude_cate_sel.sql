/* *************************************************************************
 * NAME : dbo.udp_list_exclude_cate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-27 14:01:26.263
 *        Modify: 2018-05-03 17:23:35.48
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_list_exclude_cate_sel
	@category	varchar(12) = '%'
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : ����Ʈ ���� �з� sel / 2010-04-27
	-- ��  �� : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select lec_seq, category, add_cate, main_goods, cate_scope 
	from tbl_list_exclude_cate
	where category like @category

