/* *************************************************************************
 * NAME : dbo.udp_sd_category_keyword_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-08-09 15:32:06.443
 *        Modify: 2018-05-03 17:23:34.967
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_sd_category_keyword_ins
	@category		varchar(12)
,	@keyword		varchar(50)
,	@keyword_flag	char(1)
as
	-- ---------------------------------------------------
	-- wookki25 / 2016.08.09
	-- ���� �����̾ 00 �з� ��Ī�� �����ϴ� Ű����
	-- ---------------------------------------------------
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- ���ο� ���� �Է�
	insert into tbl_sd_category_keyword(category, keyword, keyword_flag)
	values(@category, @keyword, @keyword_flag)
