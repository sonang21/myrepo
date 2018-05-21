/* *************************************************************************
 * NAME : dbo.UDF_RTN_AttachWordReplace
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-03-04 17:52:23.267
 *        Modify: 2018-05-03 17:23:35.713
 *        Backup: 20180521_1737
 ************************************************************************* */


create FUNCTION [dbo].[UDF_RTN_AttachWordReplace] (@Input VARCHAR(MAX), @NotWordPattern VARCHAR(MAX), @AttachChr CHAR(1), @ReplaceChr CHAR(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
	--DECLARE @Input VARCHAR(MAX)
	--DECLARE @NotWordPattern VARCHAR(MAX)
	--DECLARE @AttachChr CHAR(1)
	--SET @Input = 'ELLE GOLF I¿¤¸£°ñÇÁI (¿©¼º)±ä±âÀåÄ³ÁÖ¾óÁ¶³¢_6A21402'
	--SET @NotWordPattern = '[^0-9a-z]'
	--SET @AttachChr = ' '

	DECLARE @Return		VARCHAR(MAX)
	DECLARE @Input_Temp VARCHAR(MAX)
	DECLARE @SzStr		VARCHAR(MAX)
	DECLARE @PreSzStr	VARCHAR(MAX)

	SET @Return		= ''
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
				SET @Return = @Return + @ReplaceChr
			ELSE IF @PreSzStr <> ''
				SET @Return = @Return + @AttachChr
			
			SET @PreSzStr = @SzStr
			SET @Return = @Return + @PreSzStr
		END

	RETURN @Return
END
