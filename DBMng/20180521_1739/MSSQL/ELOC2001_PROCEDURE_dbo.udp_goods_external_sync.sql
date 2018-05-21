/* *************************************************************************
 * NAME : dbo.udp_goods_external_sync
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-07 16:37:23.503
 *        Modify: 2018-05-03 17:23:35.403
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_goods_external_sync
as 
begin
	set nocount on 
	--set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.07
	-- 설  명 : 속성  작업내역 sync
	--		주기는 10분으로 하자. 5, 15, 25, 35, 45, 55 에 처리
	--		비고란도 sync 처리 해야한다. // 2017.02.14 // 박현준
	--		작업로그 남겨야한다.	
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	
	*/

	-- ----------------------------------
	-- sync 주기 설정
	-- ----------------------------------
	-- drop table #sync_target
	-- 주기 설정
	-- 주기 설정이 변경되면 agent 스케쥴링도 변경되어야 함 : 스케쥴링은 (주기+1)분에 실행 후 매 주기분 마다 반복 실행되도록 설정 필요
	-- 주기가 10분인 경우 매 10분마다 11분, 21분, 31분..에 실행, 주기가 15분인 경우 매 15분마다 16분, 31분,  46분..에 실행
	-- ----------------------------------
	/*
	-- sync 예약작업 확인
	create table tbl_gs_sync_history(
		job_date datetime
	,	sdate	datetime
	,	edate	datetime
	)
	insert into tbl_gs_sync_history
	select getdate(), @sdate, @edate

	select * from tbl_gs_sync_history order by 1
	*/

	declare @interval int = 10 -- 주기 10분

	declare @edate datetime, @sdate datetime
	set @edate = cast(convert(char(14), getdate(), 25)+convert(char(2), (datepart(minute, getdate())/@interval)*@interval) as datetime)
	set @sdate = dateadd(mi, -@interval, @edate)
	-- select getdate(), @sdate, @edate
	-- ----------------------------------
	-- sync 대상 찾기
	-- ----------------------------------


	-- 오늘 데이터 : job_pricelist
	select * 
	into #target_job_log
	from logdb.dbo.job_pricelist a with (readuncommitted)
	where jp_vcode in (75, 7871)
	and jp_flag in ('0','5','6','M','N','P','S') -- 
	and jp_id <> 'nuribot_sync' -- 누리봇에서 수행한 g2->g1 sync 작업은 제외. 누리봇은 g2->g1만 sync작업한다.
	and jp_id <> 'dbagent_sync' -- sync작업에서 수행한 g2<->g1 sync 작업은 제외.
	and jp_date >= @sdate
	and jp_date <  @edate


	-- 어제 데이터 : job_pricelist_old
	If OBJECT_ID('logdb.dbo.job_pricelist_old') is not null  begin -- rename 오류로 테이블 없는 경우 오류 처리

		-- 자정에 테이블명 rename하는 동안의 데이터 참조하는 경우
		-- old 테이블 참조한다.
		if (cast(@sdate as date) <> cast(@edate as date) or @sdate < dateadd(mi, 10, cast(cast(@sdate as date) as datetime)) ) begin
			insert into #target_job_log
			select * 
			from logdb.dbo.job_pricelist_old a  with (readuncommitted)
			where jp_vcode in (75, 7871)
			and jp_flag in ('0','5','6','M','N','P','S') -- 
			and jp_id <> 'nuribot_sync' -- 누리봇에서 수행한 g2->g1 sync 작업은 제외. 누리봇은 g2->g1만 sync작업한다.
			and jp_id <> 'dbagent_sync' -- sync작업에서 수행한 g2<->g1 sync 작업은 제외.
			and jp_date >= @sdate
			and jp_date <  @edate
		end

	end 



	select jp_vcode, jp_modelno, pl_goodscode, pl_goodscode_cs, pl_note, pl_category
	into #sync_target
	from 
	(
		select jp_vcode, jp_modelno, jp_plistno, jp_date, b.pl_goodscode, b.pl_goodscode_cs, b.pl_note, b.pl_category
		, rank() over (partition by b.pl_goodscode order by jp_date desc) rnk_goodscode 
		from #target_job_log a inner join eloc2001.dbo.pricelist b  with (readuncommitted) on a.jp_plistno = b.pl_no

		--select jp_vcode, jp_modelno, jp_plistno, jp_date, b.pl_goodscode, b.pl_goodscode_cs, b.pl_note, b.pl_category
		--, rank() over (partition by b.pl_goodscode order by jp_date desc) rnk_goodscode 
		--from logdb.dbo.job_pricelist a inner join eloc2001.dbo.pricelist b on a.jp_plistno = b.pl_no
		--where jp_vcode in (75, 7871)
		--and jp_flag in ('0','5','6','M','N','P','S') -- 
		--and jp_id <> 'nuribot_sync' -- 누리봇에서 수행한 g2->g1 sync 작업은 제외. 누리봇은 g2->g1만 sync작업한다.
		--and jp_id <> 'dbagent_sync' -- sync작업에서 수행한 g2<->g1 sync 작업은 제외.
		--and jp_date >= @sdate
		--and jp_date <  @edate
	) a 
	where rnk_goodscode = 1 -- 상품코드별 마지막 작업 내역

	 
	-- ----------------------------------
	-- GS1 --> GS2 Sync
	-- ----------------------------------
	-- 분할상품 제외 // sr21705 // 2017.03.30 조건 추가
	delete from #sync_target
	where jp_vcode = 75 and pl_goodscode in 
	(
		select b.pl_goodscode
		from eloc2001.dbo.pricelist a  with (readuncommitted) inner join #sync_target b 
			on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
		where a.pl_vcode = 75 and b.jp_vcode = 75
		group by b.pl_goodscode
		having count(*) > 1
	)

	-- 모델번호 Sync
	update a
	set pl_modelno = b.jp_modelno
	,	pl_category = b.pl_category
		-- 비고(pl_note)에 '정보 불분명' 입력은 gs1에서 gs2 입력시에만 해당
	,	pl_note = case when b.jp_modelno < 0 and isnull(replace(b.pl_note, ' ', ''), '')  = '' then '정보 불분명' else b.pl_note end -- 문구는 수정할 수 있다. // 2017.02.01	
		-- 모델 번호작업 로그 남긴다
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 7871 and b.jp_vcode = 75 and a.pl_modelno <> b.jp_modelno -- 모델번호 다른 경우, 신규매칭 or 재매칭 처리
	and b.jp_modelno >= 0 -- sr21288 // 2017.03.09 조건 추가
	and b.pl_category not like '93%' -- sr21635 //2017.03.28 조건 추가 

	-- 모델번호 Sync
	update a
	set pl_modelno = 0
		-- 모델 번호작업 로그 남긴다
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 7871 and b.jp_vcode = 75 and a.pl_modelno <> b.jp_modelno -- 모델번호 다른 경우, 신규매칭 or 재매칭 처리
	and b.jp_modelno < 0 -- sr21705 // 2017.03.30 조건 추가
	and b.pl_category not like '93%' -- sr21635 //2017.03.28 조건 추가 

	-- ----------------------------------
	-- GS2 --> GS1 
	-- ----------------------------------
	-- 분할상품 제외
	delete from #sync_target
	where jp_vcode = 7871 and pl_goodscode in 
	(
		select b.pl_goodscode
		from eloc2001.dbo.pricelist a  with (readuncommitted) inner join #sync_target b 
			on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
		where a.pl_vcode = 75 and b.jp_vcode = 7871
		group by b.pl_goodscode
		having count(*) > 1
	)

	-- 모델번호 Sync
	update a
	set pl_modelno = b.jp_modelno
	,	pl_category = b.pl_category
	,	a.pl_note = b.pl_note -- 비고 
	,	a.pl_status = case when a.pl_status = '0' then '1' else a.pl_status end  -- 오라클에 upload 한다.

		-- 모델 번호작업 로그 남긴다
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 75 and b.jp_vcode = 7871 and a.pl_modelno <> b.jp_modelno -- 모델번호 다른 경우, 신규매칭 or 재매칭 처리

	-- 오라클에 데이터 입력 : 웹이미지 생성용 // 2017.02.20	// @edate 이후에 싱크 처리된 데이터
	insert openquery(ORADB, 'select modelno from TBL_GS_SYNC_MODELNO')
	select jp_modelno from logdb.dbo.job_pricelist  with (readuncommitted) where jp_date >= @edate and jp_vcode = 75 and jp_id  = 'dbagent_sync' and jp_flag='0' and jp_modelno > 0

end


