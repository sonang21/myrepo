/* *************************************************************************
 * NAME : dbo.udp_sd_category_keyword_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-08-09 15:32:06.49
 *        Modify: 2018-05-03 17:23:35.047
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE proc [dbo].[udp_sd_category_keyword_sel]
	@category		varchar(12)
,	@keyword		varchar(50)
,	@keyword_flag	char(1)
as
	-- ---------------------------------------------------
	-- wookki25 / 2016.08.09
	-- 쇼핑 다이이어리 00 분류 매칭시 참조하는 키워드
	-- ---------------------------------------------------
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	select seqno, category, keyword, keyword_flag
	from tbl_sd_category_keyword 
	where category	like isnull(@category+'%', category)
	and keyword like isnull('%'+@keyword+'%', keyword)
	and keyword_flag = isnull(@keyword_flag, keyword_flag)
	order by category, keyword
