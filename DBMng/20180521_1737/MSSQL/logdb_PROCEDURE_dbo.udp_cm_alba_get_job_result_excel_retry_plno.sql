/* *************************************************************************
 * NAME : dbo.udp_cm_alba_get_job_result_excel_retry_plno
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-02 16:13:51.887
 *        Modify: 2015-07-14 13:45:45.353
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cm_alba_get_job_result_excel_retry_plno
	@mm_id	varchar(12)
,	@sdate	datetime
,	@edate	datetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.05.28
	-- 설  명 : cm  재택근무
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select mm_id, mm_nm into #tbl_cm_alba_set_cate  from openquery(SEARCHKEY_193, 'select distinct mm_id, mm_nm from enuridb.dbo.tbl_cm_alba_set_cate where alba_flag in (''3'')')

	-- 중복 plno list .. 별도 엑셀파일
	select jp_date, jp_plistno,  jp_modelno, jp_vcode, jp_id, (select top 1 mm_nm from #tbl_cm_alba_set_cate where mm_id = jp_id) as mm_nm
	from job_pricelist
	where jp_plistno in (

			select jp_plistno--, count(*) cnt
			from job_pricelist inner join #tbl_cm_alba_set_cate  on jp_id = mm_id
			where jp_date >=@sdate and jp_date < @edate+1
			and jp_modelno > 0 and jp_flag in ('0', '2', '5', '6')  --not in ('1','4','A')
			and mm_id = isnull(nullif(@mm_id, ''), mm_id)
			group by jp_plistno
			having count(*) >=2
	)
	order by jp_id, convert(varchar(10), jp_date, 120) , jp_plistno


