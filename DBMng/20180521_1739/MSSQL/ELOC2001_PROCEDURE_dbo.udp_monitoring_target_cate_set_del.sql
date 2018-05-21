/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_cate_set_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-22 16:53:31.11
 *        Modify: 2018-05-03 17:23:34.3
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_monitoring_target_cate_set_del
	@category varchar(12)
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

	delete tbl_monitoring_target_cate_set where  category = @category
