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

--	[2중 요약 db수정 요청분류-분류 속성순서 유지해야함]
	if @mcate not in ( '0208', '0359', '0901', '0903', '0904', '0905', '0906', '0908', '0909', '0911', '0919', '0920', '0923', '0924', '0925', '0929', '0930', '0931', '0932', 
		'1013', '1201', '1202', '1204', '1205', '1208', '1220', '1225', '1228', '1603', '1605', '1620', '1623', '1625', '1629', '1632', '1644', '1646', '1648', 
		'1802', '1803', '1822', '2109', '2114', '2115', '2120', '2131', '2202', '2207','2117')  begin
		return
	end
	

	-- ------------------------------------
	-- 현재명 처리
	-- ------------------------------------
	-- 현재명_그룹 여부 설정
	update attribute_rare_data set is_group_spec = 0 where category like @mcate+'%'
	update attribute_rare_data set is_group_spec = 1 where category like @mcate+'%' and now_spec like '%[\[☞]%/%'
	If @@rowcount = 0 
		return
	
	-- ------------------------------------
	-- 모델처리
	-- ------------------------------------
	-- 모델처리_대상 저장
	select g_modelno, g_spec, g_category, 0 sheet_no, 0 is_group_spec
	into #goods_tag_del
	from eloc2001.dbo.goods  
	where 1=0

	if '0908' = @mcate begin -- 골프예외처리
		insert into #goods_tag_del
		select g_modelno, replace(replace(g_spec,'<b>','['),'</b>',']') as g_spec, g_category, 0 sheet_no, 0 is_group_spec
		--into #goods_tag_del
		from eloc2001.dbo.goods 
		where g_spec not like '%  /  %' and g_category like  @mcate+'%'  -- 즉시서비스 제외
		and g_spec like '%<b>%/%' -- 그룹모델만
	end else begin
		insert into #goods_tag_del
		select g_modelno, g_spec, g_category, 0 sheet_no, 0 is_group_spec
		--into #goods_tag_del
		from eloc2001.dbo.goods 
		where g_spec not like '%  /  %' and g_category like  @mcate+'%'  -- 즉시서비스 제외
		and g_spec like '%[\[☞]%/%' -- 그룹모델만
	end

	-- 모델처리_태그삭제
	update	#goods_tag_del
	set		g_spec = dbo.fnHTMLtoTEXT(g_spec)
	where	sign(charindex('>', g_spec)) = 1

	-- 모델처리_분류별 시트번호입력
	update	a
	set		sheet_no = b.sheet_no
	from	#goods_tag_del a inner join sheet_category b on left(a.g_category, len(b.category)) = b.category
	where	a.sheet_no = 0 and category like  @mcate+'%'

	-- 모델처리_요약에 현재명_그룹 포함 여부 설정
	update a	
	set is_group_spec = 1
	from #goods_tag_del a inner join (select * from attribute_rare_data where is_group_spec=1 and category like @mcate+'%') b
	on a.sheet_no = b.sheet_no and charindex(replace('/'+now_spec +'/','//','/'), '/'+g_spec+'/') > 0
	option (maxdop 1)


	-- 모델처리_그룹 포함하지 않은 모델 삭제
	delete from #goods_tag_del where is_group_spec = 0

	-- 모델처리_그룹 포함된 모델의 기존 설정된 속성 삭제
	delete a from goods_catalog_attribute a inner join #goods_tag_del b on a.g_modelno = b.g_modelno


	-- ------------------------------------
	-- 속성 일괄입력
	-- ------------------------------------
	-- 그룹속성 먼저 처리
	insert into goods_catalog_attribute (g_modelno, attribute_id, attribute_element_id, ins_oprt, attribute_value)
	select g_modelno, attr_id, attr_ele_id, 'db_batch',max(attr_ele_value)
	from (select * from attribute_rare_data where is_group_spec=1 and category like @mcate+'%') a inner join #goods_tag_del b
	on charindex(replace('/'+ltrim(rtrim(now_spec)) +'/','//','/'), '/'+replace(replace(g_spec, ' /','/'), '/ ','/')+'/') > 0
	and a.sheet_no = b.sheet_no
	group by g_modelno, attr_id, attr_ele_id
	option (maxdop 1)

	-- 현재명_그룹 삭제
	update	a
	set		g_spec = substring(g_spec, 1, patindex('%[\[☞]%', g_spec)-1)
	from	#goods_tag_del a

	-- 비그룹 속성 처리
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


