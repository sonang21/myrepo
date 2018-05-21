/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-09 17:30:19.523
 *        Modify: 2018-05-03 17:23:35.643
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_rt_srv_off_agg	
AS begin
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.11.09
	-- 설  명 : 단종3 처리 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	-- 기존 데이터 삭제

	delete from tbl_rt_srv_off_agg where yyyymmdd = cast(getdate()-1 as date)

	-- 전체
	select 't' as p_status, substring(category, 1,4)  mcate, count(*) cnt, cast('' as varchar(15)) mm_id
	into #result
	from openquery(oradb, 'select pl_no, max(ca_code) as category from tbl_mini_nuribot_log  where price_check = ''2'' and regdate >= to_char(sysdate-1, ''yyyy-mm-dd'') and regdate < to_char(sysdate, ''yyyy-mm-dd'') group by pl_no')
	group by substring(category, 1,4)

	-- 처리

	-- 오류처리가 최우선 되도록
	insert into #result
	select b.p_status, left(b.pl_category,4) mcate, count(*) cnt, max(a.mm_id) mm_id
	from
	(
		select pl_no, max(p_date) max_date, max(mm_id) mm_id
		from pricelist_dml_log 
		where log_flag = '2' and p_status = 'u' and p_date>= cast(getdate()-1 as date) and p_date < cast(getdate()-0 as date)
		group by pl_no
	) a inner join pricelist_dml_log b on a.pl_no = b.pl_no and a.max_date = b.p_date and p_status = 'u'
	where b.log_flag = '2' and b.p_date>= cast(getdate()-1 as date) and b.p_date < cast(getdate()-0 as date)
	group by b.p_status, left(b.pl_category,4) 


	-- pl_no 중복제거
	insert into #result
	select b.p_status, left(b.pl_category,4) mcate, count(*) cnt, max(a.mm_id)
	from
	(
		select pl_no, max(p_date) max_date, max(mm_id) mm_id
		from pricelist_dml_log 
		where log_flag = '2' and p_status in ('i', 'd')  and p_date>= cast(getdate()-1 as date) and p_date < cast(getdate()-0 as date)
		group by pl_no
	) a inner join pricelist_dml_log b on a.pl_no = b.pl_no and a.max_date = b.p_date
	where b.log_flag = '2' and b.p_date>= cast(getdate()-1 as date) and b.p_date < cast(getdate()-0 as date)  and p_status in ('i', 'd')
	and b.pl_no not in (
	
		select pl_no
		from pricelist_dml_log 
		where log_flag = '2' and p_status = 'u' and p_date>= cast(getdate()-1 as date) and p_date < cast(getdate()-0 as date)
		group by pl_no
	
	)
	group by b.p_status, left(b.pl_category,4) 


	insert into tbl_rt_srv_off_agg(yyyymmdd, category, t_cnt, i_cnt, u_cnt, d_cnt, i_cnt_bat)	
	select	cast(getdate()-1 as date) yyyymmdd
	     , mcate 
	     , sum(case when p_status ='t' then cnt end)
	     , sum(case when p_status ='i' and mm_id not in ('SCI_BATCH') then cnt end) as i_cnt
	     , sum(case when p_status ='u' then cnt end)
	     , sum(case when p_status ='d' then cnt end)
		 , sum(case when p_status ='i' and mm_id in ('SCI_BATCH') then cnt end) as i_cnt_bat
	from #result
	group by mcate
end
