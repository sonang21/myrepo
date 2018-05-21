/* *************************************************************************
 * NAME : dbo.UDP_GOODS_ROW_DELETE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-01-29 10:25:58.557
 *        Modify: 2018-05-03 17:23:36.053
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_GOODS_ROW_DELETE]
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- 미반영건 or 반영 오류 재반영
	SELECT G_MODELNO
	INTO #TARGET_CATALOG
	FROM GOODS
	WHERE (G_MODELNM = '모델삭제' AND G_FLAG = '1')
	   OR (G_MODELNM = '모델삭제' AND G_CATEGORY <> '00000000')
	   OR (G_MODELNM <> '모델삭제' AND G_CATEGORY = '00000000')
	OPTION (MAXDOP 1)
	
	DECLARE @MODELNO INT
	DECLARE FETCH_CURSOR CURSOR FOR
	SELECT G_MODELNO
	FROM #TARGET_CATALOG
	
	OPEN FETCH_CURSOR
	
	FETCH NEXT FROM FETCH_CURSOR INTO @MODELNO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC UDP_GOODS_INIT @MODELNO, 'DB-agent'	-- 모델삭제 프로시저 (ELOC & ORACLE)
		DELETE FROM GOODS WHERE G_MODELNO = @MODELNO
		
		FETCH NEXT FROM FETCH_CURSOR INTO @MODELNO
	END
	
	CLOSE FETCH_CURSOR
	DEALLOCATE FETCH_CURSOR
	
	-- 모델삭제 GOODS ROW 삭제
	SET ROWCOUNT 100;
	DECLARE @ROWCOUNT INT
	SET @ROWCOUNT = 100
	
	WHILE @ROWCOUNT > 0
	BEGIN
		DELETE FROM GOODS
		WHERE G_MODELNM = '모델삭제' AND G_CATEGORY = '00000000' AND G_FLAG = '0'
		OPTION (MAXDOP 1)
		
		SET @ROWCOUNT = @@ROWCOUNT
	END
	SET ROWCOUNT 0;
END
