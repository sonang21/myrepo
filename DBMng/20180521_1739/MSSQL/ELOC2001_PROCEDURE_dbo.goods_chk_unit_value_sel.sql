/* *************************************************************************
 * NAME : dbo.goods_chk_unit_value_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-06-02 17:13:19.523
 *        Modify: 2018-05-03 17:23:35.197
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc goods_chk_unit_value_sel
	@category varchar(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-06-02
	-- 설  명 : goods 환산가 단위 확인
	--			agent에서 매월 15일 새벽에 기존 데이터 모두 지우고 새로 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select g_category, g_u_nit, regdate
	from goods_chk_unit_value
	where g_category like @category + '%'
	order by g_category asc
