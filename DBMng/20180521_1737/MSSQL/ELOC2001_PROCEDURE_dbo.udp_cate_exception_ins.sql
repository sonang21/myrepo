/* *************************************************************************
 * NAME : dbo.udp_cate_exception_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-30 17:14:42.43
 *        Modify: 2018-05-03 17:23:34.063
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_cate_exception_ins
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
	insert into tbl_cate_exception(category, exception_flag) values(@category, @exception_flag)

