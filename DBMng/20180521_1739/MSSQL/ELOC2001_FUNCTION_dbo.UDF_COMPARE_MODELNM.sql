/* *************************************************************************
 * NAME : dbo.UDF_COMPARE_MODELNM
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-01-20 17:45:19.55
 *        Modify: 2018-05-03 17:23:34.063
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE FUNCTION [dbo].[UDF_COMPARE_MODELNM] (@pre VARCHAR(140), @now VARCHAR(140))
RETURNS float
AS
BEGIN
	DECLARE @RETURN VARCHAR(140)
	DECLARE @STR VARCHAR(140)
	DECLARE @TOTAL FLOAT
	DECLARE @SAME FLOAT

	SET @TOTAL = 0
	SET @SAME = 0
	SET @PRE = REPLACE(@PRE, '(', ' (')
	IF CHARINDEX('@', @PRE) > 0
	BEGIN
		SET @PRE = SUBSTRING(@PRE, 1, CHARINDEX('@', @PRE) - 1)
	END
	IF CHARINDEX('@', @NOW) > 0
	BEGIN
		SET @NOW = SUBSTRING(@NOW, 1, CHARINDEX('@', @NOW) - 1)
	END

	--PRINT '=' + @PRE + '='
	--PRINT '=' + @NOW + '='

	WHILE LEN(@PRE) > 0
	BEGIN
		SET @STR	= LTRIM(RTRIM((CASE WHEN CHARINDEX(' ', @PRE) > 0 THEN SUBSTRING(@PRE, 1, CHARINDEX(' ', @PRE) - 1) ELSE @PRE END)))
		SET @PRE	= LTRIM(RTRIM((CASE WHEN CHARINDEX(' ', @PRE) > 0 THEN SUBSTRING(@PRE, CHARINDEX(' ', @PRE) + 1, 8000) ELSE '' END)))
		
		SET @TOTAL = @TOTAL + 1
		--IF ' ' + @NOW + ' ' LIKE '% ' + @STR + ' %'
		IF @NOW LIKE '%' + @STR + '%'
		BEGIN
			SET @SAME = @SAME + 1
		END
	END

	--PRINT '=' + CAST(@TOTAL AS VARCHAR(10)) + '='
	--PRINT '=' + CAST(@SAME AS VARCHAR(10)) + '='

	RETURN @SAME / @TOTAL  * 100
end
