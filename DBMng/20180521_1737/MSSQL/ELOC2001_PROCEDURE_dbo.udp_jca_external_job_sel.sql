/* *************************************************************************
 * NAME : dbo.udp_jca_external_job_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-04-14 11:36:26.913
 *        Modify: 2018-05-03 17:23:34.77
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_jca_external_job_sel
	@job_date date
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 :  wookki25 / 2017.04.14
	-- 설   명 :  gs 작업량
	-- http://58.234.199.100/redmine/issues/21859
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	select isnull(mm_id, '합계')
	, isnull(SUM(case when job_flag ='m' then p_cnt end) ,0) -- 속성있는 모델에 번호 매칭 상품 수
	, isnull(SUM(case when job_flag ='s' then p_cnt end) ,0) -- 유사상품에서 일반상품으로 전환한 모델에 매칭되어있던 상품 수 (보통 누리봇이나 그룹매칭에서 자동으로 매칭된 상품)
	from TBL_EXTERNAL_JOB_AGG
	where job_date = @job_date
	group by mm_id
	with rollup
end
