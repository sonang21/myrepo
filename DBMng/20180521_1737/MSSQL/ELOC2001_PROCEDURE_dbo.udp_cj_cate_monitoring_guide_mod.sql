/* *************************************************************************
 * NAME : dbo.udp_cj_cate_monitoring_guide_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-28 14:40:12.42
 *        Modify: 2018-05-03 17:23:34.193
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_cj_cate_monitoring_guide_mod
	@seqno varchar(12)
,	@guide_title varchar(100)
,	@guide_desc varchar(500)
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
	
	update tbl_cj_cate_monitoring_guide 
	set guide_title = @guide_title
	,	guide_desc = @guide_desc
	,	moddate = getdate()
	where seqno = @seqno






