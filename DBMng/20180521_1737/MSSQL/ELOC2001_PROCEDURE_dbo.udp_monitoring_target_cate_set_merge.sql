/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_cate_set_merge
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-22 14:43:18.723
 *        Modify: 2018-05-03 17:23:34.863
 *        Backup: 20180521_1737
 ************************************************************************* */



create proc udp_monitoring_target_cate_set_merge
	@category varchar(12)
,	@pop_s_rank int
,	@pop_e_rank int
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2016.06.22
	-- 설  명 : 가격모니터링.실시간 모니터링 분류별 인기순위 설정
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/

	merge tbl_monitoring_target_cate_set as t
	using (select @category category, @pop_s_rank pop_s_rank, @pop_e_rank pop_e_rank) s
	on (t.category = s.category) 
	when not matched by target
		then insert(category, pop_s_rank, pop_e_rank) values(s.category, s.pop_s_rank, s.pop_e_rank)
	when matched 
		then update set t.pop_s_rank = s.pop_s_rank, t.pop_e_rank = s.pop_e_rank;
