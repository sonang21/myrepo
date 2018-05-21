/* *************************************************************************
 * NAME : dbo.udp_cate_exception_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-30 17:16:24.383
 *        Modify: 2018-05-03 17:23:34.087
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cate_exception_sel
	@category varchar(12)
,	@exception_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013.09.30
	-- ��  �� : �з��� ����ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	select category
	from tbl_cate_exception 
	where exception_flag = @exception_flag
	and category like isnull(@category,'')+'%'
	order by category
