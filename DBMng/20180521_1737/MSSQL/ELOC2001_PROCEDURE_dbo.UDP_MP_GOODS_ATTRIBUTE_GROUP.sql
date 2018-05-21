/* *************************************************************************
 * NAME : dbo.UDP_MP_GOODS_ATTRIBUTE_GROUP
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:28:02.22
 *        Modify: 2018-05-03 17:23:35.513
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_GOODS_ATTRIBUTE_GROUP]
	@MODELNO INT,
	@MM_ID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	DECLARE @CATEGORY VARCHAR(12)
	SELECT @CATEGORY = G_CATEGORY
	FROM GOODS
	WHERE G_MODELNO = @MODELNO;
	
	DECLARE @PARTCODE VARCHAR(15)
	SELECT @PARTCODE = MM_PARTCODE
	FROM SEARCHKEY_193.ENURIDB.DBO.MM_ENURI
	WHERE MM_ID = @MM_ID
	
	SELECT GROUPNAME
		 , DISPLAY_ORDER
		 , MIN_ID
		 , MAX_ID
	INTO #GOODS_GROUP_ATTRIBUTE
	FROM
	(
		SELECT CASE WHEN CHARINDEX('_', MANAGE_ATTRIBUTE_NM) > 0 THEN SUBSTRING(MANAGE_ATTRIBUTE_NM, 1, CHARINDEX('_', MANAGE_ATTRIBUTE_NM)) ELSE MANAGE_ATTRIBUTE_NM END GROUPNAME
		     , MIN(DISPLAY_ORDER) DISPLAY_ORDER
			 , MIN(A.ATTRIBUTE_ID) MIN_ID
			 , MAX(A.ATTRIBUTE_ID) MAX_ID
		FROM GOODS_ATTRIBUTE A
			INNER JOIN GOODS_CATEGORY_ATTRIBUTE B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND B.CATEGORY IN (SELECT TOP 1 CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE WHERE CATEGORY = LEFT(@CATEGORY, 4) OR CATEGORY = LEFT(@CATEGORY, 6) OR CATEGORY = LEFT(@CATEGORY, 8) ORDER BY LEN(CATEGORY) DESC)
		WHERE DEL_YN = 'N'
		GROUP BY CASE WHEN CHARINDEX('_', MANAGE_ATTRIBUTE_NM) > 0 THEN SUBSTRING(MANAGE_ATTRIBUTE_NM, 1, CHARINDEX('_', MANAGE_ATTRIBUTE_NM)) ELSE MANAGE_ATTRIBUTE_NM END
	) A
	
	SELECT ATTRIBUTE_ID
		 , COUNT(*) CNT
	INTO #USE_ATTRIBUTE
	FROM GOODS_CATALOG_ATTRIBUTE
	WHERE G_MODELNO = @MODELNO AND DEL_YN = 'N'
	GROUP BY ATTRIBUTE_ID
	
	SELECT *
	FROM (
		SELECT A.ATTRIBUTE_ID
				, -1 ATTRIBUTE_GROUP_ORDER
				, 'MIRS �Ӽ�_' + MANAGE_ATTRIBUTE_NM MANAGE_ATTRIBUTE_NM
				, GALLERY_ATTRIBUTE_NM
				, USE_CLASS_CODE
				, GROUP_ATTRIBUTE_ID
				, GROUP_CHAR
				, 'MIRS �Ӽ�' GROUPNAME
				, ISNULL(CNT, 0) CNT
		FROM GOODS_ATTRIBUTE A
			INNER JOIN GOODS_CATEGORY_ATTRIBUTE B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND B.CATEGORY IN (SELECT TOP 1 CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE WHERE CATEGORY = LEFT(@CATEGORY, 4) OR CATEGORY = LEFT(@CATEGORY, 6) OR CATEGORY = LEFT(@CATEGORY, 8) ORDER BY LEN(CATEGORY) DESC)
			INNER JOIN TBL_EXTERNAL_ATTRIBUTE C ON SHOP_CODE = 590 AND C.CATEGORY = LEFT(@CATEGORY, LEN(C.CATEGORY)) AND A.ATTRIBUTE_ID = C.ATTRIBUTE_ID
			LEFT JOIN #USE_ATTRIBUTE D ON A.ATTRIBUTE_ID = D.ATTRIBUTE_ID
		UNION ALL
		SELECT A.ATTRIBUTE_ID
				, C.DISPLAY_ORDER ATTRIBUTE_GROUP_ORDER
				, MANAGE_ATTRIBUTE_NM
				, GALLERY_ATTRIBUTE_NM
				, USE_CLASS_CODE
				, GROUP_ATTRIBUTE_ID
				, GROUP_CHAR
				, REPLACE(CASE WHEN MIN_ID = MAX_ID OR RIGHT(GROUPNAME, 1) <> '_' THEN '' ELSE GROUPNAME END, '_', '') GROUPNAME
				, ISNULL(CNT, 0) CNT
		FROM GOODS_ATTRIBUTE A
			INNER JOIN GOODS_CATEGORY_ATTRIBUTE B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND B.CATEGORY IN (SELECT TOP 1 CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE WHERE CATEGORY = LEFT(@CATEGORY, 4) OR CATEGORY = LEFT(@CATEGORY, 6) OR CATEGORY = LEFT(@CATEGORY, 8) ORDER BY LEN(CATEGORY) DESC)
			INNER JOIN #GOODS_GROUP_ATTRIBUTE C ON CASE WHEN CHARINDEX('_', MANAGE_ATTRIBUTE_NM) > 0 THEN SUBSTRING(MANAGE_ATTRIBUTE_NM, 1, CHARINDEX('_', MANAGE_ATTRIBUTE_NM)) ELSE MANAGE_ATTRIBUTE_NM END = GROUPNAME
			LEFT JOIN #USE_ATTRIBUTE D ON A.ATTRIBUTE_ID = D.ATTRIBUTE_ID
		WHERE DEL_YN = 'N'
	) A
	WHERE ATTRIBUTE_GROUP_ORDER >= (CASE WHEN @PARTCODE = '101202318464' /*MIRS��*/ THEN -1 ELSE 0 END)
	ORDER BY ATTRIBUTE_GROUP_ORDER
			, CASE WHEN ISNULL(GROUP_ATTRIBUTE_ID, 0) = A.ATTRIBUTE_ID THEN '0' ELSE '1' END
			, MANAGE_ATTRIBUTE_NM
END
