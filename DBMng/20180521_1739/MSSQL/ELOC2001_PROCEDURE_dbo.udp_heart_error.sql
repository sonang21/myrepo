/* *************************************************************************
 * NAME : dbo.udp_heart_error
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-21 13:14:38.943
 *        Modify: 2018-05-03 17:23:36.04
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_heart_error
	@mcate varchar(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted

	delete a from goods_catalog_attribute a inner join goods_attribute b on a.attribute_id = b.attribute_id where category like @mcate+'%'

	select g_modelno, g_spec, g_category, 0 sheet_no
	into #goods_tag_del
	from eloc2001.dbo.goods where g_category like  @mcate+'%'

	-- 태그삭제
	if '0908' = @mcate begin -- 골프예외처리
		update	#goods_tag_del 
		set		g_spec = dbo.fnHTMLtoTEXT(replace(replace(g_spec,'<b>','['),'</b>',']')) 
		where	sign(charindex('>', g_spec)) = 1
	end

	update	#goods_tag_del
	set		g_spec = dbo.fnHTMLtoTEXT(g_spec)
	where	sign(charindex('>', g_spec)) = 1

	-- 모델마다 시트번호입력
	update a
	set		sheet_no = b.sheet_no
	from	#goods_tag_del a inner join sheet_category b on left(a.g_category, len(b.category)) = b.category
	where	a.sheet_no = 0 and category like  @mcate+'%'


	insert into goods_catalog_attribute (g_modelno, attribute_id, attribute_element_id, ins_oprt, attribute_value)
	select g_modelno, attr_id, attr_ele_id, 'db_batch',max(attr_ele_value)
	from attribute_rare_data a inner join #goods_tag_del b
	on charindex(replace('/'+now_spec +'/','//','/'), '/'+g_spec+'/') > 0 
	and a.sheet_no = b.sheet_no
	where category like @mcate+'%'
	group by g_modelno, attr_id, attr_ele_id
	option (maxdop 1)

	select @mcate
