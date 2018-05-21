/* *************************************************************************
 * NAME : dbo.UDP_LOTTE_PDSS_TARGET
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 18:30:38.41
 *        Modify: 2018-05-16 18:50:48.81
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_LOTTE_PDSS_TARGET]
	@TYPE CHAR(1),		-- 'T' : TOTAL(전체), 'C' : CHANGE(변경)
	@SHOP_CODE INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	/*
		TBL_EXTERNAL_ATTRIBUTE			-- (셋팅 속성)
		TBL_EXTERNAL_ATTRIBUTE_BACKUP	-- (셋팅 속성 삭제)
		TBL_EXTERNAL_AUTO_TARGET		-- (자동매칭 내역)
		TBL_EXTERNAL_CATEGORY			-- (전송 분류)
		TBL_EXTERNAL_MODELNO_LOG		-- (CM 속성 로그)
		TBL_EXTERNAL_SEND_TARGET_MODEL	-- (누적 전송 모델)
		TBL_EXTERNAL_SEND_TARGET_PLNO	-- (누적 전송 EP)
		TBL_EXTERNAL_DENIED_PLNO		-- (CM 매칭 불가 내역)
	*/
	
	IF @TYPE = 'T' AND DATEPART(WEEKDAY, GETDATE()) <> 1 AND DATEPART(WEEKDAY, GETDATE()) <> 2
	BEGIN
		-- 자동매칭 일별 20,000개씩 OPEN
		SET ROWCOUNT 20000;
		DELETE /* UDP_LOTTE_PDSS_TARGET:01 */ FROM TBL_EXTERNAL_AUTO_TARGET
		SET ROWCOUNT 0;
	END
	
	-- 삭제 데이터 처리
	DELETE /* UDP_LOTTE_PDSS_TARGET:02 */ FROM TBL_EXTERNAL_SEND_TARGET_PLNO
	OUTPUT DELETED.YYYYMMDD, DELETED.SHOP_CODE, DELETED.PL_NO, DELETED.PL_MODELNO, DELETED.REGDATE, GETDATE(), 'D' INTO TBL_EXTERNAL_SEND_TARGET_PLNO_BACKUP
	FROM TBL_EXTERNAL_SEND_TARGET_PLNO A
		LEFT JOIN PRICELIST B ON A.PL_NO = B.PL_NO
	WHERE A.SHOP_CODE = @SHOP_CODE AND (B.PL_NO IS NULL OR NOT(B.PL_STATUS = '4' AND B.PL_SRVFLAG = '4'))
	OPTION (MAXDOP 1)
	
	----------------------------------------------------------
	-- 기전송 데이터 수정
	UPDATE /* UDP_LOTTE_PDSS_TARGET:03 */ TBL_EXTERNAL_SEND_TARGET_PLNO
	SET PL_MODELNO = B.PL_MODELNO
	OUTPUT DELETED.YYYYMMDD, DELETED.SHOP_CODE, DELETED.PL_NO, DELETED.PL_MODELNO, DELETED.REGDATE, GETDATE(), 'U' INTO TBL_EXTERNAL_SEND_TARGET_PLNO_BACKUP
	FROM TBL_EXTERNAL_SEND_TARGET_PLNO A
		INNER JOIN PRICELIST B ON A.PL_NO = B.PL_NO
	WHERE A.SHOP_CODE = @SHOP_CODE AND A.PL_MODELNO <> B.PL_MODELNO
	OPTION (MAXDOP 1)
	
	----------------------------------------------------------
	-- 신규(당일) 전송 대상 상품
	----------------------------------------------------------
	INSERT /* UDP_LOTTE_PDSS_TARGET:04 */ INTO TBL_EXTERNAL_SEND_TARGET_PLNO(YYYYMMDD, SHOP_CODE, PL_NO, PL_MODELNO)
	SELECT DISTINCT CONVERT(CHAR(8), DATEADD(D, -1, GETDATE()), 112), A.PL_VCODE, A.PL_NO, A.PL_MODELNO
	FROM PRICELIST A
	WHERE A.PL_VCODE = @SHOP_CODE AND A.PL_MODELNO NOT IN (0, -100, -200, -300) AND A.PL_STATUS = '4' AND A.PL_SRVFLAG = '4'
	  AND NOT EXISTS (SELECT TOP 1 1 FROM TBL_EXTERNAL_AUTO_TARGET B WHERE A.PL_NO = B.PL_NO)		-- 자동매칭
	  AND NOT EXISTS (SELECT TOP 1 1 FROM TBL_EXTERNAL_SEND_TARGET_PLNO C WHERE C.SHOP_CODE = @SHOP_CODE AND A.PL_NO = C.PL_NO)	-- 기전송
	OPTION (MAXDOP 1)
	
	IF @TYPE = 'T'
	BEGIN
		----------------------------------------------------------
		-- 누적 전송 모델(최근 누적 전송) -- MALLCNT 집계 오전 3:10 시작
		----------------------------------------------------------
		DELETE /* UDP_LOTTE_PDSS_TARGET:05 */ FROM TBL_EXTERNAL_SEND_TARGET_MODEL WHERE SHOP_CODE = @SHOP_CODE
		INSERT /* UDP_LOTTE_PDSS_TARGET:06 */ INTO TBL_EXTERNAL_SEND_TARGET_MODEL(YYYYMMDD, SHOP_CODE, MODELNO, CATEGORY, S_CATEGORY, REGDATE)
		SELECT DISTINCT MIN(A.YYYYMMDD), MIN(A.SHOP_CODE), A.PL_MODELNO, MIN(B.G_CATEGORY), MIN(C.CATEGORY), MAX(F.UPD_DATE)
		FROM TBL_EXTERNAL_SEND_TARGET_PLNO A
			INNER JOIN GOODS B ON A.PL_MODELNO = B.G_MODELNO
			INNER JOIN TBL_EXTERNAL_ATTRIBUTE C ON C.SHOP_CODE = @SHOP_CODE AND C.CATEGORY = LEFT(B.G_CATEGORY, LEN(C.CATEGORY)) AND C.ATTRIBUTE_ID > 0
			INNER JOIN GOODS_CATEGORY_ATTRIBUTE D ON C.ATTRIBUTE_ID = D.ATTRIBUTE_ID AND D.CATEGORY IN (SELECT TOP 1 E.CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE E WHERE E.CATEGORY = LEFT(B.G_CATEGORY, 4) OR E.CATEGORY = LEFT(B.G_CATEGORY, 6) OR E.CATEGORY = LEFT(B.G_CATEGORY, 8) ORDER BY LEN(E.CATEGORY) DESC)
			INNER JOIN GOODS_CATALOG_ATTRIBUTE F ON B.G_MODELNO = F.G_MODELNO AND C.ATTRIBUTE_ID = F.ATTRIBUTE_ID AND F.DEL_YN = 'N'
		WHERE A.SHOP_CODE = @SHOP_CODE AND A.PL_MODELNO > 0
		GROUP BY A.PL_MODELNO
		OPTION (MAXDOP 1)
		
		----------------------------------------------------------
		-- 미입력 리스트
		----------------------------------------------------------
		DELETE /* UDP_LOTTE_PDSS_TARGET:07 */ FROM TBL_EXTERNAL_NON_TARGET WHERE SHOP_CODE = @SHOP_CODE
		INSERT /* UDP_LOTTE_PDSS_TARGET:08 */ INTO TBL_EXTERNAL_NON_TARGET(SHOP_CODE, MODELNO)
		SELECT DISTINCT @SHOP_CODE, B.G_MODELNO
		FROM TBL_EXTERNAL_SEND_TARGET_PLNO A
			INNER JOIN GOODS B ON A.PL_MODELNO = B.G_MODELNO
			LEFT JOIN TBL_EXTERNAL_SEND_TARGET_MODEL C ON C.SHOP_CODE = @SHOP_CODE AND A.PL_MODELNO = C.MODELNO
		WHERE A.SHOP_CODE = @SHOP_CODE AND A.PL_MODELNO > 0 AND C.MODELNO IS NULL
		OPTION (MAXDOP 1)
		
		----------------------------------------------------------
		-- 매칭 불가
		----------------------------------------------------------
		-- 오늘 기준 전체(누적) 불가 상품
		SELECT /* UDP_LOTTE_PDSS_TARGET:09 */ DISTINCT A.PL_NO, B.PL_CATEGORY, B.PL_GOODSCODE, B.PL_GOODSNM, B.PL_NOTE
		INTO #NEW_DENIED_PLNO
		FROM TBL_EXTERNAL_SEND_TARGET_PLNO A
			INNER JOIN PRICELIST B ON A.PL_NO = B.PL_NO
		WHERE A.SHOP_CODE = @SHOP_CODE AND A.PL_MODELNO < 0 AND A.PL_MODELNO NOT IN (0, -100, -200, -300)
		OPTION (MAXDOP 1)
		
		-- 변경 데이터 삭제처리
		DELETE /* UDP_LOTTE_PDSS_TARGET:10 */ FROM TBL_EXTERNAL_DENIED_PLNO
		WHERE SHOP_CODE = @SHOP_CODE
		  AND NOT EXISTS (SELECT TOP 1 1 FROM #NEW_DENIED_PLNO WHERE TBL_EXTERNAL_DENIED_PLNO.PL_NO = #NEW_DENIED_PLNO.PL_NO)		-- 신규(당일) 데이터
		
		-- 기전송 데이터 수정
		UPDATE /* UDP_LOTTE_PDSS_TARGET:11 */ TBL_EXTERNAL_DENIED_PLNO
		SET PL_CATEGORY = B.PL_CATEGORY, PL_GOODSNM = B.PL_GOODSNM, PL_NOTE = B.PL_NOTE
		FROM TBL_EXTERNAL_DENIED_PLNO A
			INNER JOIN #NEW_DENIED_PLNO B ON A.PL_NO = B.PL_NO
		WHERE A.SHOP_CODE = @SHOP_CODE
		OPTION (MAXDOP 1)
		
		-- 신규(당일) 데이터만 추가
		INSERT /* UDP_LOTTE_PDSS_TARGET:12 */ INTO TBL_EXTERNAL_DENIED_PLNO(SHOP_CODE, YYYYMMDD, PL_NO, PL_CATEGORY, PL_GOODSCODE, PL_GOODSNM, PL_NOTE)
		SELECT @SHOP_CODE, CONVERT(CHAR(8), DATEADD(D, -1, GETDATE()), 112), A.PL_NO, A.PL_CATEGORY, A.PL_GOODSCODE, A.PL_GOODSNM, A.PL_NOTE
		FROM #NEW_DENIED_PLNO A
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM TBL_EXTERNAL_DENIED_PLNO B WHERE B.SHOP_CODE = @SHOP_CODE AND A.PL_NO = B.PL_NO)	-- 기전송
		
		DROP TABLE #NEW_DENIED_PLNO
	END
END
