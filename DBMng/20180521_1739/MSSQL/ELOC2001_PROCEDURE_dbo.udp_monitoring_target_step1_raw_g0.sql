/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step1_raw_g0
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-14 17:03:30.74
 *        Modify: 2018-05-03 17:23:35.097
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_step1_raw_g0
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
	2015.12.04		wookki25		18, 19 전가격 50%미만, 전가격 50~70%미만 삭제
	2016.08.17		wookki25		단종1만 모니터링 대상으로 처리
	*/
insert into tbl_monitoring_target_run_log(run_step) select '1-s'

	-- 기존 테이블명 변경
	if object_id('tbl_monitoring_target_raw_old_g0') is not null begin
		drop table tbl_monitoring_target_raw_old_g0		
	end

	if object_id('tbl_monitoring_target_raw_new_g0') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new_g0, tbl_monitoring_target_raw_old_g0

		-- 첫타임은 전일과 비교하지 않는다.
		if (select top 1 datediff(d, getdate(), regdate) from tbl_monitoring_target_raw_old_g0) < 0 begin
			truncate table tbl_monitoring_target_raw_old_g0
		end
	end

	

insert into tbl_monitoring_target_run_log(run_step) select '2-s'

	set datefirst 1 -- 일주일은 월요일부터 시작하도록

	declare @s_rank smallint
	declare @e_rank smallint
	select top 1 @s_rank=s_popular_rank, @e_rank=e_popular_rank from tbl_mc_schedule where group_no = datepart(dw, cast( getdate() as date))

	-- 모니터링 집계 시작 시간 업데이트 : 실제 반영시 주석 풀어야 함!
	update tbl_mc_manager_set set work_start = getdate(), work_end = null, start = null

	-- 중분류별 n개 모델
	if object_id('tmp_worker_p_goods') is not null begin		
		drop table tmp_worker_p_goods
	end
	select modelno into tmp_worker_p_goods from tbl_mcate_popular_rank where mcate_group_rank between @s_rank and @e_rank

	-- 단종1만 모니터링 대상으로 처리 : http://58.234.199.100/redmine/issues/17499
	delete a from tmp_worker_p_goods a inner join goods b on a.modelno = b.g_modelno where g_constrain <> '1'



insert into tbl_monitoring_target_run_log(run_step) select '3-s'


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
	, getdate() today_first_date			-- 당일 최초 추가일
	into tbl_monitoring_target_raw_new_g0
	from pricelist  with (readuncommitted) inner join tmp_worker_p_goods on pl_modelno = modelno
	where pl_modelno>0 and pl_status in ('0','1','2','8') and pl_srvflag in ('0','r','l','b','s') and option_flag2 ='0' 
	option (maxdop 1)

insert into tbl_monitoring_target_run_log(run_step) select '4-s'

	create nonclustered index ncl_monitoring_target_raw on tbl_monitoring_target_raw_new_g0(pl_no, pl_goodsnm)

insert into tbl_monitoring_target_run_log(run_step) select '5-s'

	-- 상품명 변경.일괄 삭제 처리
	update b --tbl_monitoring_target_raw_new_g0
	set pl_goodsnm_regexp =		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(b.pl_goodsnm, '\[[^\]]+(할인|카드|무이자|에누리|백화점)[^\]]*\]', '', 1) 
						, ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'━',''),'=',''),',',''),'...','')
	,	pl_goodsnm_old_regexp = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(a.pl_goodsnm, '\[[^\]]+(할인|카드|무이자|에누리|백화점)[^\]]*\]'
				, '', 1), ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'━',''),'=',''),',',''),'...','')

	,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	where a.pl_goodsnm <> b.pl_goodsnm
	option (maxdop 1) 	
	

insert into tbl_monitoring_target_run_log(run_step) select '6-s'
	
	-- 변경구분.전체
	-- select * from tbl_monitoring_team_agg_name where is_use = 1
	update b --tbl_monitoring_target_raw_new_g0
	set b.chg_type = 
		case 
			when b.pl_goodsnm_regexp <> b.pl_goodsnm_old_regexp 
				and  charindex(b.pl_goodsnm_regexp, b.pl_goodsnm_old_regexp) = 0
				and  charindex(b.pl_goodsnm_old_regexp, b.pl_goodsnm_regexp) = 0
				and  left(b.pl_goodsnm_old_regexp, 17) <> LEFT(b.pl_goodsnm_regexp, 17) -- 2017.05.31 // 요청:이경국
					then 1 -- 상품명 변경
			when a.pl_status <> b.pl_status and b.pl_status='8' 
					then 8 -- 전일저 인기
			--when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) 
			--		then 18 -- 전가격 50%미만
			--when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 
			--		then 19 -- 전가격 50~70%미만
			--when a.pl_deliveryinfo <> b.pl_deliveryinfo 
			--		then 14 -- 배송비 점검
			else 0
		end
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	option (maxdop 1) 	

insert into tbl_monitoring_target_run_log(run_step) select '7-s'

	-- 인덱스 생성
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new_g0(chg_type, pl_vcode)
	

insert into tbl_monitoring_target_run_log(run_step) select '8-s'

	--변경구분.상품명 변경 데이터인 경우 우선 순위 2단계 (comp_order2) 적용
	update b --tbl_monitoring_target_raw_new_g0
	set b.chg_type2 = 
		case when a.pl_status <> b.pl_status and b.pl_status='8' 
					then 8 -- 전일저 인기
			--when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) 
			--		then 18 -- 전가격 50%미만
			--when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 
			--		then 19 -- 전가격 50~70%미만
			--when a.pl_deliveryinfo <> b.pl_deliveryinfo 
			--		then 14 -- 배송비 점검
			else 0
		end
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	where b.chg_type = 1 -- 상품명 변경일 경우
	option (maxdop 1) 	


	-- new mc에서 필요한 goods 데이터 입력
	update a 
	set g_modelnm = b.g_modelnm
	,	g_category = b.g_category
	from tbl_monitoring_target_raw_new_g0 a inner join goods b on a.pl_modelno = b.g_modelno
	where chg_type = 1 -- 상품명 변경일 경우


insert into tbl_monitoring_target_run_log(run_step) select '9-s'


	update a set a.comp_order = b.comp_order 	from tbl_monitoring_target_raw_new_g0 a inner join tbl_monitoring_team_agg_name b  on a.chg_type = b.monitor_no
	update a set a.comp_order2 = b.comp_order 	from tbl_monitoring_target_raw_new_g0 a inner join tbl_monitoring_team_agg_name b  on a.chg_type2 = b.monitor_no


insert into tbl_monitoring_target_run_log(run_step) select '10-s'

	-- 테이블 전환
	-- 기존 테이블명 변경
	if object_id('tbl_monitoring_target_raw_old') is not null begin
		drop table tbl_monitoring_target_raw_old		
	end
	if object_id('tbl_monitoring_target_raw_new') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new, tbl_monitoring_target_raw_old
	end

	-- 테이블 입력

	--if cast(getdate() as date)  between cast('2015-10-08' as date) and cast('2015-10-11' as date) begin

	--	select *
	--	into tbl_monitoring_target_raw_new
	--	from tbl_monitoring_target_raw_new_g0 with (nolock)
	--	where pl_vcode = 4027 and chg_type = 1
	--	option (maxdop 1)

	--end else begin

insert into tbl_monitoring_target_run_log(run_step) select '11-s'

		select * 
		into tbl_monitoring_target_raw_new
		from tbl_monitoring_target_raw_new_g0

	--end



insert into tbl_monitoring_target_run_log(run_step) select '12-s'

	-- 인덱스 생성
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new(chg_type)

--insert into tbl_monitoring_target_run_log select getdate(), 12

	-- new mc는 데몬처럼 떠있고, 시작 시간 체크해서 실행된다
	-- new mc 시작 시간 설정: 실제 반영시 주석 풀어야 함!
	update tbl_mc_manager_set set start = dateadd(mi, 5, getdate())

insert into tbl_monitoring_target_run_log(run_step) select '12-e'

-- 임시 : http://58.234.199.100/redmine/issues/22697
/*
insert into [tbl_monitoring_target_raw_new_g0_history](
pl_no,pl_vcode,pl_modelno,pl_category,pl_price,pl_deliveryinfo,pl_status,pl_call_plan,pl_tag_price,pl_goodsnm
,pl_goodsnm_old,comp_order,chg_type,g_modelnm,g_category,regdate,pl_goodsnm_regexp,pl_goodsnm_old_regexp
,comp_order2,chg_type2,is_strangelist,today_first_date
)
select pl_no,pl_vcode,pl_modelno,pl_category,pl_price,pl_deliveryinfo,pl_status,pl_call_plan,pl_tag_price,pl_goodsnm
,pl_goodsnm_old,comp_order,chg_type,g_modelnm,g_category,regdate,pl_goodsnm_regexp,pl_goodsnm_old_regexp
,comp_order2,chg_type2,is_strangelist,today_first_date 
from [tbl_monitoring_target_raw_new_g0]
where pl_goodsnm_regexp <>''
*/


drop table tmp_worker_p_goods
