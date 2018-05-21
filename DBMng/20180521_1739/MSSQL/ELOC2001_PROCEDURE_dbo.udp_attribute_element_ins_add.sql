/* *************************************************************************
 * NAME : dbo.udp_attribute_element_ins_add
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-03-03 16:40:42.073
 *        Modify: 2018-05-03 17:23:34.967
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_attribute_element_ins_add
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- 기존 속성원 입력
	update a
	set attr_ele_id = attribute_element_id
	from attribute_rare_data_add a inner join  goods_attribute_element b  on attribute_id =attr_id and attr_elenm = attribute_element 
	where a.category like @mcate+'%'
	and attr_ele_id is null 


	insert into goods_attribute_element (attribute_id, attribute_element_id, attribute_element,ins_oprt)
	select attribute_id, isnull(max_attt_ele_id,0) + attr_ele_id, attr_elenm, 'db_batch'
	from
	(
		select row_number() over(partition by attr_id order by attr_id, attr_elenm ) as attr_ele_id, attr_id attribute_id, attr_elenm
		from (select distinct attr_id, attr_elenm from attribute_rare_data_add where category like @mcate+'%' and attr_ele_id is null) a
	) a left outer join (
		select attr_id, max(attribute_element_id) max_attt_ele_id 
		from goods_attribute_element inner join attribute_rare_data_add  on attr_id = attribute_id where category like @mcate +'%'
		group by attr_id
	) b on a.attribute_id = b.attr_id


	-- 기존 속성원 입력
	update a
	set attr_ele_id = attribute_element_id
	from attribute_rare_data_add a inner join  goods_attribute_element b  on attribute_id =attr_id and attr_elenm = attribute_element 
	where a.category like @mcate+'%'
	and attr_ele_id is null 

