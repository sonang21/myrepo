/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_add_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-12 15:23:26.217
 *        Modify: 2018-05-03 17:23:35.127
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_pricelist_option_add_agg_ins
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-09-12
	-- 설  명 : 옵션 추가 사원별 작업개수
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	-- 최근 7일간 데이터 보관.
	-- 최근 7일 이전 데이터는 집계하고 삭제한다.
	declare @sdate smalldatetime
	set @sdate  = convert(varchar(10), getdate() - 7, 120)

	-- 집계
	insert into tbl_pricelist_option_add_agg(aggdate, mm_id, cnt)
	select @sdate, mm_id, count(*)
	from tbl_pricelist_option_add
	where p_status = 'd' and mm_id is not null
	and regdate>=@sdate and regdate < @sdate+1
	group by mm_id

	-- 집계처리한 원본 데이터 삭제
	delete tbl_pricelist_option_add
	where regdate>=@sdate and regdate < @sdate+1

	-- 집계데이터 6개월간 보관
	-- 따라서 6개월 이전 데이터 삭제한다.
	delete tbl_pricelist_option_add_agg
	where aggdate < dateadd(mm, -6, getdate())
