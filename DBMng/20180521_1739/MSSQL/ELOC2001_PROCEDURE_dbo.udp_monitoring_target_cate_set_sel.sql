/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_cate_set_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-22 14:49:34.757
 *        Modify: 2018-05-03 17:23:34.697
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_monitoring_target_cate_set_sel
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
	select a.category, cl_name, cm_name, b.pop_s_rank, b.pop_e_rank
	from 
	(
		select cm_lcode+cm_mcode category, cl_name, cm_name 
		from c_lcate a 
				inner join  c_mcate b on cm_lcode = cl_lcode
		where cl_lcode like substring(isnull(nullif(@category,''),'%'), 1,2) and cm_lcode like substring(isnull(nullif(@category,''),'%'), 1,2) 
		--and cl_flag = '1'
		and cm_flag = '1'
	) a left outer join tbl_monitoring_target_cate_set b on a.category = b.category
	order by 1
