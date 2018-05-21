/* *************************************************************************
 * NAME : dbo.udp_get_site_popular_rank
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-02-03 10:09:41.117
 *        Modify: 2018-05-03 17:23:36.107
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_get_site_popular_rank
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2016.02.03
	-- 설  명 : 사이트 인기도 가져오기  from 196 서버
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select pop_date,category,modelno,modelno_group,popular,sum_popular,use_popular,mcate_group_rank 
	into #tmp_mcate_popular_rank
	from openquery(OLTPLOG_196, 'select * from oltplog.dbo.tbl_cm_perf_ref_site_popular where pop_date=cast(convert(varchar(10), getdate()-1, 120) as smalldatetime) and mcate_group_rank is not null')

	-- 데이터 있는 경우만 삭제하고 새로 넣는다.
	if @@rowcount > 0 begin

		truncate table tbl_mcate_popular_rank

		insert into tbl_mcate_popular_rank(pop_date,category,modelno,modelno_group,popular,sum_popular,use_popular,mcate_group_rank)
		select pop_date,category,modelno,modelno_group,popular,sum_popular,use_popular,mcate_group_rank
		from #tmp_mcate_popular_rank

	end


