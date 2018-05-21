/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_shop_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-28 15:34:26.947
 *        Modify: 2018-05-03 17:23:34.077
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_jca_ex_keyword_shop_ins	
	@cate varchar(6)
,	@shop_code int
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-01-28
	-- ��  �� : �ڵ��׷��� ���ظ�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	if exists(select 1 from tbl_ex_keyword_shop where category = @cate)
		update tbl_ex_keyword_shop set shop_code = @shop_code where category = @cate
	else
		insert into tbl_ex_keyword_shop(category, shop_code) values(@cate, @shop_code)

