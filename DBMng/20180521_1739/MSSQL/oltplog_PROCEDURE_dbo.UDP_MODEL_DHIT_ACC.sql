/* *************************************************************************
 * NAME : dbo.UDP_MODEL_DHIT_ACC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:54:42.697
 *        Modify: 2018-05-13 19:54:42.697
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_MODEL_DHIT_ACC
	@DTE_IN SMALLDATETIME=''
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.04.16
	-- 설  명 : 일간 상품창 노출수 집계
	-- 실  행 : UDP_MODEL_DHIT_ACC
	-- ----------------------------------------------------------------------------------		
	DECLARE @DTE_DAY CHAR(8)
	IF @DTE_IN = ''
		SET @DTE_DAY = CONVERT(CHAR(8),  DATEADD(D, -1, GETDATE()),112)
	ELSE
		SET @DTE_DAY = CONVERT(CHAR(8), @DTE_IN, 112)


	DELETE TBL_MODEL_DHIT WHERE MD_DD=@DTE_DAY

	INSERT INTO TBL_MODEL_DHIT(G_MODELNO, MD_DD, G_CATEGORY, MD_DUP_HIT, MD_HIT, POINT)
	SELECT 	MODELNO, @DTE_DAY, ISNULL(G_CATEGORY,'00000000') AS G_CATEGORY, UHIT, HIT, POINT
	FROM
		(
		SELECT
				MODELNO, COUNT(*) AS UHIT, SUM(HIT) AS HIT, SUM(POINT) AS POINT
		FROM
				(
				SELECT  MODELNO, SUM(HIT) AS HIT, MAX(POINT) AS POINT
				FROM
						(
						-- IP 중복제거
						SELECT  MODELNO, MAX(TMPID) AS TMPID, COUNT(*) AS HIT, MAX(POINT) AS POINT
						FROM	TBL_MODEL_LOG
						WHERE	REGDATE = @DTE_DAY
						GROUP BY  MODELNO, USERIP
						UNION ALL
						-- IP 중복허용
						SELECT	MODELNO, TMPID, 0 AS HIT, POINT
						FROM	TBL_MODEL_LOG
						WHERE	REGDATE = @DTE_DAY AND USERIP IN(SELECT USERIP FROM TBL_MODEL_LOG_FILTERIP)
						) A
				GROUP BY  MODELNO, TMPID
				)	B
		GROUP BY MODELNO
		) C
			INNER JOIN
		analstore.DBO.GOODS
			ON MODELNO=G_MODELNO

		-- 해외아이피 제외처리
		-- 단종모델이라서 아래 처리 삭제 / wookki25 2011.01.04
        --EXEC UDP_MODEL_DHIT_ACC_EXTRA @DTE_DAY,1192309


