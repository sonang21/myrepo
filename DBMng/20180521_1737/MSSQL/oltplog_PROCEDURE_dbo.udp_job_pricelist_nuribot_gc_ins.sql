/* *************************************************************************
 * NAME : dbo.udp_job_pricelist_nuribot_gc_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:53:43.72
 *        Modify: 2018-05-13 19:53:43.72
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE  proc udp_job_pricelist_nuribot_gc_ins
	@sdate smalldatetime = null
as
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 // 2014.10.16
	-- 설  명 : 일괄매칭 작업 추출
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- 수정일:		수정자:		수정내용:
	-- ----------------------------------------------------------------------------------
	-- 2008.09.09	wookki25	처리 : 
	--                          사유 : 
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level  read uncommitted

	if @sdate is null begin
		set @sdate = convert(varchar(10), getdate()-1, 120)
	end

	delete from job_pricelist_nuribot_gc where regdate = @sdate
	
	insert into job_pricelist_nuribot_gc(pl_no, pl_vcode, pl_modelno, pl_category, regdate)
	select jp_plistno, jp_vcode, jp_modelno, g_category, @sdate
	from (
		select jp_plistno, jp_vcode, max(jp_modelno) jp_modelno 
		from job_pricelist 
		where jp_id like 'nuribot_gc%'
		and jp_date>= @sdate and jp_date < @sdate+1 and not exists (select top 1 pl_no from job_pricelist_nuribot_gc  where pl_no = jp_plistno)
		group by jp_plistno, jp_vcode
		) a 
			left outer join 
		analstore.dbo.goods on jp_modelno=g_modelno   
		

