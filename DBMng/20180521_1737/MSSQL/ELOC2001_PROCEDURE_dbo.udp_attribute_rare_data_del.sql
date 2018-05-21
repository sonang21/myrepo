/* *************************************************************************
 * NAME : dbo.udp_attribute_rare_data_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-14 14:03:35.543
 *        Modify: 2018-05-03 17:23:34.463
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE  proc udp_attribute_rare_data_del
	@mcate varchar(4)
as
	--delete from attribute_rare_data where category like mcate+'%'

	-- 기존 순서 백업
	delete attribute_rare_data_order where  category like @mcate+'%'

	insert into attribute_rare_data_order
	select a.category, manage_attribute_nm, gallery_attribute_nm ,display_order
	from goods_category_attribute a inner join goods_attribute b on a.attribute_id = b.attribute_id 
	where a.category like @mcate+'%' and b.category like @mcate+'%'

	-- 기존 순서 삭제
	delete from goods_category_attribute where category like @mcate+'%'

	insert into attribute_rare_data_log(mcate) values(@mcate)
	delete from attribute_rare_data where category like @mcate+'%'
	delete a from goods_attribute_element a inner join goods_attribute b on a.attribute_id = b.attribute_id where category like @mcate+'%'
	delete a from goods_catalog_attribute a inner join goods_attribute b on a.attribute_id = b.attribute_id where category like @mcate+'%'
	delete from goods_attribute where category like @mcate+'%'

