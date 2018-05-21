/* *************************************************************************
 * NAME : dbo.udp_nb_category_keyword_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-30 16:28:33.823
 *        Modify: 2018-05-03 17:23:36.023
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE proc [dbo].[udp_nb_category_keyword_sel]
	@category		varchar(12)
,	@keyword		varchar(50)
as

	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	select seqno, category, keyword
	from tbl_nb_category_keyword 
	where category	like isnull(@category+'%', category)
	and keyword like isnull('%'+@keyword+'%', keyword)
	order by category, keyword

