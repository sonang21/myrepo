/* *************************************************************************
 * NAME : dbo.UDP_GOODS_INFO_GIC_DELETE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-03-09 19:03:10.7
 *        Modify: 2018-05-03 17:23:34.02
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UDP_GOODS_INFO_GIC_DELETE]
	@nGicNo Int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @nGigNo INT
	DECLARE @MAX INT

	CREATE TABLE #GIG_DELETED(
		IDX INT IDENTITY(1,1),
		GIG_NO INT)
	
	-- 해당 GIG_NO 삭제 후 DELETED 데이터 만듬.
	DELETE TBL_GOODS_INFO_GROUP
		OUTPUT
			DELETED.GIG_NO
			INTO #GIG_DELETED(GIG_NO)
	FROM TBL_GOODS_INFO_GROUP
	WHERE GIC_NO = @nGicNo
	
	SET @MAX = @@ROWCOUNT
	WHILE @MAX<>0
	BEGIN
		-- 필요한 데이터 셋팅
		SELECT @nGigNo=GIG_NO
		FROM #GIG_DELETED 
		WHERE IDX=@MAX		
		
		-- POINT 정보 삭제
		IF @nGigNo > 0
			EXEC UDP_GOODS_INFO_GIG_DELETE @nGigNo
		
		SET @MAX = @MAX-1
	END	
END