/* *************************************************************************
 * NAME : dbo.UDP_REAL_GOODS_BATCH
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-09-08 18:18:27.31
 *        Modify: 2018-05-03 17:23:34.693
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [DBO].[UDP_REAL_GOODS_BATCH]
	@MODE INT
AS
BEGIN
	/*
		TRUNCATE TABLE TEMP_GOODS

		INSERT INTO TEMP_GOODS(G_MODELNO)
		SELECT G_MODELNO
		FROM GOODS
		WHERE G_CATEGORY <> '00000000' AND G_MODELNM <> '�𵨻���'
		OPTION (MAXDOP 1)
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	DECLARE @MODELNO INT

	SELECT G_MODELNO
	INTO #TEMP
	FROM TEMP_GOODS
	WHERE MODE = @MODE

	DECLARE CURSOR_FETCH CURSOR FOR
	SELECT G_MODELNO
	FROM #TEMP
	ORDER BY G_MODELNO

	OPEN CURSOR_FETCH

	FETCH NEXT FROM CURSOR_FETCH INTO @MODELNO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC UDP_MP_GOODS_CATALOG_ATTRIBUTE_UPLOAD @MODELNO

		FETCH NEXT FROM CURSOR_FETCH INTO @MODELNO
	END

	CLOSE CURSOR_FETCH
	DEALLOCATE CURSOR_FETCH
END
