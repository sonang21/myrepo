/* *************************************************************************
 * NAME : dbo.udp_cm_perf_result_joblog_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:36:57.8
 *        Modify: 2018-05-10 15:36:57.8
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cm_perf_result_joblog_agg
	@agg_date smalldatetime = null
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-06-27
	-- 설  명 : id별 집계.작업량
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2014.10.01		wookki25		예외처리 : 분류통합 삭제 http://58.234.199.100/redmine/issues/2494
	2016.10.19		wookki25		[ 유사->일반 ] 특정 분류에서만 작업량으로 표시 -> 전체 분류
									
	*/
	set @agg_date = isnull(@agg_date, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime))

	-- 공통사항
	select g_modelno, g_category, g_spec2, jg_id, jg_flag
	into #job_goods
	from 
	(
		select	distinct jg_modelno, jg_flag, jg_id
		from	job_goods			
		where	jg_flag in ('0','8','B','9','p','m') -- 0-모델추가(일반), 1-요약카탈, 8-모델추가(그룹모델),  B-모델추가_SGM, 9-유사->일반, p-제조사품번, m-에누리모델명
		and		jg_date >= @agg_date and jg_date < @agg_date+1
		and		jg_id in (select mm_id from simpledb.dbo.mm_enuri_cm)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	where g_jobcode>'0' 

	
	-- 카탈로그 추가개수
	-- jg_flag = '0' : 모델추가=요약카탈=Catal 추가
	
	-- 분류별
	delete from tbl_cm_perf_result_joblog where item_no = 6 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 	6 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''-- and (jg_flag in ('0','8','B','p','m') or (jg_flag ='9' and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') ))  -- cm2만
	group by left(g_category,4)

	-- 아이디별
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 6 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 	6 item_no, jg_id, @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where isnull(g_spec2,'') <> ''-- and (jg_flag in ('0','8','B','p','m') or (jg_flag ='9' and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') ))  -- cm2만
	group by jg_id


--	2014.12.04 // 사용안한다고해서 주석처리함.
--	--jg_flag = '1' : 일반카탈=상세카탈 : 분류별
--	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
--	select 	7 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
--	from #job_goods 
--	where jg_flag = '1'  and isnull(g_spec2,'') <> ''
--	and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') -- cm2만
--	/* 2014.07.09
--	2. 스포츠(09) 내 분류 자동카탈로그 소분류 실적 미집계 요청.. 
--		상세카탈로그카탈만 해당
--
--	- 자동카탈로그는 해당 분류 및 담당자 실적에 포함되지 않도록 요청드립니다.
--	  해당분류)		 스포츠화/잡화(0919) > 런닝화(091902), 캐주얼화(091901), 샌들,슬리퍼(091904), 트레이닝화(091911), 워킹화(091914)
--					등산화/등산용품(0903) > 경등산화(090317), 중등산화(090318), 트레킹,트레일런닝화(090319). 릿지,암벽화(090320), 배낭(090302), 등산스틱(090323)
--					아웃도어/등산의류(0923) > 상의_남성(092302), 하의_남성(092303), 자켓_남성(092318), 상의_여성(092319), 하의_여성(092320), 자켓_여성(092321)
--	*/
--	and g_category not like '09190[124]%'
--	and g_category not like '09191[14]%'
--
--	and g_category not like '09031[789]%'
--	and g_category not like '09032[03]%'
--	and g_category not like '09030[2]%'
--
--	and g_category not like '09230[23]%'
--	and g_category not like '09231[89]%'
--	and g_category not like '09232[01]%'
--	group by left(g_category,4)

--	2014.12.04 // 사용안한다고해서 주석처리함.
--	--jg_flag = '1' : 일반카탈=상세카탈 : 아이디별
--	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
--	select 	7 item_no, jg_id, @agg_date, count(*) g_add_cnt 
--	from #job_goods 
--	where jg_flag = '1'  and isnull(g_spec2,'') <> ''
--	and (g_category like '0[89]__%' or g_category like '1[04568]__%' or g_category like '2[3]__%' or g_category like '93__%') -- cm2만
--	/* 2014.07.09
--	2. 스포츠(09) 내 분류 자동카탈로그 소분류 실적 미집계 요청.. 
--		상세카탈로그카탈만 해당
--
--	- 자동카탈로그는 해당 분류 및 담당자 실적에 포함되지 않도록 요청드립니다.
--	  해당분류)		 스포츠화/잡화(0919) > 런닝화(091902), 캐주얼화(091901), 샌들,슬리퍼(091904), 트레이닝화(091911), 워킹화(091914)
--					등산화/등산용품(0903) > 경등산화(090317), 중등산화(090318), 트레킹,트레일런닝화(090319). 릿지,암벽화(090320), 배낭(090302), 등산스틱(090323)
--					아웃도어/등산의류(0923) > 상의_남성(092302), 하의_남성(092303), 자켓_남성(092318), 상의_여성(092319), 하의_여성(092320), 자켓_여성(092321)
--	*/
--	and g_category not like '09190[124]%'
--	and g_category not like '09191[14]%'
--
--	and g_category not like '09031[789]%'
--	and g_category not like '09032[03]%'
--	and g_category not like '09030[2]%'
--
--	and g_category not like '09230[23]%'
--	and g_category not like '09231[89]%'
--	and g_category not like '09232[01]%'
--	group by jg_id



	--jg_flag = '8' : 그룹매칭 추가
	-- 분류별
	delete from tbl_cm_perf_result_joblog where item_no = 10 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 	10 item_no, left(g_category,4), @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where jg_flag = '8' 
	group by left(g_category,4)

	-- 아이디별
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 10 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 	10 item_no, jg_id, @agg_date, count(*) g_add_cnt 
	from #job_goods 
	where jg_flag = '8' 
	group by jg_id
	
/*
job_pricelist.jp_flag 
0 : 번호입력 (=모델번호)
1 : 가격저장 (=기타)
2 : 가격추가 (=추가)
3 : 가격삭제 (=삭제)
4 : 분류변경 (=분류변경)
5 : 번호입력(그룹매칭)
6 : 번호입력(동일상품그룹매칭)
*/

	-- pricelist 매칭개수 : 분류별
	delete from tbl_cm_perf_result_joblog where item_no = 8 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog( item_no, category, result_date, result_cnt )
	select 8 item_no, left(g_category,4) category, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, count(distinct jp_plistno) cnt
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6','p','m') 
		and jp_date>=@agg_date and jp_date < @agg_date+1
		and jp_id in (select mm_id  from simpledb.dbo.mm_enuri_cm)
		group by jp_modelno
	) a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	group by left(g_category, 4)

	-- pricelist 매칭개수 : 아이디별
	delete from tbl_cm_perf_result_joblog_by_id where item_no = 8 and result_date = @agg_date

	insert into tbl_cm_perf_result_joblog_by_id( item_no, mm_id, result_date, result_cnt )
	select 8 item_no, jp_id, @agg_date, sum(cnt) p_matching_cnt
	from
	(
		select  jp_modelno, jp_id, count(distinct jp_plistno) cnt
		from job_pricelist 
		where jp_modelno>0 and jp_flag in ('0', '5', '2', '6','p','m') 
		and jp_date>=@agg_date and jp_date < @agg_date+1
		and jp_id in (select mm_id  from simpledb.dbo.mm_enuri_cm)
		group by jp_modelno, jp_id
	) a inner join analstore.dbo.goods b on jp_modelno = g_modelno
	and g_category not like '00%' and g_category like '[0123456789]___%'
	group by jp_id


	-- 가상분류 구분
	update tbl_cm_perf_result_joblog set is_realcate = 0 
	where not exists(select top 1 1 from tbl_cm_perf_ref_real_mcate where left(tbl_cm_perf_result_joblog.category, 4)  = tbl_cm_perf_ref_real_mcate.category)
	and result_date = @agg_date


	-- ---------------------------------------------------
	-- 추가된 모델 별도로 입력: 제대로 안된 모델은 미포함한다. 
	-- ---------------------------------------------------
	insert into tbl_cm_perf_ref_add_model
	select @agg_date, g_category, g_modelno
	from 
	(
		select	distinct jg_modelno
		from	job_goods			
		where	jg_flag = '0'
		and		jg_date >= @agg_date and jg_date < @agg_date+1
		and		jg_id in (select mm_id from simpledb.dbo.mm_enuri_cm)
	) a inner join analstore.dbo.goods b on jg_modelno = g_modelno
	where g_jobcode>'0' and isnull(g_spec2,'') <> ''
	and g_category not like '00%' and g_category like '[0123456789]___%'


	-- ---------------------------------------------------
	-- 예외처리 : 분류통합
	-- ---------------------------------------------------
	-- 분류통합1 : - 2211: 2211 + 2212 + 2213 + 2222 + 2223 + 2226 + 2227 + 2228
--	select item_no, '2211' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	into #x
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('2211','2212','2213','2222','2223','2227','2228')
--	group by item_no
--	union all
	-- 분류통합2 : - 2241: 2241 + 2242 + 2243 + 2244
--	select item_no, '2241' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('2241', '2242','2243','2244')
--	group by item_no
--
--	delete from tbl_cm_perf_result_joblog where result_date = @agg_date and category in ('2211','2241')
--
--	insert into tbl_cm_perf_result_joblog(item_no, category, result_date, result_cnt, is_realcate)
--	select item_no, category, result_date, result_cnt, is_realcate from #x


--if @agg_date between cast('2014-08-27' as smalldatetime) and cast('2014-08-31' as smalldatetime) begin
--	-- ---------------------------------------------------
--	-- 예외처리 : 분류통합..기간제한
--	-- ---------------------------------------------------
--	-- 분류통합1 : - 1614 : 1614 + 2303
--	select item_no, '1614' category, @agg_date result_date, sum(result_cnt) result_cnt, 1 is_realcate
--	into #y
--	from tbl_cm_perf_result_joblog
--	where result_date = @agg_date and left(category,4) in ('1614','2303')
--	group by item_no
	

--	delete from tbl_cm_perf_result_joblog where result_date = @agg_date and category in ('1614')

--	insert into tbl_cm_perf_result_joblog(item_no, category, result_date, result_cnt, is_realcate)
--	select item_no, category, result_date, result_cnt, is_realcate from #y
--end






