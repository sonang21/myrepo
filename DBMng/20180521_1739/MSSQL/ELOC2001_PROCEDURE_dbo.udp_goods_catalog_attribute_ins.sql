/* *************************************************************************
 * NAME : dbo.udp_goods_catalog_attribute_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-02-21 17:10:23.657
 *        Modify: 2018-05-03 17:23:36.047
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_goods_catalog_attribute_ins
	@mcate varchar(4)
as
	set nocount on
	set transaction isolation level read uncommitted

--	[2�� ��� db���� ��û�з�-�з� �Ӽ����� �����ؾ���]
	if @mcate not in ( '0208', '0359', '0901', '0903', '0904', '0905', '0906', '0908', '0909', '0911', '0919', '0920', '0923', '0924', '0925', '0929', '0930', '0931', '0932', 
		'1013', '1201', '1202', '1204', '1205', '1208', '1220', '1225', '1228', '1603', '1605', '1620', '1623', '1625', '1629', '1632', '1644', '1646', '1648', 
		'1802', '1803', '1822', '2109', '2114', '2115', '2120', '2131', '2202', '2207','2117')  begin
		return
	end
	

	-- ------------------------------------
	-- ����� ó��
	-- ------------------------------------
	-- �����_�׷� ���� ����
	update attribute_rare_data set is_group_spec = 0 where category like @mcate+'%'
	update attribute_rare_data set is_group_spec = 1 where category like @mcate+'%' and now_spec like '%[\[��]%/%'
	If @@rowcount = 0 
		return
	
	-- ------------------------------------
	-- ��ó��
	-- ------------------------------------
	-- ��ó��_��� ����
	select g_modelno, g_spec, g_category, 0 sheet_no, 0 is_group_spec
	into #goods_tag_del
	from eloc2001.dbo.goods  
	where 1=0

	if '0908' = @mcate begin -- ��������ó��
		insert into #goods_tag_del
		select g_modelno, replace(replace(g_spec,'<b>','['),'</b>',']') as g_spec, g_category, 0 sheet_no, 0 is_group_spec
		--into #goods_tag_del
		from eloc2001.dbo.goods 
		where g_spec not like '%  /  %' and g_category like  @mcate+'%'  -- ��ü��� ����
		and g_spec like '%<b>%/%' -- �׷�𵨸�
	end else begin
		insert into #goods_tag_del
		select g_modelno, g_spec, g_category, 0 sheet_no, 0 is_group_spec
		--into #goods_tag_del
		from eloc2001.dbo.goods 
		where g_spec not like '%  /  %' and g_category like  @mcate+'%'  -- ��ü��� ����
		and g_spec like '%[\[��]%/%' -- �׷�𵨸�
	end

	-- ��ó��_�±׻���
	update	#goods_tag_del
	set		g_spec = dbo.fnHTMLtoTEXT(g_spec)
	where	sign(charindex('>', g_spec)) = 1

	-- ��ó��_�з��� ��Ʈ��ȣ�Է�
	update	a
	set		sheet_no = b.sheet_no
	from	#goods_tag_del a inner join sheet_category b on left(a.g_category, len(b.category)) = b.category
	where	a.sheet_no = 0 and category like  @mcate+'%'

	-- ��ó��_��࿡ �����_�׷� ���� ���� ����
	update a	
	set is_group_spec = 1
	from #goods_tag_del a inner join (select * from attribute_rare_data where is_group_spec=1 and category like @mcate+'%') b
	on a.sheet_no = b.sheet_no and charindex(replace('/'+now_spec +'/','//','/'), '/'+g_spec+'/') > 0
	option (maxdop 1)


	-- ��ó��_�׷� �������� ���� �� ����
	delete from #goods_tag_del where is_group_spec = 0

	-- ��ó��_�׷� ���Ե� ���� ���� ������ �Ӽ� ����
	delete a from goods_catalog_attribute a inner join #goods_tag_del b on a.g_modelno = b.g_modelno


	-- ------------------------------------
	-- �Ӽ� �ϰ��Է�
	-- ------------------------------------
	-- �׷�Ӽ� ���� ó��
	insert into goods_catalog_attribute (g_modelno, attribute_id, attribute_element_id, ins_oprt, attribute_value)
	select g_modelno, attr_id, attr_ele_id, 'db_batch',max(attr_ele_value)
	from (select * from attribute_rare_data where is_group_spec=1 and category like @mcate+'%') a inner join #goods_tag_del b
	on charindex(replace('/'+ltrim(rtrim(now_spec)) +'/','//','/'), '/'+replace(replace(g_spec, ' /','/'), '/ ','/')+'/') > 0
	and a.sheet_no = b.sheet_no
	group by g_modelno, attr_id, attr_ele_id
	option (maxdop 1)

	-- �����_�׷� ����
	update	a
	set		g_spec = substring(g_spec, 1, patindex('%[\[��]%', g_spec)-1)
	from	#goods_tag_del a

	-- ��׷� �Ӽ� ó��
	insert into goods_catalog_attribute (g_modelno, attribute_id, attribute_element_id, ins_oprt, attribute_value)
	select * from 
	(
		select g_modelno, attr_id, attr_ele_id, 'db_batch' oprt,max(attr_ele_value) ele_value
		from (select * from attribute_rare_data where is_group_spec=0 and category like @mcate+'%') a inner join #goods_tag_del b
		on charindex(replace('/'+ltrim(rtrim(now_spec)) +'/','//','/'), '/'+replace(replace(g_spec, ' /','/'), '/ ','/')+'/') > 0
		and a.sheet_no = b.sheet_no
		where category like @mcate+'%'
		group by g_modelno, attr_id, attr_ele_id
	) a
	where not exists(select * from goods_catalog_attribute b where a.g_modelno = b.g_modelno and a.attr_id = b.attribute_id and a.attr_ele_id = b.attribute_element_id)
	option (maxdop 1)

	insert into tmp_udp_goods_catalog_attribute_ins_log(mcate) values(@mcate)


