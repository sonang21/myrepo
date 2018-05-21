/* *************************************************************************
 * NAME : dbo.udp_attribute_ins_add
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-27 20:06:20.79
 *        Modify: 2018-05-03 17:23:34.493
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_attribute_ins_add
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	-- 이미 입력된 속성인 경우 엑셀데이터에 입력
	update a
	set attr_id = attribute_id
	from attribute_rare_data_add a inner join  goods_attribute b  on mag_attr = manage_attribute_nm and attr_nm = gallery_attribute_nm 
	where a.category like @mcate+'%' and b.category = @mcate
	and attr_id is null


	-- 새로운 속성인 경우 입력
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
		from attribute_rare_data_add
		where category like @mcate+'%'
		and attr_id is null
		group by left(category, 4), mag_attr, attr_nm
	) a cross join (select isnull(max(attribute_id),0) as max_id from goods_attribute) b

	-- 입력된 속성 입력
	update a
	set attr_id = attribute_id
	from attribute_rare_data_add a inner join  goods_attribute b  on mag_attr = manage_attribute_nm and attr_nm = gallery_attribute_nm 
	where a.category like @mcate+'%' and b.category = @mcate
	and attr_id is null


	-- 그룹정보 입력
	update c
	set group_attribute_id = group_id
	from goods_attribute c
		inner join
			(
				select a.attr_id as target_id, b.attr_id as group_id
				from
				(
					-- 대표에 속한 속성 리스트
					select is_group, attr_id, sheet_no from attribute_rare_data_add where is_group <> '대표' and is_group is not null and category like @mcate+'%' 
				) a inner join (
					select now_spec, attr_id, sheet_no from attribute_rare_data_add where is_group = '대표' and category like @mcate+'%' 
				) b on a.is_group = now_spec and a.sheet_no = b.sheet_no
			) d
		on c.attribute_id = target_id
	where category = @mcate
