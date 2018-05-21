/* *************************************************************************
 * NAME : dbo.udp_jca_group_match_check_barnd_maker
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-02-18 18:54:51.98
 *        Modify: 2018-05-03 17:23:34.983
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_group_match_check_barnd_maker
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2016.02.18
	-- 설  명 : 그룹매칭에서 사용하는 브랜드, 제조사 
	--			삭제여부 확인
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	

	select brand_id into #brand_id from openquery(oradb, 'select brand_id from tbl_ex_keyword where  ex_flag in (''1'', ''e'') and brand_id is not null union select brand_id  from tbl_we_brand ')
	select maker_id into #maker_id from openquery(oradb, 'select maker_id from tbl_ex_keyword where  ex_flag in (''1'', ''e'') and maker_id is not null union select factory_id  from tbl_we_brand ')

	select '브랜드', a.brand_id, b.brand_nm from #brand_id a inner join tbl_enuri_brand b on a.brand_id = b.brand_id where b.del_yn = 'y'
	union all
	select '제조사', a.maker_id, b.maker_nm from #maker_id a inner join tbl_enuri_maker b on a.maker_id = b.maker_id where b.del_yn = 'y'
	order by 1, 2

