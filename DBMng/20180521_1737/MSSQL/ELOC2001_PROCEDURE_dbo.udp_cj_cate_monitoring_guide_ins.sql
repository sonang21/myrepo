/* *************************************************************************
 * NAME : dbo.udp_cj_cate_monitoring_guide_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-28 14:42:03.717
 *        Modify: 2018-05-03 17:23:35.207
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_cj_cate_monitoring_guide_ins
	@cj_ca_code4 char(6)
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
	insert into tbl_cj_cate_monitoring_guide(cj_ca_code1, cj_ca_code2, cj_ca_code3, cj_ca_code4, guide_title, guide_desc) 
	select cj_ca_code1,  cj_ca_code2, cj_ca_code3, cj_ca_code4, @guide_title, @guide_desc
	from tbl_cj_cate where cj_ca_code = @cj_ca_code4

