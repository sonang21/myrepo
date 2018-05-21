/* *************************************************************************
 * NAME : dbo.udp_matching_target_assign_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-03 15:40:24.543
 *        Modify: 2018-05-03 17:23:35.757
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE  proc udp_matching_target_assign_agg_ins
	@category	varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.06.03
	-- 설  명 : 매칭 할당 집계
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	delete tbl_matching_target_assign_agg where category = @category and regdate = convert(varchar(10), getdate(), 120)
	
	insert into tbl_matching_target_assign_agg(mm_id, category, goods_cnt, price_cnt, regdate)
	select ASSIGN_MM_ID, @category, count(*), sum(webcnt) webcnt, convert(varchar(10), getdate(), 120)
	from tbl_matching_target
	where category = @category 
	group by assign_mm_id

	-- 최근 한달간 데이터만 유지한다.
	delete tbl_matching_target_assign_agg where category = @category and regdate < dateadd(m, -1 , getdate())
