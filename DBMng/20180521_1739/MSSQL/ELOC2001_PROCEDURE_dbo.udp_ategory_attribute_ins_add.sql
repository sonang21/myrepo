/* *************************************************************************
 * NAME : dbo.udp_ategory_attribute_ins_add
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-03-03 16:36:36.83
 *        Modify: 2018-05-03 17:23:34.95
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_ategory_attribute_ins_add
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- 새로운 순서 입력
	--insert into goods_category_attribute(category, attribute_id)
	select b.category, attr_id 
	into #a
	from 
	(
		select distinct attr_id, sheet_no
		from attribute_rare_data_add
		where category like @mcate+'%'
	) a inner join sheet_category b on a.sheet_no = b.sheet_no
	where category like  @mcate+'%'


	insert into goods_category_attribute(category, attribute_id, display_order)
	select category, attr_id, 32699
	from #a a
	where not exists(
		select 1 from goods_category_attribute b where a.category = b.category and a.attr_id = attribute_id
	)

