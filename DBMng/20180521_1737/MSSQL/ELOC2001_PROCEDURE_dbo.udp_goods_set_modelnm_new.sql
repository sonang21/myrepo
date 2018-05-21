/* *************************************************************************
 * NAME : dbo.udp_goods_set_modelnm_new
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-08 11:23:20.707
 *        Modify: 2018-05-03 17:23:35.523
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_goods_set_modelnm_new
	@g_modelno int
as 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 20150708
	-- 설  명 : 새로운 제조사, 브랜드, 모델명
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/


	select g_modelno, g_category, g_modelnm, g_modelnm_new, brand_id, maker_id 
	into #target_modelno
	from goods where g_modelno = @g_modelno


	update #target_modelno
	set g_modelnm = replace(replace(rtrim(ltrim(g_modelnm)),char(10), ''), char(13), '')


	-- goods.제조사명
	update a 
	set g_modelnm_new = case when g_category like '030[45]%' then g_modelnm else  (
		rtrim(
			ltrim(
				replace(
					replace(
							replace(
									' ' +(case when g_category like '14%' then dbo.udf_RegExReplace(g_modelnm, '\[[^\]]+[^\]]*\]', '', 1) else  g_modelnm end) +' '
									, '@'
									, ' @'
							)
							, isnull(' '+b.maker_nm_new+' ','')
							,' '
					)
					, ' @'
					, '@'
				)
			)
		)
	) end
	from #target_modelno a inner join tbl_enuri_maker b on a.maker_id = b.maker_id
	where g_modelno = @g_modelno


	-- goods.브랜드명
	update a 
	set g_modelnm_new = case when g_category like '030[45]%' then g_modelnm else  (
		rtrim(
			ltrim(
				replace(
					replace(
							replace(
									' ' +g_modelnm_new+' '
									, '@'
									, ' @'
							)
							, isnull(' '+b.brand_nm_new+' ','')
							,' '
					)
					, ' @'
					, '@'
				)
			)
		)
	) end
	from #target_modelno a inner join tbl_enuri_brand b on a.maker_id = b.maker_id and a.brand_id = b.brand_id
	where g_modelno = @g_modelno


	-- 띄어쓰기 2개 -> 1개로 변환
	update #target_modelno set g_modelnm_new = replace(g_modelnm_new,'  ',' ') where g_modelno = @g_modelno
	update #target_modelno set g_modelnm_new = replace(g_modelnm_new,'  ',' ') where g_modelno = @g_modelno
	update #target_modelno set g_modelnm_new = replace(g_modelnm_new,'  ',' ') where g_modelno = @g_modelno
	update #target_modelno set g_modelnm_new = replace(g_modelnm_new,'  ',' ') where g_modelno = @g_modelno


	-- 예외처리 적용 : 공백, @로 시작하는 경우 모델명 입력
	update a
	set g_modelnm_new = g_modelnm
	--select a.g_modelnm_new, a.g_modelnm--count(*)
	from #target_modelno a
	where g_modelnm_new like '@%' or g_modelnm_new = ''

	update a
	set g_modelnm_new = b.g_modelnm_new
	from goods a inner join #target_modelno b on a.g_modelno = b.g_modelno
	where a.g_modelno = @g_modelno

--	select * from #target_modelno
--	select g_modelnm, g_modelnm_new from goods where g_modelno = @g_modelno
end
