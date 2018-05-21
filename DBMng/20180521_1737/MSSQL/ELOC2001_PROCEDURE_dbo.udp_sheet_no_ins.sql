/* *************************************************************************
 * NAME : dbo.udp_sheet_no_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:30:05.463
 *        Modify: 2018-05-03 17:23:34.933
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_sheet_no_ins
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	update a
	set	sheet_no = b.sheet_no
	from	goods_tag_del a inner join sheet_category b on left(a.g_category, len(b.category)) = b.category
	where	a.sheet_no = 0 and category like @mcate+'%'