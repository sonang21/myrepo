/* *************************************************************************
 * NAME : dbo.UDF_RTN_HANGEUL_PATTERN
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2015-03-20 17:44:27.213
 *        Modify: 2018-05-03 17:23:35.35
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE FUNCTION [dbo].[UDF_RTN_HANGEUL_PATTERN] (@szStr VARCHAR(500))
RETURNS VARCHAR(510)
AS
BEGIN
	DECLARE @RETURN VARCHAR(510)
	
	SELECT @RETURN = 
		CASE
			WHEN CHARINDEX(RIGHT(@szStr,1), '¤¡¤¢¤¤¤§¤¨¤©¤±¤²¤³¤µ¤¶¤·¤¸¤¹¤º¤»¤¼¤½¤¾') > 0
				THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE('ƒ‰') + ((UNICODE('±î') - UNICODE('°¡')) * (CHARINDEX(RIGHT(@szStr,1), '¤¡¤¢¤¤¤§¤¨¤©¤±¤²¤³¤µ¤¶¤·¤¸¤¹¤º¤»¤¼¤½¤¾') - 1))) + ']'
			WHEN UNICODE(RIGHT(@szStr,1)) >= UNICODE('°¡') AND UNICODE(RIGHT(@szStr,1)) <= UNICODE('ÆR')
				THEN
					CASE
						WHEN UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡') - ((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / 28 * 28) = 0
							THEN
								'[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE('°¡') + ((((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / (UNICODE('°³') - UNICODE('°¡'))) + 1) * (UNICODE('°³') - UNICODE('°¡'))) - 1) + ']'
						ELSE
							CASE UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡') - ((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / 28 * 28)
								WHEN 1
									THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE(RIGHT(@szStr,1)) - (UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡') - ((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / 28 * 28)) + 3) + ']'
								WHEN 4
									THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE(RIGHT(@szStr,1)) - (UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡') - ((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / 28 * 28)) + 6) + ']'
								WHEN 8
									THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE(RIGHT(@szStr,1)) - (UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡') - ((UNICODE(RIGHT(@szStr,1)) - UNICODE('°¡')) / 28 * 28)) + 15) + ']'
								WHEN 17
									THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE(RIGHT(@szStr,1)) + 1) + ']'
								WHEN 19
									THEN '[' + RIGHT(@szStr,1) + '-' + NCHAR(UNICODE(RIGHT(@szStr,1)) + 1) + ']'
								ELSE RIGHT(@szStr,1)
							END
					END
			ELSE RIGHT(@szStr,1)
		END
	
	RETURN LEFT(@szStr, LEN(@szStr) - 1) + @RETURN
END