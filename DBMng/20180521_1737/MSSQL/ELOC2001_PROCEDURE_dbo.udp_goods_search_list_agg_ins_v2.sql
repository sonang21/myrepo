/* *************************************************************************
 * NAME : dbo.udp_goods_search_list_agg_ins_v2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-02-28 14:51:11.47
 *        Modify: 2018-05-03 17:23:34.71
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE PROC udp_goods_search_list_agg_ins_v2
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-02-28
	-- 설  명 : pricelist 상품매칭 일별 통계 집계
	--			처리그룹여부   : 그룹내에 있는 상품중 한상품이라도 처리 또는 제외한 그룹의 수
	--			미처리그룹여부 : 그룹내에 있는 모든 상품을 미처리한 경우 그룹의 수
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2012.08.30		wookki25		리스트제외처리 상품 백업 : 관리자가 제외키워드에 입력하기위해 // 정우영 요청
	2013.06.27		wookki25		유사상품_자동_매칭_그룹 추가
	2014.10.21		wookki25		집계시간  pm 11:50 --> pm 06:00
									최근 7일 데이터 유지 --> truncate table tbl_goods_search_list
	*/


	-- 당일 정오(12:00) 이전 백업되고, 자정 이전에 등록됐던 데이터는 삭제.
	-- (= 전일 집계에 포함되고 삭제된 데이터)
	delete from tbl_goods_search_list_daily_back 
	where regdate < cast(convert(varchar(10), getdate(), 120) as datetime)
	and delete_date < dateadd(hh, 12, cast(convert(varchar(10), getdate(), 120) as datetime))


	-- 집계내역이 이미 있는 경우 먼저 삭제한다.
	delete from tbl_goods_search_list_agg_v2
	where agg_date>= cast(convert(varchar(10), getdate(), 120) as smalldatetime)
	and agg_date <  cast(convert(varchar(10), getdate()+1, 120) as smalldatetime)

	-- 데이터 통합 : 최종 남아있는 데이터 +  삭제한 데이터
	--drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	if object_id('tmp_worker_1_in_udp_goods_search_list_agg_ins_v2') is not null begin
		drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	end
	select * into tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	from 
	(
		-- 삭제한 시간(hh:mm)으로 삭제한 데이터 그룹핑(tmp_group)
		select shop_code, pl_no, ca_mcode, pl_no_group, job_flag, regdate, ca_code, modelno, model_ca_code, order_by, convert(varchar(5), getdate(), 108) tmp_group , goodsnm, goodscode, price, minprice, store_flag
		from tbl_goods_search_list
		union all
		select shop_code, pl_no, ca_mcode, pl_no_group, job_flag, regdate, ca_code, modelno, model_ca_code, order_by, convert(varchar(5), delete_date, 108) tmp_group, goodsnm, goodscode, price, minprice, store_flag
		from tbl_goods_search_list_daily_back
		where delete_date >= cast(convert(char(10), getdate(), 120)  as smalldatetime)
	) all_day_data


	-- 임시
--	if getdate() < cast( '2013-02-19' as datetime) begin
--		select * into tmp_20130218_wookki25_그룹매칭_통계_모니터링_23시 from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
--	end


	-- 데이터 삭제 : mp에서 보이지 않게 처리한 상품 삭제처리 //mp에서 그룹상품 제외한 상품 제외처리 // 그룹별로 상품이 1개
	delete a
	from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a 
			inner join 
	(
		select tmp_group, ca_mcode, pl_no_group 
		from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 
		group by tmp_group, ca_mcode, pl_no_group
		having count(*)=1
	)  b
		on a.tmp_group = b.tmp_group and a.ca_mcode = b.ca_mcode and a.pl_no_group = b.pl_no_group 

	-- 중복제거 : 동일한 그룹에 동일한 pl_no가 이전 타임에 있었다면 이전 타임에 있는 데이터 삭제.
	delete a 
	--select a.pl_no, b.pl_no 
	from	tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a 
				inner join 
			tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 b 
				on a.pl_no_group = b.pl_no_group and a.pl_no = b.pl_no
	where a.regdate < b.regdate


	-- 분류별 전일 리스트제외 처리 데이터 백업 : 2012.08.30	-- 주말제외..최근 열흘	insert into tbl_goods_search_list_except_list
	select ca_mcode, goodsnm, goodscode, getdate(), shop_code, a.pl_no
	from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a inner join pricelist b on a.pl_no = b.pl_no 
	where job_flag = '2' and pl_modelno = 0 -- 리스트제외 // 2012.09.25 // pl_modelno = 0인 데이터로 제한 // 정우영

	-- 그룹개수
	insert into tbl_goods_search_list_agg_v2
	(	category
		,g_raw_t_cnt,g_raw_vm_cnt,g_raw_vm_min_cnt,g_raw_nm_cnt
--		,g_nwork_t_cnt,g_nwork_vm_cnt,g_nwork_nm_cnt
		,g_work_t_cnt,g_work_mm_cnt,g_work_mm_min_cnt,g_work_wm_cnt,g_work_etc_cnt


		,p_raw_t_cnt,p_raw_vm_cnt,p_raw_vm_min_cnt,p_raw_nm_cnt
--		,p_nwork_t_cnt,p_nwork_vm_cnt,p_nwork_nm_cnt
		,p_work_t_cnt,p_work_mm_cnt,p_work_mm_min_cnt,p_work_wm_cnt,p_work_etc_cnt

		,agg_date

		,g_work_auto_cnt,p_work_auto_cnt
		,g_raw_multi_cnt
		--,g_nwork_multi_cnt
		,g_work_multi_cnt,p_raw_multi_cnt
		--,p_nwork_multi_cnt
		,p_work_multi_cnt
		,g_work_auto_m_cnt,p_work_auto_m_cnt
		
		-- 백화점
		,p_raw_s_t_cnt,p_raw_s_vm_cnt,p_raw_s_vm_min_cnt,p_raw_s_nm_cnt
		,p_work_s_t_cnt,p_work_s_mm_cnt,p_work_s_mm_min_cnt,p_work_s_wm_cnt,p_work_s_etc_cnt

		,p_work_s_auto_cnt,p_raw_s_multi_cnt, p_work_s_multi_cnt,p_work_s_auto_m_cnt
	)
	select	[중분류코드] = mcate
	-- 그룹별 집계
		-- 총그룹 : 가상매칭 유무로 구분
		,	[총합] = count(*)															-- 총그룹_총 개수
		,	[매칭] = sum(sign([상품별_가상매칭_여부]))									-- 총그룹_가상매칭 그룹 개수	// 가상매칭된 상품이 1개라도 그룹에 있으면 [매칭]에 카운팅
		,	[매칭_최저] = sum(sign([상품별_가상매칭_여부_최저가여부]))						-- 총그룹_가상매칭 그룹 개수중 최저가 있는 그룹수	// 가상매칭된 상품이 1개라도 그룹에 있으면 [매칭]에 카운팅
		,	[추가] = count(*) - sum(sign([상품별_가상매칭_여부])) - sum(sign(상품별_다중매칭_여부)) -- 총그룹_가상미매칭 그룹 개수	// 그외는 [추가]에 카운팅

		-- 미처리그룹 : 가상매칭 유무로 구분
/*
		,	[총합] = sum([그룹별_미처리_여부])+sum([그룹별_다중매칭_미처리_여부] * sign([상품별_다중매칭_여부]))															-- 미처리 그룹별_총 개수
		,	[매칭] = sum([그룹별_미처리_여부] * sign([상품별_가상매칭_여부]))							-- 미처리 그룹별_가상매칭 그룹 개수
		,	[추가] = sum([그룹별_미처리_여부]) - sum([그룹별_미처리_여부]*sign([상품별_가상매칭_여부]))	-- 미처리 그룹별_가상미매칭 그룹 개수
*/

		-- 처리그룹 : 번호작업 유무로 구분 , 가상매칭 유무는 무관.
		,	[총합] = sum([그룹별_처리_여부])+sum([그룹별_다중매칭_번호수작업_처리_여부])-- 처리그룹_총 개수
		,	[매칭] = sum([그룹별_번호수작업_처리_여부])									-- 처리그룹_기존 상품 번호작업한 그룹 개수\
		,	[매칭_최저] = sum(sign([그룹별_번호수작업_처리_여부_최저가여부]))						-- 총그룹_가상매칭 그룹 개수중 최저가 있는 그룹수	// 가상매칭된 상품이 1개라도 그룹에 있으면 [매칭]에 카운팅
		,	[추가] = sum([그룹별_웹상품추가_처리_여부])									-- 처리그룹_웹상품추가 후 번호작업한 그룹 개수
		,	[기타] = sum([그룹별_번호작업외_처리_여부]+[그룹별_리스트제외_처리_여부])	-- 처리그룹_번호작업외 그룹 개수 + 리스트제외 그룹 개수

	-- 상품별 집계
		-- 총상품
		,	[총합] = sum([상품별_총상품수])+sum([상품별_다중매칭_총상품수])
		,	[매칭] = sum([상품별_가상매칭_여부])
		,	[매칭_최저] = sum([상품별_가상매칭_여부_최저가여부])
		,	[추가] = sum([상품별_총상품수]) - sum([상품별_가상매칭_여부]) -- 추가 = 총합 - 매칭

		-- 미처리 상품
/*
		,	[총합] = sum([상품별_미처리_여부]) + sum([상품별_다중매칭_미처리_여부])
		,	[매칭] = sum([상품별_미처리_가상매칭_여부])
		,	[추가] = sum([상품별_미처리_여부]) - sum([상품별_미처리_가상매칭_여부]) -- 추가 = 총합 - 매칭
*/
		-- 처리상품
		,	[총합] = sum([상품별_처리_여부])+sum([상품별_다중매칭_처리_여부])	
		,	[매칭] = sum([상품별_번호수작업_처리_여부])		
		,	[매칭_최저] = sum([상품별_번호수작업_처리_여부_최저가여부])		
		,	[추가] = sum([상품별_웹상품추가_처리_여부])
		,	[기타] = sum([상품별_번호작업외_처리_여부]+[상품별_리스트제외_처리_여부])

	
	-- 집계일
		,	[집계일] = getdate()

	-- 유사상품 모델 추가후 자동 매칭 처리개수
		,	[유사상품_추가후_자동_매칭_그룹] = sum([그룹별_번호유사상품_처리_여부])
		,	[유사상품_추가후_자동_매칭_상품] = sum([상품별_번호유사상품_처리_여부])

	-- 다중매칭
		,	[다중매칭_총그룹]= sum(sign(상품별_다중매칭_여부))
/*
		,	[다중매칭_미처리그룹] = sum([그룹별_다중매칭_미처리_여부] * sign([상품별_다중매칭_여부]))
*/

		,	[다중매칭_처리그룹] = sum([그룹별_다중매칭_번호수작업_처리_여부])
		,	[다중매칭_총상품] = sum([상품별_다중매칭_총상품수])
/*
		,	[다중매칭_미처리상품] =  sum([상품별_다중매칭_미처리_여부])
*/
		,	[다중매칭_처리상품] = sum([상품별_다중매칭_처리_여부])

	-- 유사상품 이미 존재하는 모델에 매칭 처리개수
		,	[유사상품_자동_매칭_그룹] = sum([그룹별_번호유사상품_자동매칭_처리_여부])
		,	[유사상품_자동_매칭_상품] = sum([상품별_번호유사상품_자동매칭_처리_여부])


		-- 총상품(백화점)
		,	[총합_백화점] = sum([상품별_총상품수_백화점])+sum([상품별_다중매칭_총상품수_백화점])
		,	[매칭_백화점] = sum([상품별_가상매칭_여부_백화점])
		,	[매칭_최저_백화점_백화점] = sum([상품별_가상매칭_여부_최저가여부_백화점])
		,	[추가_백화점] = sum([상품별_총상품수_백화점]) - sum([상품별_가상매칭_여부_백화점]) -- 추가 = 총합 - 매칭


		,	[총합_백화점] = sum([상품별_처리_여부_백화점])+sum([상품별_다중매칭_처리_여부_백화점])	
		,	[매칭_백화점] = sum([상품별_번호수작업_처리_여부_백화점])		
		,	[매칭_최저_백화점] = sum([상품별_번호수작업_처리_여부_최저가여부_백화점])		
		,	[추가_백화점] = sum([상품별_웹상품추가_처리_여부_백화점])
		,	[기타_백화점] = sum([상품별_번호작업외_처리_여부_백화점]+[상품별_리스트제외_처리_여부_백화점])


		,	[유사상품_추가후_자동_매칭_상품_백화점] = sum([상품별_번호유사상품_처리_여부_백화점])
		,	[다중매칭_총상품_백화점] = sum([상품별_다중매칭_총상품수_백화점])
		,	[다중매칭_처리상품_백화점] = sum([상품별_다중매칭_처리_여부_백화점])
		,	[유사상품_자동_매칭_상품_백화점] = sum([상품별_번호유사상품_자동매칭_처리_여부_백화점])


	from
	(
			select	pl_no_group,	max(ca_mcode) as mcate
			-- 그룹별 집계
			--,	[그룹별_가상매칭_여부] = sign([상품별_가상매칭_여부]) = (case when max(modelno) > 0 and patindex(max(ca_mcode)+'%', max(model_ca_code))=1 then 1 else 0 end)
			--,	[그룹별_미처리_여부] = (case when max(job_flag) = '0' then 1 else 0 end)
			,	[그룹별_처리_여부] = (case when max(job_flag) <> '0' then 1 else 0 end)
			,	[그룹별_번호작업외_처리_여부] = (case when max(job_flag) in ('1', '2') and sum(case when job_flag = '1' then 1 else 0 end) >= 1 then 1 else 0 end)	-- 번호매칭 이외 pricelist 변경
			,	[그룹별_리스트제외_처리_여부] = (case when max(job_flag) = '2' and sum(case when job_flag = '1' then 1 else 0 end) = 0 then 1 else 0 end)		-- 리스트제외
			,	[그룹별_웹상품추가_처리_여부] = (case when max(job_flag) = '3' then 1 else 0 end)								-- 웹상품 추가 후 pricelist 번호매칭

			,	[그룹별_번호수작업_처리_여부] = (case when max(job_flag) = '4' then 1 else 0 end)								-- 기존상품 pricelist 번호매칭
			,	[그룹별_번호수작업_처리_여부_최저가여부] = (case when max(job_flag) = '4' and min(price) <= min(minprice) then 1 else 0 end)								-- 기존상품 pricelist 번호매칭

			,	[그룹별_번호유사상품_처리_여부] = (case when max(job_flag) = '5' then 1 else 0 end)								-- 유사상품 모델 추가후 자동 매칭 처리개수
			,	[그룹별_번호유사상품_자동매칭_처리_여부] = (case when max(job_flag) = '6' then 1 else 0 end)					-- 유사상품 이미 존해하는 모델에 매칭 처리개수

			

			-- 상품별 집계
			,	[상품별_총상품수] = count(*)

			,	[상품별_가상매칭_여부] = sum(case when modelno > 0 then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[상품별_가상매칭_여부_최저가여부] = sum(case when modelno > 0 and price <= minprice then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1

			--,	[상품별_미처리_여부] = sum(case when job_flag = '0' then 1 else 0 end)

/*
			,	[상품별_미처리_가상매칭_여부] = sum(case when job_flag = '0' and modelno > 0 then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
*/			


			,	[상품별_처리_여부] = sum(case when job_flag <> '0' then 1 else 0 end)
			,	[상품별_번호작업외_처리_여부] = sum(case when job_flag = '1' then 1 else 0 end)
			,	[상품별_리스트제외_처리_여부] = sum(case when job_flag = '2' then 1 else 0 end)
			,	[상품별_웹상품추가_처리_여부] = sum(case when job_flag = '3' then 1 else 0 end)

			,	[상품별_번호수작업_처리_여부] = sum(case when job_flag = '4' then 1 else 0 end)
			,	[상품별_번호수작업_처리_여부_최저가여부] = sum(case when job_flag = '4' and price <= minprice then 1 else 0 end)

			,	[상품별_번호유사상품_처리_여부] = sum(case when job_flag = '5' then 1 else 0 end)
			,	[상품별_번호유사상품_자동매칭_처리_여부] = sum(case when job_flag = '6' then 1 else 0 end)
/*
			,	[그룹별_다중매칭_미처리_여부] =0
*/
			,	[그룹별_다중매칭_번호수작업_처리_여부] = 0
			,	[상품별_다중매칭_총상품수] =0
			,	[상품별_다중매칭_여부] = 0
			
/*
			,	[상품별_다중매칭_미처리_여부] = 0
*/
			,	[상품별_다중매칭_처리_여부] = 0

			-- 백화점 상품별 집계
			,	[상품별_총상품수_백화점] = sum(case when store_flag='1' and store_flag='1' then 1 else 0 end)
			,	[상품별_가상매칭_여부_백화점] = sum(case when modelno > 0 and store_flag='1' then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[상품별_가상매칭_여부_최저가여부_백화점] = sum(case when modelno > 0 and price <= minprice and store_flag='1' then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[상품별_처리_여부_백화점] = sum(case when job_flag <> '0' and store_flag='1' then 1 else 0 end)
			,	[상품별_번호작업외_처리_여부_백화점] = sum(case when job_flag = '1' and store_flag='1' then 1 else 0 end)
			,	[상품별_리스트제외_처리_여부_백화점] = sum(case when job_flag = '2' and store_flag='1' then 1 else 0 end)
			,	[상품별_웹상품추가_처리_여부_백화점] = sum(case when job_flag = '3' and store_flag='1' then 1 else 0 end)
			,	[상품별_번호수작업_처리_여부_백화점] = sum(case when job_flag = '4' and store_flag='1' then 1 else 0 end)
			,	[상품별_번호수작업_처리_여부_최저가여부_백화점] = sum(case when job_flag = '4' and price <= minprice and store_flag='1' then 1 else 0 end)
			,	[상품별_번호유사상품_처리_여부_백화점] = sum(case when job_flag = '5' and store_flag='1' then 1 else 0 end)
			,	[상품별_번호유사상품_자동매칭_처리_여부_백화점] = sum(case when job_flag = '6' and store_flag='1' then 1 else 0 end)
			,	[상품별_다중매칭_총상품수_백화점] =0
			,	[상품별_다중매칭_여부_백화점] = 0
			,	[상품별_다중매칭_처리_여부_백화점] = 0



			from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
			where modelno <> -1 -- 다중매칭 제외
			group by	tmp_group, pl_no_group

			union all

			-- 다중매칭 별도 처리
			select	pl_no_group,	max(ca_mcode) as mcate
			,0,0,0,0,0,0,0,0,0,0
			,0,0,0,0,0,0,0,0,0
			-- 그룹별 집계
/*
			,	[그룹별_다중매칭_미처리_여부] = (case when max(job_flag) = '0' then 1 else 0 end)
*/
			,	[그룹별_다중매칭_번호수작업_처리_여부] = (case when max(job_flag) = '4' then 1 else 0 end)
			,	[상품별_다중매칭_총상품수] = count(*)
			,	[상품별_다중매칭_여부] = sum(case when modelno = -1 then 1 else 0 end)
/*
			,	[상품별_다중매칭_미처리_여부] = sum(case when job_flag = '0' then 1 else 0 end)
*/
			,	[상품별_다중매칭_처리_여부] = sum(case when job_flag <> '0' then 1 else 0 end)

			-- 백화점
			,	0,0,0,0,0,0,0,0,0,0,0
			,	[상품별_다중매칭_총상품수_백화점] = sum(case when store_flag='1' then 1 else 0 end)
			,	[상품별_다중매칭_여부_백화점] = sum(case when modelno = -1 and store_flag='1' then 1 else 0 end)
			,	[상품별_다중매칭_처리_여부_백화점] = sum(case when job_flag <> '0' and store_flag='1' then 1 else 0 end)
			from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
			where modelno = -1
			group by	tmp_group, pl_no_group


	) aa
	group by	mcate
	option (maxdop 1)

	
	if @@rowcount>0  begin
		-- 최근 10일간만 데이터 유지한다.
		delete from tbl_goods_search_list_agg_v2 
		where agg_date < cast(convert(char(8), dateadd(dd, -9, getdate()),112) as smalldatetime)

		-- 최근 10일간만 데이터 유지한다.
		delete from tbl_goods_search_list_except_list
		where agg_date < cast(convert(char(8), dateadd(dd, -9, getdate()),112) as smalldatetime)

		-- 삭제전 1일치 백업 : 오류 확인용
		-- 오류 확인 후에는 삭제할 예정.. 2014.11.05
		if object_id('tbl_goods_search_list_bak_1day') is not null begin
			drop table tbl_goods_search_list_bak_1day
		end
		select * into tbl_goods_search_list_bak_1day  from tbl_goods_search_list


		-- tbl_goods_search_list truncate 처리
		truncate table tbl_goods_search_list
	end
	
	-- 워커테이블 삭제
	drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2

