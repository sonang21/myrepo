/* *************************************************************************
 * NAME : dbo.udp_attribute_element_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:20:19.217
 *        Modify: 2018-05-03 17:23:34.85
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_attribute_element_ins
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	insert into goods_attribute_element (attribute_id, attribute_element_id, attribute_element,ins_oprt)
	select attribute_id, attr_ele_id, attr_elenm, 'db_batch'
	from
	(
		select row_number() over(partition by attr_id order by attr_id, attr_elenm ) as attr_ele_id, attr_id attribute_id, attr_elenm
		from (select distinct attr_id, attr_elenm from attribute_rare_data where category like @mcate+'%') a
	) a
