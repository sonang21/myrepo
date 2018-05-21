/* *************************************************************************
 * NAME : dbo.udp_cate_monitoring_guide_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-21 15:23:22.567
 *        Modify: 2018-05-03 17:23:34.87
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_cate_monitoring_guide_mod
	@seqno varchar(12)
,	@guide_title char(100)
,	@guide_desc varchar(500)
,	@guide_attri_desc varchar(500)
,	@ex_option1 varchar(100)
,	@ex_option2 varchar(100)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-15
	-- ��  �� : �з��� ���� ���̵�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	update tbl_cate_monitoring_guide 
	set guide_title = @guide_title
	,	guide_desc = @guide_desc
	,	guide_attri_desc = @guide_attri_desc
	,	moddate = getdate()
	,	ex_option1 = @ex_option1
	,	ex_option2 = @ex_option2
	where seqno = @seqno



