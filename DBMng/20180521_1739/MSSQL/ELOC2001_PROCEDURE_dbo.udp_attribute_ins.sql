/* *************************************************************************
 * NAME : dbo.udp_attribute_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:20:46.2
 *        Modify: 2018-05-03 17:23:34.863
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_attribute_ins
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

insert into goods_attribute(attribute_id, category, manage_attribute_nm, gallery_attribute_nm,use_class_code,ins_oprt, group_attribute_id, group_char, is_gallery_display)
select row_number() over(order by mag_attr, attr_nm) + max_id, mcate,mag_attr,attr_nm,attr_class,ins_oprt
,case when is_group=1 then 
	row_number() over(order by mag_attr, attr_nm) + max_id
 end,group_char,is_display 
from 
(
	select  left(category, 4) mcate, mag_attr, attr_nm 
	, case max(attr_class) when '값' then '1' when '범위' then '2' end attr_class
	, 'db_batch'  ins_oprt
	, case when max(is_group) = '대표' then 1 end is_group
	, max(group_char) group_char
	, case min(is_display) when '노출' then 1 else 0 end as is_display
	from attribute_rare_data
	where category like @mcate+'%'
	group by left(category, 4), mag_attr, attr_nm
) a cross join (select isnull(max(attribute_id),0) as max_id from goods_attribute) b
