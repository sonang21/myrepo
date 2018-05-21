/* *************************************************************************
 * NAME : dbo.udp_cj_cate_monitoring_guide_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-28 14:39:15.19
 *        Modify: 2018-05-03 17:23:35.75
 *        Backup: 20180521_1737
 ************************************************************************* */

create PROC udp_cj_cate_monitoring_guide_del
	@seqno varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.28
	-- ��  �� : �з��� ���� ���̵�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	delete tbl_cj_cate_monitoring_guide where seqno = @seqno
