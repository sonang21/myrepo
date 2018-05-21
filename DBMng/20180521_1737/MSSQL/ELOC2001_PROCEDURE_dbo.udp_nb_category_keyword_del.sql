/* *************************************************************************
 * NAME : dbo.udp_nb_category_keyword_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-30 16:29:05.54
 *        Modify: 2018-05-03 17:23:34.237
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc [dbo].[udp_nb_category_keyword_del]
	@seqno		int
as

	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	delete tbl_nb_category_keyword where seqno	= @seqno

