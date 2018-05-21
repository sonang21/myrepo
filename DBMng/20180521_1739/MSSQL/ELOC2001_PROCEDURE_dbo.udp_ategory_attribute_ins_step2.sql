/* *************************************************************************
 * NAME : dbo.udp_ategory_attribute_ins_step2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:28:27.287
 *        Modify: 2018-05-03 17:23:34.873
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_ategory_attribute_ins_step2
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	update a
	set attr_ele_id = attribute_element_id
	from attribute_rare_data a inner join  goods_attribute_element b  on attribute_id =attr_id and attr_elenm = attribute_element 
	where a.category like @mcate+'%'
