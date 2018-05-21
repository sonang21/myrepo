/* *************************************************************************
 * NAME : dbo.udp_cate_monitoring_guide_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-21 15:13:46.81
 *        Modify: 2018-05-03 17:23:34.857
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cate_monitoring_guide_sel
	@category varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014.11.20
	-- ��  �� : �з��� ���� ���̵�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	select seqno, category, guide_title, guide_desc, isnull(moddate, regdate)
	, ex_option1, ex_option2, isnull(guide_attri_desc,'')
	from tbl_cate_monitoring_guide 
	where category like @category +'%'
	order by category, guide_title

