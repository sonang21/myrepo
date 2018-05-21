/* *************************************************************************
 * NAME : dbo.udp_mss_srv_normal_apply
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-03-13 11:15:21.68
 *        Modify: 2018-05-03 17:23:34.92
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_mss_srv_normal_apply
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작 성 자: wookki25 / 20180313
	-- 설   명 : 누리봇에서 0 - >3 처리한 pl_no 다시  3->0 처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	--create table #target_plno(pl_no bigint)
	create table #apply_plno(pl_no bigint)

	-- 0. 데이터사이언스팀에서 추출한 3->0 대상 가져오기
	--update mss_srv_normal_list
	--   set result = 1
	--output deleted.pl_no
	select pl_no 
	  into #target_plno
	  from mss_srv_normal_list 
	 where result = 0
	   and regdate > cast(getdate() as date)
	option (maxdop 1)
	--(11117개 행이 영향을 받음)

	-- 1. pricelist 반영
	update a 
	   set pl_status = (case when pl_status < '3' then '1' else pl_status end)
		 , pl_date = (case when pl_status < '3' then pl_date else getdate() end)
		 , pl_srvflag = '0'
	output deleted.pl_no
	  into #apply_plno(pl_no)
	  -- select count(*)
	  from pricelist a inner join #target_plno b on a.pl_no = b.pl_no
	 where pl_srvflag = '3'
	option (maxdop 1)
	-- (11017개 행이 영향을 받음)
	
	-- 2. 통계용 데이터 저장
	insert into pricelist_dml_log (pl_no, pl_category, pl_modelno, p_status, mm_id, log_flag, p_date)
	select a.pl_no
	     , pl_category
		 , pl_modelno
		 , 'I'
		 , 'SCI_BATCH'
		 , '2'
		 , getdate()
	  from pricelist a inner join #apply_plno b on a.pl_no = b.pl_no

	-- 3. 작업로그 저장
	-- exec USP_JOB_PRICELIST_INS_2 참조
	insert into logdb.dbo.job_pricelist (jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile, jp_note)
	select a.pl_no, pl_modelno, pl_vcode, 'SCI_REAL0_BATCH', '1', getdate(), pl_goodsnm, pl_price, pl_category, pl_instance_price, pl_note
	  from pricelist a 
	       inner join 
		   #apply_plno b 
		   on a.pl_no = b.pl_no

	-- 4. 작업로그 기록
	-- exec USP_JOB_PRICELIST_INS_2 참조
	update a
	   set result = 1
	  from mss_srv_normal_list  a 
	       inner join #apply_plno b on a.pl_no = b.pl_no
	 where result = 0
	   and regdate > cast(getdate() as date)
	option (maxdop 1)



	-- 5. oracle 원본 데이터에 반영 표시	
	set transaction isolation level read committed
	declare @qry varchar(8000)
	declare @pl_no bigint
	declare fetch_cursor cursor for
	select pl_no
	  from #apply_plno
	order by pl_no
	
	open fetch_cursor	
	fetch next from fetch_cursor into @pl_no
	while @@fetch_status = 0
	begin
		set @qry = '
			UPDATE OPENQUERY(ORADB, ''
				SELECT PL_NO, PRICE_CHECK, DEL_FLAG
				  FROM TBL_MINI_NURIBOT_LOG
				 WHERE PL_NO = ' + cast(@pl_no as varchar(100)) + ' AND PRICE_CHECK = ''''2'''' AND DEL_FLAG <> ''''Y''''''
			)
			SET DEL_FLAG = ''Y''
			'
		exec (@qry)

		insert into tmp_wookki25_20180321(pl_no) select @pl_no

		fetch next from fetch_cursor into @pl_no
	end
	close fetch_cursor
	deallocate fetch_cursor
end

