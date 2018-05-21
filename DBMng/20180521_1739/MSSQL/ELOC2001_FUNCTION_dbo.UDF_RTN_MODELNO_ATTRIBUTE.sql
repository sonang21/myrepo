/* *************************************************************************
 * NAME : dbo.UDF_RTN_MODELNO_ATTRIBUTE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-02-19 09:51:10.33
 *        Modify: 2018-05-03 17:23:35.76
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE FUNCTION [dbo].[UDF_RTN_MODELNO_ATTRIBUTE] (@MODELNO INT, @CATEGORY VARCHAR(12))
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @RETURN VARCHAR(8000)
	DECLARE @SEQNO INT
	DECLARE @ATTRIBUTE_NM VARCHAR(40)
	DECLARE @VALUE VARCHAR(500)
	
	DECLARE FETCH_CURSOR CURSOR FOR
	SELECT DENSE_RANK() OVER (PARTITION BY G_MODELNO ORDER BY D.DISPLAY_ORDER, C.DISPLAY_ORDER, ATTRIBUTE_ELEMENT) SEQNO
		 --, MANAGE_ATTRIBUTE_NM
		 , LTRIM(RTRIM(GALLERY_ATTRIBUTE_NM)) GALLERY_ATTRIBUTE_NM
		 --, B.IS_GALLERY_DISPLAY
		 , LTRIM(RTRIM(CASE WHEN USE_CLASS_CODE = '2' THEN ATTRIBUTE_VALUE ELSE ATTRIBUTE_ELEMENT END)) VALUE
		 --, C.IS_DISPLAY
	FROM GOODS_CATALOG_ATTRIBUTE A
		INNER JOIN GOODS_ATTRIBUTE B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
		INNER JOIN GOODS_ATTRIBUTE_ELEMENT C ON A.ATTRIBUTE_ID = C.ATTRIBUTE_ID AND A.ATTRIBUTE_ELEMENT_ID = C.ATTRIBUTE_ELEMENT_ID
		INNER JOIN GOODS_CATEGORY_ATTRIBUTE D ON A.ATTRIBUTE_ID = D.ATTRIBUTE_ID AND D.CATEGORY IN (SELECT TOP 1 CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE WHERE CATEGORY = LEFT(@CATEGORY, 4) OR CATEGORY = LEFT(@CATEGORY, 6) OR CATEGORY = LEFT(@CATEGORY, 8) ORDER BY LEN(CATEGORY) DESC)
	WHERE A.DEL_YN = 'N'
	  AND B.DEL_YN = 'N'
	  AND C.DEL_YN = 'N'
	  AND B.CATEGORY <> '' AND G_MODELNO = @MODELNO
	
	OPEN FETCH_CURSOR
	
	SELECT @RETURN = ''
	FETCH NEXT FROM FETCH_CURSOR INTO @SEQNO, @ATTRIBUTE_NM, @VALUE
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--셀구분자: ★
        --속성원 구분자: ♥
		SELECT @RETURN = @RETURN + 
				CASE WHEN CHARINDEX('★' + @ATTRIBUTE_NM + '♥', SUBSTRING(@RETURN, LEN(@RETURN) - CHARINDEX('★', REVERSE(@RETURN)) + 2, 500)) = 1
				     THEN CASE WHEN @RETURN <> '' THEN '♥' ELSE '' END	+ @VALUE
					 ELSE CASE WHEN @RETURN <> '' THEN '★' ELSE '' END	+ @ATTRIBUTE_NM + '♥' + @VALUE
				END
		FETCH NEXT FROM FETCH_CURSOR INTO @SEQNO, @ATTRIBUTE_NM, @VALUE
	END
	
	CLOSE FETCH_CURSOR
	
	DEALLOCATE FETCH_CURSOR
	
	RETURN @RETURN
END