/* *************************************************************************
 * NAME : dbo.udp_sd_category_keyword_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-08-09 15:32:06.46
 *        Modify: 2018-05-03 17:23:34.987
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_sd_category_keyword_mod
	@seqno			int
,	@category		varchar(12)
,	@keyword		varchar(50)
,	@keyword_flag	char(1)
as
	-- ---------------------------------------------------
	-- wookki25 / 2016.08.09
	-- 쇼핑 다이이어리 00 분류 매칭시 참조하는 키워드
	-- ---------------------------------------------------
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	update tbl_sd_category_keyword
	set keyword		= @keyword
	,	keyword_flag  = @keyword_flag
	where seqno = @seqno
