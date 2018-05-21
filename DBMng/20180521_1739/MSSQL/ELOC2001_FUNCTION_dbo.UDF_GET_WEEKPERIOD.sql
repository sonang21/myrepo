/* *************************************************************************
 * NAME : dbo.UDF_GET_WEEKPERIOD
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2007-03-05 13:19:10.64
 *        Modify: 2018-05-03 17:23:35.363
 *        Backup: 20180521_1739
 ************************************************************************* */


create  FUNCTION UDF_GET_WEEKPERIOD 
(@PDATE DATETIME)
RETURNS varchar(8)
AS
BEGIN
	DECLARE @J INT
	DECLARE @W INT
	SET @J=0
	WHILE @J=0
	BEGIN
		IF DATEPART(W, @PDATE)=1
		BEGIN
			SET @J=1
		END
		ELSE
		BEGIN
			SET @PDATE = DATEADD(D,-1, @PDATE)
		END
	END
	
	--PRINT CONVERT(VARCHAR(8),@PDATE,112)
	DECLARE @MON VARCHAR(6)
	SET @MON=LEFT(CONVERT(VARCHAR(8), @PDATE,112),6)
	
	DECLARE @N INT
	SET @N=1
	SET @J=0
	WHILE @J=0
	BEGIN
	 	IF CONVERT(VARCHAR(8), DATEADD(D,-7,@PDATE),112) > (@MON+'01')
		BEGIN
			SET @PDATE=DATEADD(D,-7,@PDATE)
			SET @N = @N+1
		END
		ELSE
		BEGIN
			SET @J=1
		END
	END
	--PRINT @N
	RETURN @MON + '0' + CAST(@N AS VARCHAR(1))

END

