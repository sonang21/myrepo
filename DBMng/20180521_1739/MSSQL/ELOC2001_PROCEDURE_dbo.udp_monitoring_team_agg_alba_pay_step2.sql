/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_alba_pay_step2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-26 14:46:34.293
 *        Modify: 2018-01-19 10:53:59.65
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_alba_pay_step2
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-11-20
	-- 설  명 : 모니터링팀 알바 급여 산정
	--          매월 정해진 날짜에 정해진 기간동안의 데이터 집계
	--			기간 : 전월 22일 ~ 당월 21일
	--	196번에 udp_monitoring_team_agg_alba_pay_step1 실행 후에 실행되어야한다.
	-- 참  조 : udp_monitoring_team_agg_sel_by_id_alba : jca에 급여 확정 전에 예상급여 표시 
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2015.02.16		wookki25		pl_status in ('0', '1') --> pl_status in ('0', '1', '8')
	2015.02.16		wookki25		근무연차에 따른 급여 테이블 차등 적용 / work_years 조건 추가
	2017.02.06		wookki25		GS모니터링 속성 조건 추가 // goods_catalog_attribute_del_bak 테이블 정리
	*/

	-- 근무연차 :  월단위로 12개월까지는 1년차 // 13개월부터 24개월까지 2년차 // 25개월부터 3년차
	select mm_id, mm_nm, mm_enterdate, (datediff(m, mm_enterdate, getdate()) / 12) +1 work_years
	into #work_years
	from MPDB02.member.dbo.mm_enuri where mm_id in (
		select distinct mm_id from tbl_monitoring_team_agg_alba_desc
		--union
		--select 'aridel' union
		--select 'hur1207' union
		--select 'yeoni528'
	)
	order by 3

	-- 근무연차 : 3년 이상 근무자는 동일한 급여 테이블 사용
	update #work_years
	set work_years = 3
	where  work_years > 3

/*

	-- 집계시점에 보관, 단종, 옵션코드 체크해서 모두 0인 경우만
	-- 재매칭 개수 카운팅한다.
	update  a 
	set is_out_target = 1
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where pl_status in ('0', '1', '8') and pl_srvflag ='0' and option_flag2='0'


	-- 통계입력 : 항목별 재매칭 제외 개수
	-- tbl_monitoring_team_agg, error_report데이터 참조
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 and old_modelno + new_modelno >0 and old_modelno = new_modelno then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	group by mm_id, monitor_no

*/



	-- 집계시점에 보관, 단종, 옵션코드 체크해서 모두 0인 경우만
	-- 재매칭 개수 카운팅한다.
	update  a 
	set is_out_target = 1
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where pl_status in ('0', '1', '8') and pl_srvflag ='0' and option_flag2='0'
	and monitor_no not in (25) -- GS속성 모니터링 제외

	-- 통계입력 : 항목별 재매칭 제외 개수
	-- tbl_monitoring_team_agg, error_report데이터 참조
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 and old_modelno + new_modelno >0 and old_modelno = new_modelno then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	where monitor_no not in (25) -- GS속성 모니터링 제외
	group by mm_id, monitor_no

	-- -----------------------------------------
	-- 예외처리 : GS속성 모니터링 항목
	-- alter table tbl_monitoring_team_agg_alba_desc add job_modelno int not null default(0)
	-- -----------------------------------------
	-- 제외
	update  a 
	set is_out_target = 1 -- 제외
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS속성 모니터링

	-- 포함 : 모니터링 후 속성 변경이 있는 경우
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS속성 모니터링
	and is_out_target = 1
	and exists (select top 1 * from goods_catalog_attribute where g_modelno = job_modelno and upd_date > job_date)
	

	-- 포함 : 속성변경일 별도 백업 받아야한다. // goods_catalog_attribute_del_bak
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a
	where monitor_no = 25 -- GS속성 모니터링
	and is_out_target = 1
	and exists (select top 1 * from goods_catalog_attribute_del_bak where g_modelno = job_modelno and upd_date > job_date)

	-- 포함 : 작업 모델번호와 현재 모델번호가 다른 경우
	update  a 
	set is_out_target = 0
	from tbl_monitoring_team_agg_alba_desc a inner join pricelist b on a.pl_no = b.pl_no
	where monitor_no = 25 -- GS속성 모니터링
	and is_out_target = 1
	and job_modelno <> pl_modelno

	-- 통계입력 : 항목별 재매칭 제외 개수
	insert into tbl_monitoring_team_agg_alba(mm_id, monitor_no, all_cnt, out_cnt)
	select mm_id, monitor_no, count(*) all_cnt, sum(case when is_out_target=1 then 1 else 0 end) as out_cnt
	from tbl_monitoring_team_agg_alba_desc
	where monitor_no = 25 -- GS속성 모니터링
	group by mm_id, monitor_no



	-- 결정된 급여 입력
	insert into tbl_monitoring_team_agg_alba_pay(mm_id, fix_cnt, fix_pay)
	select a.mm_id, a.fix_cnt, (case when a.mm_id = 'aridel' then round((b.work_pay*23)/31, -2, 0) else b.work_pay end )as fix_pay
	from
	(
		select mm_id, sum(all_cnt-out_cnt) fix_cnt
		from tbl_monitoring_team_agg_alba
		where regdate >= cast(convert(varchar(10), getdate(),120) as smalldatetime)
		and regdate< cast(convert(varchar(10), getdate(),120) as smalldatetime)+1
		group by mm_id
	) a 
		inner join #work_years c on a.mm_id = c.mm_id
		inner join tbl_monitoring_team_agg_alba_pay_table b on work_cnt = fix_cnt and b.work_years = c.work_years


	-- 작업 테이블 비우기
	truncate table tbl_monitoring_team_agg_alba_desc

	-- 참조 테이블 데이터 삭제 : 금월, 전월 데이터만 유지
	delete from goods_catalog_attribute_del_bak 
	where del_date < dateadd(m, -1, cast(dateadd(d, -day(getdate())+1, getdate()) as date))
end
