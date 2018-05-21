/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_assign_status_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-04-13 15:02:57.583
 *        Modify: 2017-02-28 15:58:32.613
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_assign_status_sel
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-03-18
	-- 설  명 : 모니터링 데이터 수집
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

		select (select top 1 mm_nm from mpdb02.member.dbo.mm_enuri where mm_id=assign_mm_id)
		,	assign_mm_id
		,	sum_cnt + isnull(chg_5,0)
		,	chg_1
		,	chg_2
		,	chg_3
		,	chg_5
		,	chg_8
		,	chg_12
		,	chg_14
		,	chg_17
		,	chg_18
		,	chg_19
		,	chg_20
		,	chg_21
		,	chg_22
		,	chg_23
		,	chg_24
		,	chg_25
		from
		(
			select assign_mm_id
			,	sum(cnt) sum_cnt
			,	sum(case when chg_type = 1 then cnt end) chg_1
			,	sum(case when chg_type = 2 then cnt end) chg_2
			,	sum(case when chg_type = 3 then cnt end) chg_3
			,	(	-- 최저가 경고창은 모집단 통합 테이블에 넣지 않는다.
					select count(distinct c.pl_no) from  pricelist_matching_alarm_srch c inner join pricelist b on c.pl_no = b.pl_no
					where p_status='i' and alarm_flag='2' and c.assign_mm_id = a.assign_mm_id
					and b.pl_modelno > 0 and b.pl_status not in ('3','4','5') and b.pl_srvflag = '0' and b.option_flag2 = '0'
				) chg_5
			,	sum(case when chg_type = 8 then cnt end) chg_8
			,	sum(case when chg_type = 12 then cnt end) chg_12
			,	sum(case when chg_type = 14 then cnt end) chg_14
			,	sum(case when chg_type = 17 then cnt end) chg_17
			,	sum(case when chg_type = 18 then cnt end) chg_18
			,	sum(case when chg_type = 19 then cnt end) chg_19
			,	sum(case when chg_type = 20 then cnt end) chg_20
			,	sum(case when chg_type = 21 then cnt end) chg_21
			,	sum(case when chg_type = 22 then cnt end) chg_22
			,	sum(case when chg_type = 23 then cnt end) chg_23
			,	sum(case when chg_type = 24 then cnt end) chg_24
			,	sum(case when chg_type = 25 then cnt end) chg_25
			from
			(
				select assign_mm_id, chg_type, count(*) cnt
				from tbl_monitoring_target
				where p_status = 'i'
				group by assign_mm_id, chg_type 
			) a
			group by assign_mm_id
		) a
		order by assign_mm_id
end
