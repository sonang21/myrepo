/* *************************************************************************
 * NAME : dbo.udp_monitoring_team_agg_alba_0_job_step2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-12-23 15:22:41.55
 *        Modify: 2018-05-03 17:23:35.117
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_team_agg_alba_0_job_step2
	@sdate date
,	@edate date
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.12.23
	-- 설  명 : 가격모니터링 재택근무자 0 처리.jca에서 엑셀 다운로드
	-- exec udp_monitoring_team_agg_alba_0_job_step2 '2015-12-21', '2015-12-22'
	-- 196.oltplog.dbo.udp_monitoring_team_agg_alba_0_job_step1 참고.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	-- 결과값 입력 테이블
	create table #tbl_monitoring_team_agg_alba_desc2(
		mm_id				varchar(12)
	,	monitor_no			int
	,	pl_no				bigint
	,	job_date			datetime
	,	err_cate			varchar(12)
	,	old_modelno			int
	,	new_modelno			int
	,	is_out_target		bit
	,	new_modelno_date	datetime
	,	refer_route			int					
	)
	
	-- 196 선처리
	declare @sql varchar(8000)	
	set @sql = 'select * from openquery(oltplog_196, ''exec oltplog.dbo.udp_monitoring_team_agg_alba_0_job_step1 @sdate='''''+cast(@sdate as varchar(10))+''''', @edate='''''+cast(@edate as varchar(10))+''''' '')'
	insert into #tbl_monitoring_team_agg_alba_desc2(mm_id,monitor_no,pl_no,job_date,err_cate,old_modelno,new_modelno,is_out_target,new_modelno_date,refer_route)
	exec (@sql)


	-- 참조값들
	select * into #mm from openquery (SEARCHKEY_193, 'select mm_id, mm_nm from enuridb.dbo.mm_enuri where mm_partcode like ''_________411''')
	select monitor_no, monitor_name into #agg_name from tbl_monitoring_team_agg_name where is_use = 1


	-- 결과값
	select job_date, new_modelno_date, old_modelno, b.g_modelnm, a.new_modelno, e.g_modelnm, c.pl_goodsnm, c.pl_goodscode, a.mm_id, d.mm_nm, a.pl_no--, refer_route, e.g_minprice, e.g_minprice3, c.pl_price
	, b.g_category
	, monitor_name
	from #tbl_monitoring_team_agg_alba_desc2 a 
		left outer join goods b on a.old_modelno = b.g_modelno
		left outer join pricelist c on a.pl_no = c.pl_no
		left outer join #mm d on a.mm_id = d.mm_id
		left outer join goods e on a.new_modelno = e.g_modelno
		left outer join #agg_name f on a.refer_route = f.monitor_no	

