/* *************************************************************************
 * NAME : dbo.UDF_GET_WEEKOFMONTH
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2009-02-06 15:18:02.83
 *        Modify: 2018-05-03 17:23:35.587
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE FUNCTION UDF_GET_WEEKOFMONTH
	(@DATE_IN SMALLDATETIME)
	RETURNS varchar(8)
AS
BEGIN
	-- ---------------------------------------
	-- �ۼ��� : WOOKKI25 / 2008.06.10
	-- ��  �� : �ְ��׷��������� ���� �������� ��ȯ
	-- ��  �� : DBO.UDF_GET_WEEKOFMONTH('2008-06-07')
	-- ---------------------------------------
	DECLARE @LOOPDATE SMALLDATETIME			-- �Է��� ��(week)�� ���ԵǴ� ��¥
	DECLARE @FIRSTDAY SMALLDATETIME			-- �Է��� ��(week)�� ��(month) ������
	DECLARE @WEEKOFMONTH CHAR(8)			-- �Է��� �ְ�
		
	-- ����Ʈ�� ����
	SET @LOOPDATE = @DATE_IN		
	SET @LOOPDATE = CONVERT(VARCHAR(8), @LOOPDATE, 112)	


	-- �ְ����
	SET @FIRSTDAY = DATEADD(DD, -DAY(@LOOPDATE)+1, @LOOPDATE)
	SET @FIRSTDAY = CASE 
						WHEN DATEPART(WEEKDAY, @FIRSTDAY) > 1 AND DATEDIFF(WW, @FIRSTDAY, @LOOPDATE)= 0 THEN  
							DATEADD(MM,-1,@FIRSTDAY) 
						ELSE 
							@FIRSTDAY
					END	
	RETURN LEFT(CONVERT(VARCHAR(8), @FIRSTDAY, 112),6)+'0'+CAST(DATEDIFF(WW,@FIRSTDAY,@LOOPDATE)+(CASE WHEN DATEPART(WEEKDAY, @FIRSTDAY) > 1 THEN 0 ELSE 1 END) AS VARCHAR(2))
END

