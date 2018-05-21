/* *************************************************************************
 * NAME : dbo.udp_attribute_ins_step2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-17 16:27:34.523
 *        Modify: 2018-05-03 17:23:34.87
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_attribute_ins_step2
	@mcate varchar(4)
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	update a
	set attr_id = attribute_id
	from attribute_rare_data a inner join  goods_attribute b  on mag_attr = manage_attribute_nm and attr_nm = gallery_attribute_nm 
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
					select is_group, attr_id, sheet_no from attribute_rare_data where is_group <> '대표' and is_group is not null and category like @mcate+'%' 
				) a inner join (
					select now_spec, attr_id, sheet_no from attribute_rare_data where is_group = '대표' and category like @mcate+'%' 
				) b on a.is_group = now_spec and a.sheet_no = b.sheet_no
			) d
		on c.attribute_id = target_id
	where category = @mcate
