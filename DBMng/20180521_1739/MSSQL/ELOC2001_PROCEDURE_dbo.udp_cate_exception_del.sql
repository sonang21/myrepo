/* *************************************************************************
 * NAME : dbo.udp_cate_exception_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-30 17:13:17.817
 *        Modify: 2018-05-03 17:23:34.06
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_cate_exception_del
	@category varchar(12)
,	@exception_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-15
	-- ��  �� : �з��� ����ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	delete tbl_cate_exception where category = @category and exception_flag = @exception_flag

