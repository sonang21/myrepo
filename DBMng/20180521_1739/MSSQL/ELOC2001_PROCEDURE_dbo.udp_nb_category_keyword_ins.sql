/* *************************************************************************
 * NAME : dbo.udp_nb_category_keyword_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-30 16:28:55.323
 *        Modify: 2018-05-03 17:23:34.043
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_nb_category_keyword_ins]
	@category		varchar(12)
,	@keyword		varchar(50)

as

	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- 새로운 순서 입력
	insert into tbl_nb_category_keyword(category, keyword)
	values(@category, @keyword)

