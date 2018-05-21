/* *************************************************************************
 * NAME : dbo.UDP_JOB_GOODS_AGG_BY_CATE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:49:05.303
 *        Modify: 2018-05-13 19:49:05.303
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JOB_GOODS_AGG_BY_CATE
	@SDATE DATETIME
AS 
BEGIN
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2010.01.25
	-- 설  명 : 카테고리 작업현황 집계
    -- 참  고 : UDP_JOB_GOODS_AGG_SEL
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- 수정일:		수정자:		수정내용:
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- 오라클 데이터 가져오기
	-- 오라클에서 스케쥴은 4:30분에 진행
	CREATE TABLE #TBL_GOODS_SRV_CNT_AT_ORACLE (CA_CODE CHAR(4), SRVCNT INT)
	DECLARE @STR VARCHAR(8000)
	SET @STR = '''SELECT YYYYMMDD, CA_CODE, CA_COUNT FROM TBL_GOODS_CA_COUNT WHERE YYYYMMDD ='''''+ CONVERT(VARCHAR(8),@SDATE, 112) +''''''''

	INSERT INTO #TBL_GOODS_SRV_CNT_AT_ORACLE
	EXEC ('SELECT CA_CODE, CA_COUNT FROM OPENQUERY(ORADB_144, '+@STR+')')

	-- 데이터 삭제
	DELETE JOB_GOODS_AGG_BY_CATE WHERE REGDATE >= @SDATE AND REGDATE < @SDATE + 1

	-- 데이터 입력
	INSERT INTO JOB_GOODS_AGG_BY_CATE(REGDATE, MCATE, GOODS_SRV_CNT, MIS_CATAL_CNT, ADD_MODEL_CNT, NEW_CATAL_CNT, TMP_CATAL_CNT,TMP_SRV_CNT)
	-- 서비스중(가격비교)
	-- 원분류만 일별/중분류별
	SELECT 
		@SDATE
	,	MCATE
	,	SUM(GOODS_SRV_CNT)
	,	SUM(MIS_CATA_CNT)
	,	SUM(ADD_MODEL_CNT)
	,	SUM(NEW_CATAL_CNT)
	,	SUM(TMP_CATAL_CNT)
	,	SUM(TMP_SRV_CNT)
	FROM
	(
		SELECT  MCATE = CA_CODE
		,		GOODS_SRV_CNT = SRVCNT
		,		MIS_CATA_CNT = 0
		,		ADD_MODEL_CNT = 0
		,		NEW_CATAL_CNT = 0
		,		TMP_CATAL_CNT = 0
		,		TMP_SRV_CNT = 0
		FROM	#TBL_GOODS_SRV_CNT_AT_ORACLE
		UNION ALL
		-- 작업예정(=미작업 카탈로그)
		-- G_WORK = 9
		SELECT  MCATE = LEFT(G_CATEGORY, 4)
		,		GOODS_SRV_CNT = 0
		,		MIS_CATA_CNT = COUNT(*)
		,		ADD_MODEL_CNT = 0
		,		NEW_CATAL_CNT = 0
		,		TMP_CATAL_CNT = 0
		,		TMP_SRV_CNT = 0
		FROM ELOC188.ELOC2001.DBO.GOODS 
		WHERE G_WORK = '9'
		GROUP BY LEFT(G_CATEGORY, 4)
		UNION ALL
		-- 신규모델 추가/ 신규카탈로그 / 임시카탈로그 / 즉시서비스
		SELECT  MCATE = LEFT(G_CATEGORY, 4)
		,		GOODS_SRV_CNT = 0
		,		MIS_CATA_CNT = 0
		,		ADD_MODEL_CNT = SUM(T1)
		,		NEW_CATAL_CNT = SUM(T2)
		,		TMP_CATAL_CNT = SUM(T3)
		,		TMP_SRV_CNT = SUM(T4)
		FROM
		(
			SELECT 
				JG_MODELNO
			,	ISNULL(SUM(CASE WHEN JG_FLAG='0' THEN 1 ELSE 0 END),0) AS T1	-- 신규모델
			,	ISNULL(SUM(CASE WHEN JG_FLAG='1' THEN 1 ELSE 0 END),0) AS T2	-- 신규카탈로그
			,	ISNULL(SUM(CASE WHEN JG_FLAG='4' THEN 1 ELSE 0 END),0) AS T3	-- 임시카탈로그		
			,	ISNULL(SUM(CASE WHEN JG_FLAG='7' THEN 1 ELSE 0 END),0) AS T4	-- 즉시서비스
			FROM 
			(	
				SELECT	DISTINCT JG_MODELNO, JG_FLAG, JG_ID
				FROM	JOB_GOODS			
				WHERE	JG_DATE >= @SDATE
				AND		JG_DATE < @SDATE+1
			) TBL_TMP_JOB_GOODS
			GROUP BY JG_MODELNO
		) TBL_TMP_LOG INNER JOIN analstore.DBO.GOODS on JG_MODELNO = G_MODELNO
		GROUP BY LEFT(G_CATEGORY,4)
	) TBL_TMP_RESULT
	GROUP BY MCATE
END


