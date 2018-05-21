/* *************************************************************************
 * NAME : dbo.UDF_RTN_REPLACE_STRING
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2015-04-22 13:57:15.18
 *        Modify: 2018-05-03 17:23:34.383
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE FUNCTION [dbo].[UDF_RTN_REPLACE_STRING] (@szStr VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @RETURN VARCHAR(1000)
	
	SET @RETURN = CASE WHEN CHARINDEX('[', @szStr) = 1 AND CHARINDEX(']', @szStr) > CHARINDEX('[', @szStr) 
					   THEN
							CASE WHEN CHARINDEX('[', SUBSTRING(@szStr, CHARINDEX('[', @szStr) + 1, CHARINDEX(']', @szStr) - CHARINDEX('[', @szStr) - 1)) = 0
								 THEN SUBSTRING(@szStr, CHARINDEX(']', @szStr) + 1, 1000)
								 ELSE @szStr END
					   ELSE @szStr END
	
	SET @RETURN = REPLACE(@RETURN, '`', ' ')
	SET @RETURN = REPLACE(@RETURN, '-', ' ')
	SET @RETURN = REPLACE(@RETURN, '=', ' ')
	SET @RETURN = REPLACE(@RETURN, '\', ' ')
	SET @RETURN = REPLACE(@RETURN, '[', ' ')
	SET @RETURN = REPLACE(@RETURN, ']', ' ')
	SET @RETURN = REPLACE(@RETURN, ';', ' ')
	SET @RETURN = REPLACE(@RETURN, '''', ' ')
	SET @RETURN = REPLACE(@RETURN, ',', ' ')
	SET @RETURN = REPLACE(@RETURN, '.', ' ')
	SET @RETURN = REPLACE(@RETURN, '/', ' ')
	SET @RETURN = REPLACE(@RETURN, '~', ' ')
	SET @RETURN = REPLACE(@RETURN, '!', ' ')
	SET @RETURN = REPLACE(@RETURN, '@', ' ')
	SET @RETURN = REPLACE(@RETURN, '#', ' ')
	SET @RETURN = REPLACE(@RETURN, '$', ' ')
	SET @RETURN = REPLACE(@RETURN, '%', ' ')
	SET @RETURN = REPLACE(@RETURN, '^', ' ')
	SET @RETURN = REPLACE(@RETURN, '&', ' ')
	SET @RETURN = REPLACE(@RETURN, '*', ' ')
	SET @RETURN = REPLACE(@RETURN, '(', ' ')
	SET @RETURN = REPLACE(@RETURN, ')', ' ')
	SET @RETURN = REPLACE(@RETURN, '_', ' ')
	SET @RETURN = REPLACE(@RETURN, '+', ' ')
	SET @RETURN = REPLACE(@RETURN, '|', ' ')
	SET @RETURN = REPLACE(@RETURN, '{', ' ')
	SET @RETURN = REPLACE(@RETURN, '}', ' ')
	SET @RETURN = REPLACE(@RETURN, ':', ' ')
	SET @RETURN = REPLACE(@RETURN, '"', ' ')
	SET @RETURN = REPLACE(@RETURN, '<', ' ')
	SET @RETURN = REPLACE(@RETURN, '>', ' ')
	SET @RETURN = REPLACE(@RETURN, '?', ' ')
	
	RETURN @RETURN
END
