/* *************************************************************************
 * NAME : dbo.UDF_RTN_AttachWordIsMatch
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-03-04 17:51:26.143
 *        Modify: 2018-05-03 17:23:35.487
 *        Backup: 20180521_1739
 ************************************************************************* */


create FUNCTION [dbo].[UDF_RTN_AttachWordIsMatch] (@Input VARCHAR(MAX), @NotWordPattern VARCHAR(MAX), @AttachChr CHAR(1))
RETURNS BIT
AS
BEGIN
	--DECLARE @Input VARCHAR(MAX)
	--DECLARE @NotWordPattern VARCHAR(MAX)
	--DECLARE @AttachChr CHAR(1)
	--SET @Input = 'ELLE GOLF I¿¤¸£°ñÇÁI (¿©¼º)±ä±âÀåÄ³ÁÖ¾óÁ¶³¢_6A21402'
	--SET @NotWordPattern = '[^0-9a-z]'
	--SET @AttachChr = ' '

	DECLARE @Return		BIT
	DECLARE @Input_Temp VARCHAR(MAX)
	DECLARE @SzStr		VARCHAR(MAX)
	DECLARE @PreSzStr	VARCHAR(MAX)

	SET @Return = 0
	SET @Input_Temp = @Input
	SET @SzStr		= ''
	SET @PreSzStr	= ''
	WHILE CHARINDEX(@AttachChr + @AttachChr, @Input_Temp) > 0
		BEGIN
			SET @Input_Temp = LTRIM(RTRIM(REPLACE(@Input_Temp, @AttachChr + @AttachChr, @AttachChr)))
		END

	WHILE @Input_Temp <> ''
		BEGIN
			SET @SzStr		= LTRIM(RTRIM(CASE WHEN CHARINDEX(@AttachChr, @Input_Temp) > 0 THEN SUBSTRING(@Input_Temp, 1, CHARINDEX(@AttachChr, @Input_Temp) - 1) ELSE @Input_Temp END))
			SET @Input_Temp = LTRIM(RTRIM(CASE WHEN CHARINDEX(@AttachChr, @Input_Temp) > 0 THEN SUBSTRING(@Input_Temp, CHARINDEX(@AttachChr, @Input_Temp) + 1, LEN(@Input_Temp)) ELSE '' END))
			
			IF @PreSzStr <> '' AND PATINDEX('%' + @NotWordPattern + '%', @PreSzStr) = 0 AND PATINDEX('%' + @NotWordPattern + '%', @SzStr) = 0
				BEGIN
					--PRINT @PreSzStr + @AttachChr + @SzStr
					SET @Return = 1
					BREAK
				END

			SET @PreSzStr = @SzStr
		END

	RETURN @Return
END
