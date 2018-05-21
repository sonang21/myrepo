/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_ClEANSING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-01-12 09:22:43.36
 *        Modify: 2018-05-03 17:23:34.49
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_ORDERDATA_CLEANSING]
	@FLAG	VARCHAR(5)
AS
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2009.12.14
	-- 설  명 : 주문 Raw 데이터에 중복제거
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	-- 업체구분
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker

	-- 주문번호 강제 생성 : 주문일+####(시퀀스 일련번호
	update tbl_orderdata_worker set od_id = convert(varchar(8), od_regdate, 112) +'_'+ right('0000'+cast(seq as varchar(10)), 4) where od_id is null


	-- 당일 취소,반품,클레임, 취소 상품 삭제
	IF @SHOP_VCODE = 55 	begin
		delete tbl_orderdata_worker 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker a inner join tbl_orderdata_worker b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode and a.shop_vcode = b.shop_vcode
					and a.od_price = b.od_price -- 인팍의 경우 부분 취소가능하므로 가격까지 같은 경우만 삭제
			where	a.od_comment <> b.od_comment
			and		(	b.od_comment like '%취소%' or b.od_comment like '%반품%' 
					or	b.od_comment like '%클레임%' or b.od_comment like '%실패%'
					or	b.od_comment like '%cancel%' or b.od_comment like '%회수%'
					or	b.od_comment like '%환불%' or b.od_comment like '%수거%'
					or	b.od_comment like '%품절%' 
					)
		)

	end else  begin
		delete tbl_orderdata_worker 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker a inner join tbl_orderdata_worker b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode and a.shop_vcode = b.shop_vcode
			where	a.od_comment <> b.od_comment
			and		(	b.od_comment like '%취소%' or b.od_comment like '%반품%' 
					or	b.od_comment like '%클레임%' or b.od_comment like '%실패%'
					or	b.od_comment like '%cancel%' or b.od_comment like '%회수%'
					or	b.od_comment like '%환불%' or b.od_comment like '%수거%'
					or	b.od_comment like '%품절%' 
					)
		)
	end

	-- 취소,반품,클레임, 취소 상품 삭제.2
	delete b from tbl_orderdata_worker b 
	where		(	b.od_comment like '%취소%' or b.od_comment like '%반품%' 
				or	b.od_comment like '%클레임%' or b.od_comment like '%실패%'
				or	b.od_comment like '%cancel%' or b.od_comment like '%회수%'
				or	b.od_comment like '%환불%'	or b.od_comment like '%수거%'
				or	b.od_comment like '%품절%'
				)
	and b.od_comment not like '%철회%'

	delete tbl_orderdata_worker where  od_price <=0  

	-- 누리봇에서 변환시키는 모델명 처리
	update tbl_orderdata_worker
	set od_goodsnm =replace(replace(replace(replace(replace(replace(
	replace(replace(replace(replace(replace(replace(replace(replace(
	replace(replace(replace(replace(od_goodsnm,'★','-'),'●','-'),'◆','-')
	,'■','-'),'▲','-'),'▼','-'),'◀','-'),'▶','-'),'♠','-')
	,'♥','-'),'♣','-'),'◈','-'),'▣','-'),'⊙','-'),'◐','-')
	,'◑','-'),'<b>','-'),'　','-')


	-- 업체공통사항 : 기준일별 옵션상품/동일상품/동일 배송상태 중복 주문 그룹처리로 1개 상품으로 만들기
	if @shop_vcode <> 6361 begin -- 홈플러스
		
		select od_id, od_goodscode, od_comment, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
		into #tmp_worker
		from tbl_orderdata_worker 
		group by od_id, od_goodscode, od_comment, convert(varchar(10), od_regdate, 112) having count(*) > 1

		update	tbl_orderdata_worker
		set		od_cnt = b.sum_cnt
		,		od_price = b.sum_price
		from	tbl_orderdata_worker a inner join #tmp_worker b 
		on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
		and		a.od_comment = b.od_comment and a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

		delete	tbl_orderdata_worker 
		from	tbl_orderdata_worker a inner join #tmp_worker b 
		on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
		and		a.od_comment = b.od_comment and a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	end


	

	-- 업체별 주문데이터 제외 처리
	-- 인터파크
	--IF @SHOP_VCODE = 55 
	--BEGIN
	--	If @FLAG = 'DLV' -- 배송
	--	BEGIN
	--		-- 당일 매출마감 취소된 매출마감주문 삭제
	--		DELETE TBL_ORDERDATA_WORKER 
	--		WHERE SEQ IN 
	--		(
	--			SELECT	A.SEQ
	--			FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--					ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--			WHERE	A.OD_COMMENT = '매출마감주문'
	--			AND		B.OD_COMMENT = '매출마감취소'
	--		)
	--	END
	--	ELSE If @FLAG = 'ORD' -- 체결
	--	BEGIN
	--		DELETE TBL_ORDERDATA_WORKER 
	--		WHERE SEQ IN 
	--		(
	--			SELECT	A.SEQ
	--			FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--					ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--			WHERE	A.OD_COMMENT = '판매마감주문'
	--			AND		B.OD_COMMENT = '판매마감취소'
	--		)
	--	END
	--END
	-- G마켓
	--ELSE IF @SHOP_VCODE = 536
	--BEGIN
	--	-- 반품 환불처리 삭제
	--	DELETE FROM TBL_ORDERDATA_WORKER WHERE OD_COMMENT='반품' or OD_CNT < 0

	
	--	-- 당일 취소 상품 삭제
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '주문취소'
	--		AND		B.OD_COMMENT = '주문취소'
	--	)

	--END
	-- GSSHOP
	--ELSE 
	IF @SHOP_VCODE = 75
	BEGIN
		-- 배송비 삭제
		DELETE	TBL_ORDERDATA_WORKER WHERE	OD_GOODSNM  LIKE '배송비'

		---- 당일 취소 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '주문취소'
		--	AND		B.OD_COMMENT = '주문취소'
		--)
		

		-- 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
		-- 주문 진행상태가 달라도 1개 상품으로 처리
		SELECT OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) YYYYMMDD, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_75
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_75 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_75 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD


	END
	else if @shop_vcode = 4027
	begin
		delete tbl_orderdata_worker from tbl_orderdata_worker where od_goodscode like 'bn%'
	end
	-- 농수산
	--ELSE IF @SHOP_VCODE = 974
	--BEGIN
	--	-- 당일 취소 상품 삭제
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '주문취소'
	--		AND		B.OD_COMMENT = '주문취소'
	--	)
	--END
	-- QOOK TV쇼핑
	--ELSE IF @SHOP_VCODE = 241
	--BEGIN
	--	-- 당일 취소 상품 삭제
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '주문취소'
	--		AND		B.OD_COMMENT = '주문취소'
	--	)
	--END
	-- 신세계몰 , 이마트
	ELSE IF @SHOP_VCODE in ( 47, 374 )
	BEGIN
		---- 당일 취소 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '주문취소'
		--	AND		B.OD_COMMENT = '주문취소'
		--)

		---- 당일 반품 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '반품'
		--	AND		B.OD_COMMENT = '반품'
		--)

		delete b from tbl_orderdata_worker b where	b.od_comment = '입금대기'


		-- 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
		-- 주문 진행상태가 달라도 1개 상품으로 처리
		SELECT OD_ID, OD_GOODSCODE, SHOP_VCODE, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_47
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, SHOP_VCODE 
		HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_47 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ and a.SHOP_VCODE = b.SHOP_VCODE

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_47 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ and a.SHOP_VCODE = b.SHOP_VCODE
	END
	-- 롯데홈쇼핑
	ELSE IF @SHOP_VCODE = 663
	BEGIN
		-- 당일 배송비 삭제
		DELETE	TBL_ORDERDATA_WORKER WHERE	OD_GOODSNM  = '배송비'

		---- 당일 취소 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT not like '취소:%'
		--	AND		B.OD_COMMENT like '취소:%'
		--)

		---- 당일 반품 접수 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT not like '반품:%'
		--	AND		B.OD_COMMENT like '반품:%'
		--)

		-- 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
		-- 주문 진행상태가 달라도 1개 상품으로 처리
		SELECT OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) YYYYMMDD, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_663
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_663 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_663 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD
	END
	-- 하이마트쇼핑몰 : 
	ELSE IF @SHOP_VCODE = 6252
	BEGIN
		-- 당일 취소 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '주문취소'
		--	AND		B.OD_COMMENT = '주문취소'
		--)

		-- 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
		-- 주문 진행상태가 달라도 1개 상품으로 처리
		SELECT OD_ID, OD_GOODSCODE, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_6252
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_6252 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_6252 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ
	END
	-- 홈플러스 : 
	ELSE IF @SHOP_VCODE = 6361
	BEGIN
		---- 당일 취소 상품 삭제
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND isnull(A.OD_GOODSCODE,'1') = isnull(B.OD_GOODSCODE,'1')
		--	WHERE	A.OD_COMMENT <> b.od_comment
		--	AND		B.OD_COMMENT like '%취소%'
		--)

		-- 비식품
		delete from TBL_ORDERDATA_WORKER where od_comment = 'y'
	END
	-- Qoo10
	ELSE IF @SHOP_VCODE = 7857
	BEGIN
		-- $를 원화로 환산 // http://58.234.199.100/redmine/issues/18007
		update tbl_orderdata_worker set od_price = od_price * 1100
	END
	-- 우체국쇼핑 : 
	--ELSE IF @SHOP_VCODE = 5438
	--BEGIN
	--	-- 당일 취소 상품 삭제
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> b.od_comment
	--		AND		B.OD_COMMENT like '%취소%'
	--	)
	--END


	-- 업체공통사항 : 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
	-- 주문 진행상태가 달라도 1개 상품으로 처리
	select shop_vcode, od_id, od_goodscode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	into #tmp_worker_result
	from tbl_orderdata_worker 
	group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112), shop_vcode
	having count(*) > 1

	update	tbl_orderdata_worker
	set		od_cnt = b.sum_cnt
	,		od_price = b.sum_price
	from	tbl_orderdata_worker a inner join #tmp_worker_result b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.SHOP_VCODE = b.SHOP_VCODE

	delete	tbl_orderdata_worker 
	from	tbl_orderdata_worker a inner join #tmp_worker_result b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.SHOP_VCODE = b.SHOP_VCODE


	-- 단가계산
	update tbl_orderdata_worker	set od_unit_price = od_price/od_cnt


	delete tbl_orderdata_worker where  od_price <=0 

