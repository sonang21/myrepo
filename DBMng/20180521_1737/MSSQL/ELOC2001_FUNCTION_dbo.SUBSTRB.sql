/* *************************************************************************
 * NAME : dbo.SUBSTRB
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2016-03-03 09:14:58.647
 *        Modify: 2018-05-03 17:23:34.273
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE FUNCTION DBO.SUBSTRB(@STR VARCHAR(8000), @START INT, @LEN INT)
RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @I INT
	
	SET @I = @LEN
	WHILE (@I > 0)
		BEGIN
			IF DATALENGTH(SUBSTRING(@STR, @START, @I)) <= @LEN
				BREAK

			SET @I = @I - 1
		END

	RETURN SUBSTRING(@STR, @START, @I)
	END
