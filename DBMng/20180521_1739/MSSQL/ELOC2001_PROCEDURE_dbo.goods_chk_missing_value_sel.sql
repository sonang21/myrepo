/* *************************************************************************
 * NAME : dbo.goods_chk_missing_value_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-27 18:30:44.993
 *        Modify: 2018-05-03 17:23:34.68
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc goods_chk_missing_value_sel
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-27
	-- 설  명 : goods 정보 누락된 모델 리스트
	--			agent에서 매일 새벽에 기존 데이터 모두 지우고 새로 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select g_category,g_constrain , a.g_modelno, g_modelnm, g_factory, g_brand, g_spec2, maker_id, brand_id
	from goods_chk_missing_value a inner join goods b on a.g_modelno = b.g_modelno
