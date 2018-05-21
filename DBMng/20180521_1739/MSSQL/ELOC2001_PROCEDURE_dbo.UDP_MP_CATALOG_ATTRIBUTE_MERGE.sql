/* *************************************************************************
 * NAME : dbo.UDP_MP_CATALOG_ATTRIBUTE_MERGE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-15 18:01:20.007
 *        Modify: 2018-05-03 17:23:34.153
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_CATALOG_ATTRIBUTE_MERGE]
	@CATEGORY VARCHAR(12),
	@CATEFLAG VARCHAR(1),
	@EXCEPTFLAG VARCHAR(1),
	@MAKER VARCHAR(500),
	@BRAND VARCHAR(500),

	@MODELNM VARCHAR(500),
	@SPEC VARCHAR(500),
	@FUNC VARCHAR(500),
	@ID INT,
	@ELEMENT_ID SMALLINT,

	@VALUE VARCHAR(500),
	@CHAR VARCHAR(10),
	@ATTRIBUTE_ID INT,
	@ATTRIBUTE_ELEMENT_ID SMALLINT,
	@ATTRIBUTE_VALUE VARCHAR(500),

	@DIVIDE_CHAR VARCHAR(10),
	@MM_ID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	DECLARE @BATCH_FLAG SMALLINT

	SELECT @BATCH_FLAG = COUNT(*)
	FROM SEARCHKEY_193.ENURIDB.DBO.MM_ENURI
		INNER JOIN SEARCHKEY_193.ENURIDB.DBO.MM_CATEGORY ON MM_ID = MMC_ID
	WHERE MM_FLAG = '1' AND LEFT(MM_PARTCODE, 9) IN ('101202304', '101202305') AND MM_ID = @MM_ID AND (MMC_CATEGORY = LEFT(@CATEGORY, 2) OR MMC_CATEGORY = LEFT(@CATEGORY, 4))

	IF @BATCH_FLAG > 0
	BEGIN
		DECLARE @STR VARCHAR(1000)
		DECLARE @CA_CODE VARCHAR(12)
		SET @CA_CODE = ''
		IF @EXCEPTFLAG <> '' AND @ATTRIBUTE_ID > 0
			SELECT @CA_CODE = CATEGORY FROM GOODS_ATTRIBUTE WHERE ATTRIBUTE_ID = @ATTRIBUTE_ID

		IF ISNULL(@DIVIDE_CHAR, '') = ''
			SET @DIVIDE_CHAR = ','

		SET @ELEMENT_ID = NULL
		SET @VALUE = NULL
		SET @CHAR = NULL
		SET @ATTRIBUTE_VALUE = NULL
		IF ISNULL((SELECT USE_CLASS_CODE FROM GOODS_ATTRIBUTE WHERE ATTRIBUTE_ID = @ATTRIBUTE_ID), '') <> '2'
			SET @DIVIDE_CHAR = NULL

		IF ISNULL(@DIVIDE_CHAR, '') <> ''
		BEGIN
			DECLARE @QRY VARCHAR(8000)
			SET @MAKER = REPLACE(@MAKER, '''', '''''')
			SET @BRAND = REPLACE(@BRAND, '''', '''''')
			SET @MODELNM = REPLACE(@MODELNM, '''', '''''')
			SET @SPEC = REPLACE(@SPEC, '''', '''''')
			SET @FUNC = REPLACE(@FUNC, '''', '''''')
			SET @VALUE = REPLACE(@VALUE, '''', '''''')
			SET @CHAR = REPLACE(@CHAR, '''', '''''')
		
			CREATE TABLE #TEMP_GOODS(
				ORDER_BY INT,
				G_MODELNO INT,
				ATTRIBUTE_VALUE VARCHAR(500)
			)
			CREATE TABLE #LOG_GOODS(
				MM_ID VARCHAR(20),
				G_MODELNO INT,
				ATTRIBUTE_ID INT,
				ATTRIBUTE_ELEMENT_ID INT,
				ATTRIBUTE_VALUE VARCHAR(500),
				DEL_YN CHAR(1),
				STATUS CHAR(1),
				REGDATE DATETIME
			)
			CREATE TABLE #TEMP_SPEC(
				MODELNO INT,
				VALUE VARCHAR(500)
			)
			SET @QRY = ''
			IF @CATEGORY <> ''
				IF @CATEFLAG = '0'
					SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END +
							   ' G_CATEGORY LIKE ''' + @CATEGORY + '%'''
				ELSE
					SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
							   ' G_MODELNO IN (SELECT DISTINCT GA_MODELNO FROM GOODS_ADDCATE WHERE GA_FLAG <> ''3'' AND GA_CATEGORY LIKE ''' + @CATEGORY + '%'')'
			IF @EXCEPTFLAG = '1' AND @CA_CODE <> ''
				SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
						   ' G_MODELNO NOT IN (SELECT DISTINCT G_MODELNO FROM GOODS_CATALOG_ATTRIBUTE WHERE DEL_YN = ''N'' AND ATTRIBUTE_ID IN (SELECT ATTRIBUTE_ID FROM GOODS_ATTRIBUTE WHERE DEL_YN = ''N'' AND MANAGE_ATTRIBUTE_NM LIKE ''유사_[중소미]분류'' AND CATEGORY = ''' + @CA_CODE + '''))'
			ELSE IF @EXCEPTFLAG = '2' AND @CA_CODE <> ''
				SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
						   ' G_MODELNO IN (SELECT DISTINCT G_MODELNO FROM GOODS_CATALOG_ATTRIBUTE WHERE DEL_YN = ''N'' AND ATTRIBUTE_ID IN (SELECT ATTRIBUTE_ID FROM GOODS_ATTRIBUTE WHERE DEL_YN = ''N'' AND CATEGORY = ''' + @CA_CODE + '''))'
			ELSE IF @EXCEPTFLAG = '3' AND @CA_CODE <> ''
				SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
						   ' G_MODELNO IN (SELECT DISTINCT G_MODELNO FROM GOODS_CATALOG_ATTRIBUTE WHERE DEL_YN = ''N'' AND ATTRIBUTE_ID IN (SELECT ATTRIBUTE_ID FROM GOODS_ATTRIBUTE WHERE DEL_YN = ''N'' AND MANAGE_ATTRIBUTE_NM NOT LIKE ''유사_[중소미]분류'' AND CATEGORY = ''' + @CA_CODE + '''))'
			IF @MAKER <> ''
				SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
							' G_FACTORY = ''' + @MAKER + ''''
			IF @BRAND <> ''
				SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
							' G_BRAND = ''' + @BRAND + ''''
			IF @MODELNM <> ''
			BEGIN
				SET @STR = @MODELNM
				WHILE LEN(@STR) > 0
				BEGIN
					SET @MODELNM= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, 1, CHARINDEX('♠', @STR) - 1) ELSE @STR END))
					SET @STR	= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, CHARINDEX('♠', @STR) + 1, LEN(@STR)) ELSE '' END))

					SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
								' CHARINDEX(''' + @MODELNM + ''', G_MODELNM) > 0'
				END
			END
			IF @SPEC <> ''
			BEGIN
				SET @STR = @SPEC
				WHILE LEN(@STR) > 0
				BEGIN
					SET @SPEC	= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, 1, CHARINDEX('♠', @STR) - 1) ELSE @STR END))
					SET @STR	= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, CHARINDEX('♠', @STR) + 1, LEN(@STR)) ELSE '' END))

					SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
								' CHARINDEX(''' + @SPEC + ''', G_SPEC2) > 0'
				END
			END
			IF @FUNC <> ''
			BEGIN
				SET @STR = @FUNC
				WHILE LEN(@STR) > 0
				BEGIN
					SET @FUNC	= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, 1, CHARINDEX('♠', @STR) - 1) ELSE @STR END))
					SET @STR	= LTRIM(RTRIM(CASE WHEN CHARINDEX('♠', @STR) > 0 THEN SUBSTRING(@STR, CHARINDEX('♠', @STR) + 1, LEN(@STR)) ELSE '' END))

					SET @QRY = @QRY + CASE WHEN @QRY = '' THEN '' ELSE ' AND' END + 
								' CHARINDEX(''' + @FUNC + ''', G_FUNC) > 0'
				END
			END
		
			SET @QRY = ' INSERT INTO #TEMP_GOODS(ORDER_BY, G_MODELNO, ATTRIBUTE_VALUE)' +
					   ' SELECT DISTINCT DENSE_RANK() OVER(PARTITION BY G_MODELNO ORDER BY DISPLAY_ORDER, CASE WHEN USE_CLASS_CODE = ''2'' THEN ATTRIBUTE_VALUE ELSE ATTRIBUTE_ELEMENT END, A.ATTRIBUTE_ELEMENT_ID), G_MODELNO, CASE WHEN USE_CLASS_CODE = ''2'' THEN ATTRIBUTE_VALUE ELSE ATTRIBUTE_ELEMENT END ATTRIBUTE_VALUE' +
					   ' FROM GOODS_CATALOG_ATTRIBUTE A' +
					   '	INNER JOIN GOODS_ATTRIBUTE_ELEMENT B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND A.ATTRIBUTE_ELEMENT_ID = B.ATTRIBUTE_ELEMENT_ID' +
					   '	INNER JOIN GOODS_ATTRIBUTE C ON A.ATTRIBUTE_ID = C.ATTRIBUTE_ID' +
					   ' WHERE A.DEL_YN = ''N'' AND B.DEL_YN = ''N'' AND C.DEL_YN = ''N''' +
					   '   AND G_MODELNO IN (' +
					   '		SELECT G_MODELNO' +
					   '		FROM GOODS' +
					   '		WHERE' + @QRY + ')' +
					   '   AND NOT (A.ATTRIBUTE_ID = ' + CAST(@ATTRIBUTE_ID AS VARCHAR(20)) + ' AND A.ATTRIBUTE_ELEMENT_ID = ' + CAST(@ATTRIBUTE_ELEMENT_ID AS VARCHAR(20)) + ')' +
					   '   AND A.ATTRIBUTE_ID = ' + CAST(@ID AS VARCHAR(20)) +
					   'OPTION (MAXDOP 2)'
		
			EXEC (@QRY)
		
			DECLARE @I INT
			DECLARE @MAX INT
		
			SELECT @MAX = MAX(ORDER_BY)
			FROM #TEMP_GOODS
		
			INSERT INTO #TEMP_SPEC(MODELNO, VALUE)
			SELECT G_MODELNO, ATTRIBUTE_VALUE
			FROM #TEMP_GOODS
			WHERE ORDER_BY = 1
		
			SET @I = 2
			WHILE @I <= @MAX
			BEGIN
				UPDATE #TEMP_SPEC
				SET VALUE = VALUE + CASE WHEN CHARINDEX(@DIVIDE_CHAR + ATTRIBUTE_VALUE + @DIVIDE_CHAR, @DIVIDE_CHAR + VALUE + @DIVIDE_CHAR) > 0 THEN '' ELSE @DIVIDE_CHAR + ATTRIBUTE_VALUE END
				FROM #TEMP_SPEC 
					INNER JOIN #TEMP_GOODS ON G_MODELNO = MODELNO
				WHERE ORDER_BY = @I
			
				SET @I = @I + 1
			END
		
			UPDATE GOODS_CATALOG_ATTRIBUTE
			SET DEL_YN = 'N' , UPD_DATE = GETDATE(), UPD_OPRT = @MM_ID, INS_DATE = GETDATE(), ATTRIBUTE_VALUE = VALUE
			OUTPUT @MM_ID, DELETED.G_MODELNO, DELETED.ATTRIBUTE_ID, DELETED.ATTRIBUTE_ELEMENT_ID, DELETED.ATTRIBUTE_VALUE, 'Y', 'I', GETDATE()
				INTO #LOG_GOODS
			FROM GOODS_CATALOG_ATTRIBUTE 
				INNER JOIN #TEMP_SPEC ON G_MODELNO = MODELNO AND ATTRIBUTE_ID = @ATTRIBUTE_ID AND ATTRIBUTE_ELEMENT_ID = @ATTRIBUTE_ELEMENT_ID
			WHERE DEL_YN = 'Y'
		
			INSERT INTO GOODS_CATALOG_ATTRIBUTE(G_MODELNO, ATTRIBUTE_ID, ATTRIBUTE_ELEMENT_ID, ATTRIBUTE_VALUE, INS_DATE, INS_OPRT, DEL_YN, UPD_DATE, UPD_OPRT)
			OUTPUT @MM_ID, INSERTED.G_MODELNO, INSERTED.ATTRIBUTE_ID, INSERTED.ATTRIBUTE_ELEMENT_ID, INSERTED.ATTRIBUTE_VALUE, 'Y', 'I', GETDATE()
				INTO #LOG_GOODS
			SELECT DISTINCT MODELNO, @ATTRIBUTE_ID, @ATTRIBUTE_ELEMENT_ID, VALUE, GETDATE(), @MM_ID, 'N', GETDATE(), @MM_ID
			FROM #TEMP_SPEC
			WHERE MODELNO NOT IN 
			(
				SELECT G_MODELNO
				FROM GOODS_CATALOG_ATTRIBUTE
				WHERE DEL_YN = 'N'
				  AND ATTRIBUTE_ID = @ATTRIBUTE_ID
				  AND ATTRIBUTE_ELEMENT_ID = @ATTRIBUTE_ELEMENT_ID
			)
		
			UPDATE GOODS
			SET G_FLAG = '1'
			WHERE G_MODELNO IN (SELECT DISTINCT G_MODELNO FROM #LOG_GOODS)
			
			DELETE FROM GOODS_CATALOG_ATTRIBUTE_BACKUP
			WHERE MM_ID = @MM_ID AND REGDATE < CONVERT(CHAR(10), GETDATE(), 23)

			INSERT INTO GOODS_CATALOG_ATTRIBUTE_BACKUP(MM_ID, G_MODELNO, ATTRIBUTE_ID, ATTRIBUTE_ELEMENT_ID, ATTRIBUTE_VALUE, DEL_YN, STATUS, REGDATE)
			SELECT MM_ID, G_MODELNO, ATTRIBUTE_ID, ATTRIBUTE_ELEMENT_ID, ATTRIBUTE_VALUE, DEL_YN, STATUS, REGDATE
			FROM #LOG_GOODS
		END
	END
END
