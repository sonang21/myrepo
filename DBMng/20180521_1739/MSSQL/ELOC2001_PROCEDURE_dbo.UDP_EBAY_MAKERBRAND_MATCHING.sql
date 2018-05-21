/* *************************************************************************
 * NAME : dbo.UDP_EBAY_MAKERBRAND_MATCHING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-12 15:35:47.407
 *        Modify: 2018-05-03 17:23:35.763
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_EBAY_MAKERBRAND_MATCHING]
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- *************************************************************
	-- 이베이 제조사 기준
	SELECT MAKER_ID EBAY_ID, MAKER_NM EBAY_NM,
		(SELECT TOP 1 ENURI_MAKER_ID
		 FROM TBL_EBAY_MATCHING_MAKER A
			INNER JOIN TBL_ENURI_MAKER B ON ENURI_MAKER_ID = B.MAKER_ID WHERE EBAY_MAKER_ID = C.MAKER_ID AND A.DEL_YN = 'N' AND B.DEL_YN = 'N') ENURI_ID
	INTO #TEMP_MAKER_MATCHING
	FROM TBL_EBAY_MAKER C
	WHERE DEL_YN = 'N' AND
		((UPD_DATE >= CAST(CAST(DATEADD(DAY, -1, GETDATE()) AS VARCHAR(10)) AS SMALLDATETIME) AND UPD_DATE < CAST(CAST(GETDATE() AS VARCHAR(10)) AS SMALLDATETIME)) OR
		 (INS_DATE >= CAST(CAST(DATEADD(DAY, -1, GETDATE()) AS VARCHAR(10)) AS SMALLDATETIME) AND INS_DATE < CAST(CAST(GETDATE() AS VARCHAR(10)) AS SMALLDATETIME)))
	OPTION (MAXDOP 1)
	
	DELETE FROM #TEMP_MAKER_MATCHING WHERE ENURI_ID IS NOT NULL
	
	UPDATE #TEMP_MAKER_MATCHING
	SET ENURI_ID = (
		SELECT TOP 1 MAKER_ID
		FROM TBL_ENURI_MAKER
		WHERE DEL_YN = 'N' AND MAKER_NM IS NOT NULL AND (
			MAKER_NM = REPLACE(CASE WHEN CHARINDEX('[', EBAY_NM) > 0 AND CHARINDEX(']', EBAY_NM) > 0 AND CHARINDEX(']', EBAY_NM) > CHARINDEX('[', EBAY_NM) THEN SUBSTRING(EBAY_NM, CHARINDEX('[', EBAY_NM) + 1, CHARINDEX(']', EBAY_NM) - CHARINDEX('[', EBAY_NM) - 1) ELSE NULL END, '''', '''''') OR
			MAKER_NM = REPLACE(CASE WHEN CHARINDEX('(주)', EBAY_NM) > 0 THEN REPLACE(EBAY_NM, '(주)', '') ELSE NULL END, '''', '''''') OR
			MAKER_NM = REPLACE(EBAY_NM, '''', ''''''))
		ORDER BY MAKER_NM)
	OPTION (MAXDOP 1)
	
	UPDATE TBL_EBAY_MATCHING_MAKER
	SET DEL_YN = 'N', UPD_DATE = GETDATE(), UPD_OPRT = 'Lab_batch'
	FROM TBL_EBAY_MATCHING_MAKER
		INNER JOIN #TEMP_MAKER_MATCHING ON EBAY_ID = EBAY_MAKER_ID AND ENURI_ID = ENURI_MAKER_ID
	WHERE DEL_YN = 'Y' AND ENURI_ID IS NOT NULL
	
	INSERT INTO TBL_EBAY_MATCHING_MAKER (ENURI_MAKER_ID, EBAY_MAKER_ID, DEL_YN, INS_DATE, INS_OPRT)
	SELECT ENURI_ID, EBAY_ID, 'N', GETDATE(), 'Lab_batch'
	FROM #TEMP_MAKER_MATCHING
		LEFT JOIN TBL_EBAY_MATCHING_MAKER ON EBAY_ID = EBAY_MAKER_ID AND ENURI_ID = ENURI_MAKER_ID
	WHERE ENURI_MAKER_ID IS NULL AND ENURI_ID IS NOT NULL
	-- *************************************************************
	

	-- *************************************************************
	-- 이베이 브랜드 기준
	SELECT BRAND_ID EBAY_ID, BRAND_NM EBAY_NM,
		(SELECT TOP 1 ENURI_BRAND_ID
		 FROM TBL_EBAY_MATCHING_BRAND A
			INNER JOIN TBL_ENURI_BRAND B ON ENURI_BRAND_ID = B.BRAND_ID WHERE EBAY_BRAND_ID = C.BRAND_ID AND A.DEL_YN = 'N' AND B.DEL_YN = 'N') ENURI_ID
	INTO #TEMP_BRAND_MATCHING
	FROM TBL_EBAY_BRAND C
	WHERE DEL_YN = 'N' AND
		((UPD_DATE >= CAST(CAST(DATEADD(DAY, -1, GETDATE()) AS VARCHAR(10)) AS SMALLDATETIME) AND UPD_DATE < CAST(CAST(GETDATE() AS VARCHAR(10)) AS SMALLDATETIME)) OR
		 (INS_DATE >= CAST(CAST(DATEADD(DAY, -1, GETDATE()) AS VARCHAR(10)) AS SMALLDATETIME) AND INS_DATE < CAST(CAST(GETDATE() AS VARCHAR(10)) AS SMALLDATETIME)))
	OPTION (MAXDOP 1)
	
	DELETE FROM #TEMP_BRAND_MATCHING WHERE ENURI_ID IS NOT NULL
	
	UPDATE #TEMP_BRAND_MATCHING
	SET ENURI_ID = (
		SELECT TOP 1 BRAND_ID
		FROM TBL_ENURI_BRAND
		WHERE DEL_YN = 'N' AND BRAND_NM IS NOT NULL AND (
			BRAND_NM = REPLACE(CASE WHEN CHARINDEX('[', EBAY_NM) > 0 AND CHARINDEX(']', EBAY_NM) > 0 AND CHARINDEX(']', EBAY_NM) > CHARINDEX('[', EBAY_NM) THEN SUBSTRING(EBAY_NM, CHARINDEX('[', EBAY_NM) + 1, CHARINDEX(']', EBAY_NM) - CHARINDEX('[', EBAY_NM) - 1) ELSE NULL END, '''', '''''') OR
			BRAND_NM = REPLACE(CASE WHEN CHARINDEX('(주)', EBAY_NM) > 0 THEN REPLACE(EBAY_NM, '(주)', '') ELSE NULL END, '''', '''''') OR
			BRAND_NM = REPLACE(EBAY_NM, '''', ''''''))
		ORDER BY BRAND_NM)
	OPTION (MAXDOP 1)
	
	UPDATE TBL_EBAY_MATCHING_BRAND
	SET DEL_YN = 'N', UPD_DATE = GETDATE(), UPD_OPRT = 'Lab_batch'
	FROM TBL_EBAY_MATCHING_BRAND
		INNER JOIN #TEMP_BRAND_MATCHING ON EBAY_ID = EBAY_BRAND_ID AND ENURI_ID = ENURI_BRAND_ID
	WHERE DEL_YN = 'Y' AND ENURI_ID IS NOT NULL
	
	INSERT INTO TBL_EBAY_MATCHING_BRAND (ENURI_BRAND_ID, EBAY_BRAND_ID, DEL_YN, INS_DATE, INS_OPRT)
	SELECT ENURI_ID, EBAY_ID, 'N', GETDATE(), 'Lab_batch'
	FROM #TEMP_BRAND_MATCHING
		LEFT JOIN TBL_EBAY_MATCHING_BRAND ON EBAY_ID = EBAY_BRAND_ID AND ENURI_ID = ENURI_BRAND_ID
	WHERE ENURI_BRAND_ID IS NULL AND ENURI_ID IS NOT NULL
	-- *************************************************************
END
