/* *************************************************************************
 * NAME : dbo.USP_POPULAR_ACC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:40:59.903
 *        Modify: 2018-05-10 15:43:07.663
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[USP_POPULAR_ACC]
	@DTE_IN SMALLDATETIME=''
AS
BEGIN
	-- ----------------------------------------------------------------------------------
	-- 작성자 : ssauravy
	-- 설  명 : 인기도 계산
	-- 참  고 : USP_POPULAR_CHANGE_1 : 오늘의 인기도 수정 처리 프로시저
    --          udp_rocket_sales_agg : 판매량 급상승 처리 프로시저
	--			2013.11.28 .. 인기점수 있는 모델이 70만건 넘으면 전체 모델의 인기도 초기화 후 인기도 업데이트한다.
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- 수정일:		수정자:		수정내용:
	-- ----------------------------------------------------------------------------------
	-- 2008.09.09	wookki25	처리 : G_MALLCNT > 0 조건 삭제 (협의:임현승, 한혜진)
	--                          사유 : 업체개수 변경시에도 인기점수 변경 반영
	-- ----------------------------------------------------------------------------------
	-- 2008.09.29	wookki25	처리 : 가구 특정 미분류 인기도 계산방식 변경(협의:민후식)
	--							참고 : http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=177658
	--                          사유 : 맞춤형 제품의 경우 주문수량이 지나치게 많아 주문 건수로 인기도 처리
	-- ----------------------------------------------------------------------------------
	-- 2008.10.13	wookki25	처리 : 가구 특정 미분류 인기도 계산방식 변경 추가(협의:민후식), 12030200, 소분류만 있는 카테고리
	--							참고 : http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=179199
	--                          사유 : 맞춤형 제품의 경우 주문수량이 지나치게 많아 주문 건수로 인기도 처리	
	-- ----------------------------------------------------------------------------------	
	-- 2009.06.17	wookki25	처리 : 제조사 가중치 카테고리별 적용 기능 추가
	--							참고 : http://jca.enuri.com/board/eNuriBoard.asp?cmd=board_read&regno=210333&board_code=509&page=1&cmd1=&keyword=&strOption=BoardSubject
	--                          사유 : 카테고리별 가중치 적용 기능 필요!
	-- ----------------------------------------------------------------------------------
	-- 2010.01.18	wookki25	처리 : 주문실적 2.5배 -> 2배
	--							참고 : 정재웅 이사님 요청
	-- ----------------------------------------------------------------------------------
	-- 2010.09.08	wookki25	처리 : 주문실적 2배 -> 3배
	--							참고 : 정재웅 이사님 요청
	-- ----------------------------------------------------------------------------------
	-- 2010.11.02	wookki25	처리 : 옥션 구매이동당 3점 처리
	--							참고 : 정재웅 이사님 요청
	-- ----------------------------------------------------------------------------------
	-- 2011.01.27	wookki25	처리 : 옥션 구매이동당 3점 처리 취소
	--							참고 : 한혜진 차장 요청
	-- ----------------------------------------------------------------------------------
	-- 2011.09.06	wookki25	처리 : 가상주문실적. 실제주문실적*3 -> 실제주문실적*2
	--							참고 : http://jca.enuri.com/board/redirect.asp?bt=2&bn=7&cn=76100
	-- ----------------------------------------------------------------------------------
	-- 2011.09.06	wookki25	처리 : 가상주문실적 기간변경. 오늘 기준 전일~전일부터 이전 한달	
	--							참고 : 정재웅 요청. 인기도와 주문실적 차이가 커서..
	-- ----------------------------------------------------------------------------------
	-- 2011.09.19	wookki25	처리 : 팝스포유,영웅피씨,아싸컴 실 주문실적 반영 변경: 전체 카테고리에서  데탑(0401) 카테고리만 적용
	--							참고 : 정재웅 요청. 노트북 주문실적이 너무 적다.
	-- ----------------------------------------------------------------------------------
	-- 2011.09.26	wookki25	처리 : 쇼핑몰 인기상품 에누리 인기도에 추가 점수 적용
	--							참고 : 한혜진 요청
	-- ----------------------------------------------------------------------------------	
	-- 2011.11.03	wookki25	처리 : 가상주문실적 1개월 -> 3개월
	--							참고 : 이주현 요청
	-- ----------------------------------------------------------------------------------
	-- 2011.11.03	wookki25	처리 : 가구인기도 계산방식 원복.
	--							참고 : 고아름 요청, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=350598
	-- ----------------------------------------------------------------------------------
	-- 2012.04.26	wookki25	처리 : 옥션 인기도 미반영
	--							참고 : 최서영 요청, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=352546
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------------------------------------------
	-- 2012.05.04	wookki25	처리 : 옥션 인기도 미반영관련 예외처리
	--								   옥션데이터중에 조립pc업체 데이터는 인기도에 반영한다.
	--							참고 : 최소희 요청, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=353301
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.21	wookki25	처리 : 11번가 체결 데이터 인기도에 추가..
	--							참고 : 한혜진 요청, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=433327
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.21	wookki25	처리 : 11번가 체결 데이터 가상주문수량에 추가..
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.24	wookki25	처리 : 옥션 데이터 인기도에 반영.
	--							참고 : 최서영요청, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=434184
	-- ----------------------------------------------------------------------------------
  	-- ----------------------------------------------------------------------------------
	-- 2014.09.12	wookki25	처리 : 조립pc실주문 변경은 최종 결과 테이블에서 수정하게 변경
	--							참고 : elocdb 참조시 오류 발생할 경우 무시할 수 있도록.
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------------------------------------------
	-- 2015.04.13	wookki25	처리 : 팝콘PC,넥스PC 실 주문실적 반영 변경: 전체 카테고리에서  데탑(0401) 카테고리만 적용
	-- ----------------------------------------------------------------------------------
	-- 2016.06.30	wookki25	처리 : 지마켓, 인팍 배송데이터 참조 -> 체결데이터 참조
	--							참고 : 신보람 요청
	-- ----------------------------------------------------------------------------------
	-- 2016.08.23	wookki25	처리 : 모바일 데이터 참조 ( 주문, clickout, vip )
	--							참고 : 신보람 요청
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @DTECHKDAY AS SMALLDATETIME
	IF @DTE_IN = ''
		SET @DTECHKDAY = DATEADD(D, -1, GETDATE())
	ELSE
		SET @DTECHKDAY = @DTE_IN
	SET @DTECHKDAY = CONVERT(VARCHAR(8), @DTECHKDAY, 112)


	-- 이미 입력되어있다면? 해당 일일 인기도 삭제
	DELETE TBL_GOODS_POPULAR_ACC WHERE GPA_DATE >=  @DTECHKDAY AND GPA_DATE < DATEADD(D, 1, @DTECHKDAY)


insert tbl_popular_acc_step_log(step) values('인기도 계산_s')

	-- 일일 인기도 입력
	insert tbl_goods_popular_acc
	(gpa_date, g_modelno, g_category, g_modelnm, gpa_model_uhit, gpa_model_hit,  gpa_move_uhit, gpa_move_hit, gpa_od_cnt
	, gpa_od_vcnt, gpa_price, gpa_po_point, gpa_po_model_point, gpa_po_move_point, gpa_po_od_cnt_point
	, gpa_po_od_price_point,gpa_po_shop_popular_point)
	select
		@dtechkday as yyyymmdd,
		e.g_modelno,
		isnull(g.g_category,'00') as g_category,
		isnull(g.g_modelnm,'') as g_modelnm,
		gpa_model_uhit,
		gpa_model_hit,
		gpa_move_uhit,
		gpa_move_hit,
		gpa_od_cnt,
		case when
			ceiling(2*isnull(gpa_od_vcnt,0)-(convert(tinyint, (round((rand((datepart(mm, getdate()) * 100000 ) + (datepart(ss, getdate()) * 1000 ) + datepart(ms, getdate())+e.g_modelno % 100000 )*100), 0)))%3))>0
			then ceiling(2*isnull(gpa_od_vcnt,0)-(convert(tinyint, (round((rand((datepart(mm, getdate()) * 100000 ) + (datepart(ss, getdate()) * 1000 ) + datepart(ms, getdate())+e.g_modelno % 100000 )*100), 0)))%3))
			else gpa_od_vcnt end as
		gpa_od_vcnt,
		gpa_price,
		ceiling(gpa_po_point) as gpa_po_point,
		gpa_model_point,
		gpa_move_point,
		gpa_od_cnt_point,
		gpa_od_price_point	
	,	shop_popular_point	
	from
	(
		select	g_modelno
		,	sum(gpa_model_uhit) as gpa_model_uhit
		,	sum(gpa_model_hit) as gpa_model_hit
		,	sum(gpa_move_uhit) as gpa_move_uhit
		,	sum(gpa_move_hit) as gpa_move_hit
		,	sum(gpa_model_point+gpa_move_point+gpa_od_cnt_point+gpa_od_price_point+shop_popular_point) as gpa_po_point
		,	sum(gpa_od_cnt) as gpa_od_cnt
		,	sum(gpa_price) as gpa_price
		,	sum(od_vcnt) as gpa_od_vcnt
		,	sum(gpa_model_point) as gpa_model_point
		,	sum(gpa_move_point) as gpa_move_point
		,	sum(gpa_od_cnt_point) as gpa_od_cnt_point
		,	sum(gpa_od_price_point) as gpa_od_price_point
		,	sum(shop_popular_point) as shop_popular_point
		from
		(
			select
				g_modelno
			,	sum(gpa_model_uhit) as gpa_model_uhit
			,	sum(gpa_model_hit) as gpa_model_hit
			,	sum(gpa_move_uhit) as gpa_move_uhit
			,	sum(gpa_move_hit) as gpa_move_hit
			--	sum(gpa_model_uhit)*1 + sum(gpa_move_uhit)*3 + sum(gpa_od_cnt)*15 + ceiling(sum(gpa_price)/100000.0)*15 as gpa_point_pre,
			,	sum(gpa_model_point)*1 as gpa_model_point
			,	sum(gpa_move_point)*3 as  gpa_move_point
			,	sum(gpa_od_cnt*gpa_ratio)*15 as gpa_od_cnt_point
			,	ceiling(sum(gpa_price*gpa_ratio)/100000.0)*15 as gpa_od_price_point
			,	sum(gpa_od_cnt) as gpa_od_cnt
			,	sum(gpa_price) as gpa_price
			,	0 as od_vcnt
			,	0 as shop_popular_point
			from
			(
				select d.g_modelno
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_uhit else 0 end) as gpa_model_uhit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_hit else 0 end ) as gpa_model_hit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_point else 0 end) as gpa_model_point
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_uhit else 0 end) as gpa_move_uhit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_hit else 0 end) as gpa_move_hit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_point else 0 end) as gpa_move_point
				,	sum(od_cnt) as gpa_od_cnt
				,	sum(od_price*od_cnt) as gpa_price -- wookki25 2007.05.22 단가*수량 수정처리
				,	case when sum(md_uhit + mh_uhit) > 0 and sum(md_point*1.0 + mh_point*3.0) > 0 then sum(md_point*1.0 + mh_point*3.0)/sum(md_uhit*1.0+mh_uhit*3.0) else 1 end as gpa_ratio
				from
				(
					--상품창 로그(일별 -7일치)
					select
						convert(char(8), md_dd, 112)  as yyyymmdd,
						g_modelno,
						-----------------
						md_dup_hit as md_uhit,
						md_hit,
						case when isnull(point,md_dup_hit) = md_dup_hit then md_dup_hit*1.2 else point end  md_point,
						
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), md_dd, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_model_dhit
					where md_dd>= convert(char(8),dateadd(d, -10, @dtechkday),112)
						and md_dd < convert(char(8), dateadd(d, 1, @dtechkday),112)

					--상품창 로그(일별 -7일치) // 모바일
					union all
					select
						convert(char(8), regdate, 112)  as yyyymmdd,
						modelno,
						-----------------
						uhit as md_uhit,
						mhit,
						case when isnull(point,uhit) = uhit then uhit*1.2 else point end  md_point,
						
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when regdate>= dateadd(d, -7, @dtechkday) then 1 else 0 end) as is_include
					from tbl_model_log_mobile_agg_day
					where regdate>= dateadd(d, -10, @dtechkday)
						and regdate < dateadd(d, 1, @dtechkday)
					and modelno > 0

					--구매이동 로그(일별 -7일치)
					union all

					select
						convert(char(8), mh_date, 112) as yyyymmdd,
						g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0 as md_point,
						-----------------
						mh_uhit,
						mh_hit,
						case when isnull(point,mh_uhit) = mh_uhit then mh_uhit*1.2 else point end  mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), mh_date, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_move_hit
					where mh_date >=  dateadd(d, -10, @dtechkday)
						and mh_date < dateadd(d, 1, @dtechkday)


					--구매이동 로그(일별 -7일치) / mobile
					union all

					select
						convert(char(8), regdate, 112) as yyyymmdd,
						modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0 as md_point,
						-----------------
						uhit,
						mhit,
						case when isnull(point,uhit) = uhit then uhit*1.2 else point end  mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), regdate, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_move_log_mobile_agg_day_by_modelno
					where regdate >=  dateadd(d, -10, @dtechkday)
						and regdate < dateadd(d, 1, @dtechkday)
					and modelno > 0




					--주문수량 (일별 -10일치)
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						and shop_vcode not in (5910, 4027, 55, 536) -- 2016.06.30 // 배송데이터 사용하지 않음
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata_gmarket_auction
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						--and shop_vcode in (5910, 4027) -- 11번가 체결 데이터 포함

					--주문수량 (일별 -10일치) / 모바일
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata_ord_mobile
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						




				) d
				group by d.yyyymmdd, d.g_modelno
				having(sum(is_include)>0)

			) f
			group by g_modelno



			-- 가상주문수량
			UNION ALL
			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM TBL_ORDERDATA
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				and shop_vcode not in (5910, 4027, 55, 536)

			UNION ALL

			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM TBL_ORDERDATA_gmarket_auction
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				--and shop_vcode in (5910, 4027)

			union all

			-- 모바일
			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM tbl_orderdata_ord_mobile
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				--and shop_vcode in (5910, 4027)


			
			-- 쇼핑몰 인기상품 인기도
			UNION ALL
			select	g_modelno
			,	0 AS GPA_MODEL_UHIT
			,	0 AS GPA_MODEL_HIT
			,	0 AS GPA_MOVE_UHIT
			,	0 AS GPA_MOVE_HIT
			,	0 AS GPA_MODEL_POINT
			,	0 AS  GPA_MOVE_POINT
			,	0 AS GPA_OD_CNT_POINT
			,	0 AS GPA_OD_PRICE_POINT
			,	0 AS GPA_OD_CNT
			,	0 AS GPA_PRICE
			,	0 AS OD_VCNT
			,	isnull(sum(popular_point),0) AS shop_popular_point
			from	goods_popular_weight_shop_popular
			where	regdate=@dtechkday
			group by g_modelno

		) A
		GROUP BY G_MODELNO
	) E
	LEFT JOIN analstore.DBO.GOODS G
	ON E.G_MODELNO=G.G_MODELNO


insert tbl_popular_acc_step_log(step) values('인기도 계산_e')


insert tbl_popular_acc_step_log(step) values('데이터 복사_s')
	-- -----------------------
	-- 실제 반영할 데이터 입력
	-- -----------------------
	TRUNCATE TABLE GOODS_POPULAR

	INSERT INTO GOODS_POPULAR (GP_MODELNO, GP_CATEGORY, GP_SUM_POINT, GP_ODA_VCNT, GP_FACTORY)
	SELECT	G.G_MODELNO,
			G.G_CATEGORY,
			ISNULL(GPA_PO_POINT,0) AS GP_SUM_POINT,
			ISNULL(P.GPA_OD_VCNT,0) AS GP_ODA_VCNT,
			G.G_FACTORY
	FROM analstore.DBO.GOODS G
		INNER JOIN TBL_GOODS_POPULAR_ACC P
			ON G.G_MODELNO=P.G_MODELNO AND P.GPA_DATE>=@DTECHKDAY AND P.GPA_DATE<DATEADD(D, 1, @DTECHKDAY)
	WHERE G_JOBCODE <> '0' -- 초기상품 제외
	-- AND G_MALLCNT > 0 -- 삭제처리 wookki25 2008.09.09 -- 서비스 유무 변경때문 
	ORDER BY GP_SUM_POINT DESC
insert tbl_popular_acc_step_log(step) values('데이터 복사_e')

insert tbl_popular_acc_step_log(step) values('가중치 적용_s')	
	
	-- 제조사 가중치 적용
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 
	FROM	GOODS_POPULAR A 
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_FACTORY B
				ON A.GP_FACTORY = B.G_FACTORY
	WHERE	B.USE_FLAG = 1
	AND LEFT(GP_CATEGORY, LEN(B.G_CATEGORY)) = B.G_CATEGORY

	--모델 가중치 적용
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 	 	
	FROM	GOODS_POPULAR A 
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_MODELNO B
				ON A.GP_MODELNO = B.G_MODELNO
	WHERE	B.USE_FLAG = 1


	-- 카테고리별 가중치
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 	
	FROM	GOODS_POPULAR A
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_CATEGORY B
				ON A.GP_CATEGORY LIKE B.G_CATEGORY + '%'
	WHERE	B.USE_FLAG = 1

insert tbl_popular_acc_step_log(step) values('가중치 적용_e')


insert tbl_popular_acc_step_log(step) values('스폰서 적용_s')
	-- 특정상품 인기도 주문내역 동기화
	-- 스폰서 상품 적용하기전에 적용해야 함!!
	-- EXEC UDP_SYNC_POPULAR_INFO

	-- 스폰서 상품 인기도 고정 처리 wookki25 2009.09.14
	-- USP_POPULAR_CHANGE_1 에서는 처리하지 않는다. 
	-- EDATE +1 : 종료 다음일 업무시간까지 유지하도록 처리. 종료 다음일 업무 시간에 수동으로 내립니다.
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = P_WEIGHT 
	FROM	GOODS_POPULAR A
				INNER JOIN
			GOODS_POPULAR_WEIGHT_SPONSOR  B
				ON A.GP_MODELNO = B.G_MODELNO
	WHERE	USE_FLAG = 1 
	AND		SDATE <= CAST(CONVERT(VARCHAR(10), GETDATE(), 120) AS SMALLDATETIME)
	AND		EDATE+1 >= CAST(CONVERT(VARCHAR(10), GETDATE(), 120) AS SMALLDATETIME)

	-- 추가상품 스폰서 처리 때문에 같은 모델을 다른 모델번호로 등록한 경우 
	-- 인기도와 주문수를 합해준다. 
	-- 2013.08.12
	-- http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=411285
	-- http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=419955 
	--http://58.234.199.100/redmine/issues/2492
/*
	declare @sp_sum_point int
	declare @sp_oda_vcnt int
	select @sp_sum_point = sum(gp_sum_point), @sp_oda_vcnt = sum(gp_oda_vcnt) from GOODS_POPULAR 
	where gp_modelno in (11397242, 11649863)

--	select @sp_sum_point, @sp_oda_vcnt
	update GOODS_POPULAR 
	set gp_sum_point = @sp_sum_point
	,	gp_oda_vcnt  = @sp_oda_vcnt
	where gp_modelno in (11397242, 11649863)
*/

	-- -인기도 0점처리
	update goods_popular set gp_sum_point=0 from goods_popular where gp_sum_point < 0
insert tbl_popular_acc_step_log(step) values('스폰서 적용_e')



insert tbl_popular_acc_step_log(step) values('실주문 변경_s')

	-- 아싸컴 가상주문수를 실제주문수로 변경
	-- 2008.03.17 wookki25 이창훈씨 요청
	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA
			WHERE	PL_MODELNO > 0 
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY) AND
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				AND	SHOP_VCODE = 1506
				and OD_CATEGORY like '0401%'
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- 팝스포유 데탑 카테고리 가상주문수를 실제주문수로 변경
	select distinct pl_modelno as modelno into #tbl_948_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 948 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_948_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0 
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- 영웅컴퓨터 가상주문수를 실제주문수로 변경
	select distinct pl_modelno as modelno into #tbl_6174_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 6174 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_6174_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO



	-- 스피드컴 가상주문수를 실제주문수로 변경
	select distinct pl_modelno as modelno into #tbl_6534_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 6534 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_6534_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO

	-- 팝콘피씨 가상주문수를 실제주문수로 변경
	select distinct pl_modelno as modelno into #tbl_7653_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 7653 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_7653_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- 넥스피씨 가상주문수를 실제주문수로 변경
	select distinct pl_modelno as modelno into #tbl_7644_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 7644 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_7644_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO
	

insert tbl_popular_acc_step_log(step) values('실주문 변경_e')


-- 옥시 예외 처리  // 2016.05.18
update GOODS_POPULAR 
set gp_sum_point = 0
where gp_factory ='옥시'



END