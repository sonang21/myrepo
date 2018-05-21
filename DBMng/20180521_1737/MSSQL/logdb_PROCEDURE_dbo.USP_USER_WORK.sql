/* *************************************************************************
 * NAME : dbo.USP_USER_WORK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-12-26 16:24:32.373
 *        Modify: 2016-05-13 17:44:09.65
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC USP_USER_WORK
	@ID VARCHAR(12),
	@SDATE DATETIME,
	@EDATE DATETIME
AS 
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	------------------------------------------
	-- made by	: wookki25 2007-05-08 am 10:25
	-- desc		: 당일 업무현황
	--	http://jca.enuri.com/team_contents/JobLogStatistics_Today.asp
	-- ---------------------------------------
	-- 프로시저 내용 수정시 아래 프로시저도 함께 수정해야한다.
	--		196.logdb.USP_USER_WORK
	--		196.oltplog.UDP_JOB_PRICELIST_CNT 
	------------------------------------------
	SELECT	SUM(T0) AS T0, SUM(T1) AS T1, SUM(T2) AS T2, SUM(T3) AS T3
		,	SUM(T4) AS T4, SUM(T5) AS T5, SUM(T6) AS T6, SUM(T7) AS T7
		,	sum(T8) as t8, sum(t9) as t9, sum(t10) as t10, sum(t11) as t11
		,	sum(t12) as t12, sum(t13) as t13, sum(t14) as t14, sum(t15) as t15
		,	sum(t16) as t16, sum(t17) as t17, sum(t18) as t18, sum(t19) as t19
	FROM
	(
		SELECT 
			ISNULL(SUM(CASE WHEN JG_FLAG in ('0') THEN 1 ELSE 0 END),0) AS T0	-- 신규모델
		,	ISNULL(SUM(CASE WHEN JG_FLAG='7' THEN 1 ELSE 0 END),0) AS T1	-- 즉시서비스
		,	ISNULL(SUM(CASE WHEN JG_FLAG='1' THEN 1 ELSE 0 END),0) AS T2	-- 신규카탈로그
		,	ISNULL(SUM(CASE WHEN JG_FLAG='4' THEN 1 ELSE 0 END),0) AS T3	-- 임시카탈로그		
		,	ISNULL(SUM(CASE WHEN JG_FLAG='3' THEN 1 ELSE 0 END),0) AS T4	-- 모델저장
		,	ISNULL(SUM(CASE WHEN JG_FLAG='2' THEN 1 ELSE 0 END),0) AS T5	-- 특징저장
		,	0 AS T6 ,0 AS T7,0 AS T8, 0 as T9
		,	ISNULL(SUM(CASE WHEN JG_FLAG='8' THEN 1 ELSE 0 END),0) AS T10	-- 신규모델(그룹모델)
		,	ISNULL(SUM(CASE WHEN JG_FLAG='9' THEN 1 ELSE 0 END),0) AS T11	-- 유사->일반 전환 작업(단종코드 5 -> 1로 바뀐 모델)
		,	isnull(sum(case when jg_flag='d' then 1 else 0 end),0) as t12	-- 모델삭제
		,	isnull(sum(case when jg_flag='f' then 1 else 0 end),0) as t13	-- 요약저장

		,	isnull(sum(case when jg_flag='b' then 1 else 0 end),0) as t14	-- 동일상품명 추가
		,	0 as t15	-- 요약저장

		,	isnull(sum(case when jg_flag='P' then 1 else 0 end),0) as t16	-- 그룹매칭.제조사품번
		,	isnull(sum(case when jg_flag='M' then 1 else 0 end),0) as t17	-- 그룹매칭.에누리모델명
		,	0 as t18, 0 as t19

		FROM 
		(	
			SELECT	DISTINCT JG_MODELNO, JG_FLAG
			FROM	JOB_GOODS			
			WHERE	JG_ID = @ID
			AND		JG_DATE >= @SDATE
			AND		JG_DATE < @EDATE
		) TBL_TMP_JOB_GOODS
		UNION ALL	
		SELECT 
			0,0,0,0,0,0
		,	SUM(CASE WHEN JP_MODELNO > 0 AND JP_FLAG IN ('0','2') THEN 1 ELSE 0 END) AS T6	-- (+) 번호작업
		,	isnull(SUM(CASE WHEN JP_MODELNO > 0 AND JP_FLAG = '5' THEN 1 ELSE 0 END),0) AS T7	-- (+) 번호작업 (그룹매칭)
		,	SUM(CASE WHEN JP_FLAG = '1' THEN 1 ELSE 0 END)										-- 기타작업
			+SUM(CASE WHEN JP_MODELNO > 0 AND JP_FLAG = '4' THEN 1 ELSE 0 END)	AS T8			-- 카테고리 변경
		,	SUM(CASE WHEN JP_MODELNO <= 0 AND JP_FLAG NOT IN ('1','4','5') THEN 1 ELSE 0 END)	-- (-) 번호작업
			+SUM(CASE WHEN JP_MODELNO <= 0 AND JP_FLAG = '4' THEN 1 ELSE 0 END) AS T9			-- 카테고리 변경	
		,	0 as t10,0 as t11,0 as t12,0 as t13,0 as t14
		,	SUM(CASE WHEN JP_MODELNO > 0 AND JP_FLAG ='6' THEN 1 ELSE 0 END) AS T15	-- 동일상품명 번호>0

		, 0, 0
		,	sum(case when jp_modelno > 0 and jp_flag in ('P') then 1 else 0 end) as t18	-- 그룹매칭.제조사품번	
		,	sum(case when jp_modelno > 0 and jp_flag in ('M') then 1 else 0 end) as t19	-- 그룹매칭.에누리모델명	
		FROM 
		(
			SELECT DISTINCT JP_PLISTNO, ISNULL(JP_MODELNO,0) AS JP_MODELNO, ISNULL(JP_FLAG,0) JP_FLAG
			FROM 	JOB_PRICELIST
			WHERE (JP_ID = @ID OR JP_ID='SM_' + @ID)
				AND JP_DATE >= @SDATE
				AND JP_DATE < @EDATE			
		) A
	) B
END






