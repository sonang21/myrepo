/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_raw_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-01-07 18:13:58.7
 *        Modify: 2018-05-03 17:23:35.857
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_raw_ins
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-01-06
	-- 설  명 : 모니터링 데이터 수집
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2015.03.23		wookki25		모델번호변경, 최저가 10% 이하, 이상 제외처리
	*/
	-- 기존 테이블명 변경
	if object_id('tbl_monitoring_target_raw_old') is not null begin
--		insert into tbl_monitoring_target_raw_back  
--		(pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price, pl_goodsnm, pl_goodsnm_old, comp_order, chg_type, g_modelnm, g_category, regdate, pl_goodsnm_regexp, pl_goodsnm_old_regexp)
--		select 
--		pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price, pl_goodsnm, pl_goodsnm_old, comp_order, chg_type, g_modelnm, g_category, regdate, pl_goodsnm_regexp, pl_goodsnm_old_regexp
--		from tbl_monitoring_target_raw_old	 where chg_type=1
	
		drop table tbl_monitoring_target_raw_old		
	end
	if object_id('tbl_monitoring_target_raw_new') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new, tbl_monitoring_target_raw_old
	end

--insert into tmp_20150326_runstep select getdate(), 1

	declare @s_rank smallint
	declare @e_rank smallint
	select top 1 @s_rank=top_start, @e_rank=top_end from tbl_mc_manager_set

	-- 모니터링 집계 시작 시간 업데이트 : 실제 반영시 주석 풀어야 함!
	update tbl_mc_manager_set set work_start = getdate(), work_end = null, start = null

	-- 중분류별 60위 모델
	select modelno into #p_goods from tbl_mcate_popular_rank where mcate_group_rank between @s_rank and @e_rank

--insert into tmp_20150326_runstep select getdate(), 2


	-- 원본 데이터
	select pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price --pl_price_card, 
	, pl_goodsnm
	, cast('' as nvarchar(200)) pl_goodsnm_old
	, cast(0 as smallint) comp_order	-- 변경사항 비교 우선순위
	, cast(0 as smallint) chg_type		-- 변경사항 구분
	, cast('' as nvarchar(70)) as g_modelnm
	, cast('' as char(8)) as g_category
	, getdate() as regdate
	, cast('' as nvarchar(200)) pl_goodsnm_regexp		-- 정규식 적용 후 현재 상품명
	, cast('' as nvarchar(200)) pl_goodsnm_old_regexp	-- 정규식 적용 후 이전 상품명
	, cast(0 as smallint) comp_order2	-- 변경사항 비교 우선순위 : 모델명 변경일 경우만 2번째
	, cast(0 as smallint) chg_type2		-- 변경사항 구분 : 모델명 변경일 경우만 2번째
	, cast(0 as bit) is_strangelist		-- strangelist  입력여부 : 0 - 입력하지 않음, 1 - 입력함
	into tbl_monitoring_target_raw_new
	from pricelist  with (readuncommitted) inner join #p_goods on pl_modelno = modelno
	where pl_modelno>0 and pl_status in ('0','1','2','8') and pl_srvflag in ('0','r','l','b','s') and option_flag2 ='0' 
	option (maxdop 1)

--insert into tmp_20150326_runstep select getdate(), 3

	create nonclustered index ncl_monitoring_target_raw on tbl_monitoring_target_raw_new(pl_no, pl_goodsnm)

--insert into tmp_20150326_runstep select getdate(), 4

	-- 상품명 변경.일괄 삭제 처리
	update b --tbl_monitoring_target_raw_new
	set pl_goodsnm_regexp =		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(b.pl_goodsnm, '\[[^\]]+(할인|카드|무이자|에누리|백화점)[^\]]*\]', '', 1) 
						, ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'━',''),'=','')
	,	pl_goodsnm_old_regexp = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(a.pl_goodsnm, '\[[^\]]+(할인|카드|무이자|에누리|백화점)[^\]]*\]'
				, '', 1), ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'━',''),'=','')

	,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	where a.pl_goodsnm <> b.pl_goodsnm
	option (maxdop 1) 	
	

--insert into tmp_20150326_runstep select getdate(), 5
	
	-- 변경구분.전체
	update b --tbl_monitoring_target_raw_new
	set b.comp_order = 
		case 
--			when a.pl_modelno <> b.pl_modelno then 1 
			when b.pl_goodsnm_regexp <> b.pl_goodsnm_old_regexp 
				and  charindex(b.pl_goodsnm_regexp, b.pl_goodsnm_old_regexp) = 0
				and  charindex(b.pl_goodsnm_old_regexp, b.pl_goodsnm_regexp) = 0
			then 2 -- 정규식 데이터 적용한 상품명 비교
			when a.pl_status <> b.pl_status and b.pl_status='8' then 3

--			when a.pl_price <> b.pl_price and b.pl_price>=(a.pl_price*1.1) then 5
--			when a.pl_price <> b.pl_price and b.pl_price<=(a.pl_price*0.9) then 6

			when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) then 5
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 then 6
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.7) and b.pl_price < (a.pl_price)*0.9 then 7

		--	when a.pl_price_card <> b.pl_price_card then 7
			when a.pl_deliveryinfo <> b.pl_deliveryinfo then 8
		--	when a.pl_call_plan <> b.pl_call_plan then 9
		--	when a.pl_tag_price <> b.pl_tag_price then 10
			else 0
		end
	--,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	option (maxdop 1) 	

--insert into tmp_20150326_runstep select getdate(), 6

	-- 인덱스 생성
	create nonclustered index ncl_comp_order on tbl_monitoring_target_raw_new(comp_order)

--insert into tmp_20150326_runstep select getdate(), 7

	--변경구분.상품명 변경 데이터 대상
	update b --tbl_monitoring_target_raw_new
	set b.comp_order2 = 
		case when a.pl_status <> b.pl_status and b.pl_status='8' then 3
--			when a.pl_price <> b.pl_price and b.pl_price>=(a.pl_price*1.1) then 5
--			when a.pl_price <> b.pl_price and b.pl_price<=(a.pl_price*0.9) then 6
			when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) then 5
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 then 6
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.7) and b.pl_price < (a.pl_price)*0.9 then 7
			when a.pl_deliveryinfo <> b.pl_deliveryinfo then 8
			else 0
		end
	--,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	where b.comp_order = 2 -- 상품명 변경일 경우
	option (maxdop 1) 	

--insert into tmp_20150326_runstep select getdate(), 8


	-- 변경 항목 구분
	-- 현재는 chg_type과 동일
	-- select  * from tbl_monitoring_team_agg_name
	update tbl_monitoring_target_raw_new
	set chg_type = 
		case comp_order 
--			when 1 then 12	-- 번호
			when 2 then 1	-- 상품명
			when 3 then 8	-- 전일저
			when 4 then 17	-- 옵션점검
			when 5 then 18	-- 이전 가격 기준 50% 미만
			when 6 then 19	-- 이전 가격 기준 50%이상 30%미만
			when 7 then 20	-- 이전 가격 기준 30%이상 10%미만
			when 8 then 14	-- 배송비
--			when 9 then 15	-- 요금제
--			when 10 then 16	-- 가격2 
		end
	,	chg_type2 = 
		case comp_order2 
			when 3 then 8	-- 전일저
			when 4 then 17	-- 옵션점검
			when 5 then 18	-- 이전 가격 기준 50% 미만
			when 6 then 19	-- 이전 가격 기준 50%이상 30%미만
			when 7 then 20	-- 이전 가격 기준 30%이상 10%미만
			when 8 then 14	-- 배송비
			else 0			-- 예외상황은 기본값으로 설정
		end
	where comp_order > 0

--insert into tmp_20150326_runstep select getdate(), 9

	-- 변경사항 구분별 통계확인
	-- select chg_type, count(*) from tbl_monitoring_target_raw_new where chg_type is not  null group by chg_type


	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
	update a -- tbl_monitoring_target_raw_new
	set chg_type = 0
	,	comp_order = 0
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
	where b.p_status = 'i' and a.comp_order > 0

	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
	where b.p_status = 'i' and a.comp_order > 0

	-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
	where b.p_status in ('u', 'd') and a.comp_order >0


	-- 상품명 변경 제외한 데이터 입력
	insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type)
	select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type
	from tbl_monitoring_target_raw_new where comp_order >0 and chg_type not in ('1') -- 상품명변경

--insert into tmp_20150326_runstep select getdate(), 10

	-- 옵션 데이터 입력 : 하루 1회만
	declare @sdate smalldatetime
	set @sdate = cast(convert(varchar(10), getdate(), 120) as smalldatetime)
	if not exists (select top 1 1 from tbl_monitoring_target with (readuncommitted) where chg_type = 17 and regdate >= @sdate) begin
		select a.pl_no, cast(4 as smallint) comp_order, cast(17 as smallint) chg_type, pl_vcode, pl_category, pl_goodsnm
		into #tbl_monitoring_target_option -- 입력할 데이터 임시 저장
		from 
		(
			select pl_no from tbl_pricelist_option_ctu_detail where regdate>=@sdate and regdate < @sdate+1
			union
			select pl_no from tbl_pricelist_option_diff_detail where regdate>=@sdate and regdate < @sdate+1
		) a inner join pricelist b with (readuncommitted)  on a.pl_no = b.pl_no
		where pl_srvflag not in ('O','Z','1') and option_flag2 <> '1'


		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
		delete a -- tbl_monitoring_target_raw_new
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
		where b.p_status = 'i' and a.comp_order > 0

		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
		where b.p_status = 'i' and a.comp_order > 0

		-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
		where b.p_status in ('u', 'd') and a.comp_order >0


		-- 상품명 변경 제외한 데이터 입력
		insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type)
		select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type
		from #tbl_monitoring_target_option
	end

--insert into tmp_20150326_runstep select getdate(), 11

	-- 인덱스 생성
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new(chg_type)

--insert into tmp_20150326_runstep select getdate(), 12

	-- 2015.01.23 // 이경국 요청 // 전일저 상품 모니터링 대상으로 입력 후 원본 데이터는 보관코드8에서 1로 변경한다.
	-- 적용안하기로함
--	update pricelist 	
--	set pl_status = '1' 
--	where pl_no in (select top 1000 pl_no from tbl_monitoring_target_raw_new  where chg_type = '8')
--
--	update  tbl_monitoring_target_raw_new  
--	set pl_status = '1' 
--	where chg_type = '8'


--insert into tmp_20150326_runstep select getdate(), 13

	-- new mc에서 필요한 goods 데이터 입력
	update a 
	set g_modelnm = b.g_modelnm
	,	g_category = b.g_category
	from tbl_monitoring_target_raw_new a inner join goods b on a.pl_modelno = b.g_modelno
	where chg_type = '1'

	-- new mc는 데몬처럼 떠있고, 시작 시간 체크해서 실행된다
	-- new mc 시작 시간 설정: 실제 반영시 주석 풀어야 함!
	update tbl_mc_manager_set set start = dateadd(mi, 5, getdate())


--insert into tmp_20150326_runstep select getdate(), 14

	-- 총개수 업데이트 
	--	: 실제 반영시 주석 풀어야 함
	--	: 기존 프로시저 수정해야 함 : udp_monitoring_team_agg_target
	--exec udp_monitoring_target_raw_agg

	/*
	delete from tbl_monitoring_team_agg_target 	
	where monitor_no in (12, 1, 8, 2, 3, 14, 15, 16, 17)  and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- 새로 입력
	insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
	select chg_type
	,	cast(convert(char(10), getdate(), 120) as smalldatetime) agg_date
	,	left(pl_category,2) lcate
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	group by chg_type, left(pl_category,2)
	option (maxdop 1)
	*/

	delete tmp_20150326_runstep where run_date < getdate() - 7


