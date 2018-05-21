/* *************************************************************************
 * NAME : dbo.INSTR
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-02-12 13:37:46.04
 *        Modify: 2018-05-03 17:23:34.157
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE function dbo.INSTR (
@Start INTEGER = 1 --시작
, @String1 nvarchar(2000) --문자열1
, @String2 nvarchar(2000) --문자열2
)
RETURNS INTEGER
AS
BEGIN
WHILE LEN(@String1) - @Start > = 0
BEGIN
IF SUBSTRING(@String1, @Start, LEN(@String2)) = @String2
BREAK
SET @Start = @Start + 1
END
IF @Start > LEN(@String1)
SELECT @Start = 0
RETURN @Start
END


