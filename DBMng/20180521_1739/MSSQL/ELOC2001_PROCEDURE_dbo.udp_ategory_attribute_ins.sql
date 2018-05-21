/* *************************************************************************
 * NAME : dbo.udp_ategory_attribute_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:10:53.91
 *        Modify: 2018-05-03 17:23:34.77
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_ategory_attribute_ins
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- 새로운 순서 입력
	insert into goods_category_attribute(category, attribute_id)
	select b.category, attr_id 
	from 
	(
		select distinct attr_id, sheet_no
		from attribute_rare_data
		where category like @mcate+'%'
	) a inner join sheet_category b on a.sheet_no = b.sheet_no
	where category like  @mcate+'%'

	-- 기존 순서 입력
	update a
	set display_order = isnull((select top 1 display_order from attribute_rare_data_order c 
							where c.manage_attribute_nm=b.manage_attribute_nm 
							and c.gallery_attribute_nm =b.gallery_attribute_nm 
							and c.category = a.category
						), 1)
	from goods_category_attribute a inner join goods_attribute b on a.attribute_id = b.attribute_id 
	where a.category like @mcate+'%' and b.category like @mcate+'%'
