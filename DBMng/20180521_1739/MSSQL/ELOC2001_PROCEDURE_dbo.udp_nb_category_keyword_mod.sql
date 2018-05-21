/* *************************************************************************
 * NAME : dbo.udp_nb_category_keyword_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-30 16:28:46.64
 *        Modify: 2018-05-03 17:23:36.137
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_nb_category_keyword_mod]
	@seqno			int
,	@category		varchar(12)
,	@keyword		varchar(50)
as

	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	update tbl_nb_category_keyword
	set keyword	= @keyword, category = @category
	where seqno = @seqno

