/* *************************************************************************
 * NAME : dbo.UDP_GOODS_INFO_GIG_DELETE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-03-09 19:03:26.497
 *        Modify: 2015-05-15 03:31:33.157
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UDP_GOODS_INFO_GIG_DELETE]
	@nGigNo INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @nPoint1 INT
	DECLARE @nPoint2 INT
	DECLARE @nPoint3 MONEY
	DECLARE @nMinPrice DECIMAL(10,2)
	DECLARE @nBasePrice INT
	DECLARE @nModelno INT
	DECLARE @MAX INT
	
	IF @nGigNo > 0
	BEGIN
		CREATE TABLE #POINT_DELETED(
			IDX INT IDENTITY(1,1),
			MODELNO INT )

		-- 해당 GIG_NO 삭제 후 DELETED 데이터 만듬.
		DELETE TBL_GOODS_INFO_POINT
			OUTPUT
				DELETED.G_MODELNO
				INTO #POINT_DELETED(MODELNO)
		FROM TBL_GOODS_INFO_POINT
		WHERE GIG_NO = @nGigNo
/*
		UPDATE #POINT_DELETED
		SET BASEPRICE=A.POINT
		FROM #POINT_DELETED
			INNER JOIN TBL_GOODS_INFO_POINT A
			ON (MODELNO = A.G_MODELNO AND GIG_NO = 0)
*/
		SELECT @MAX = @@ROWCOUNT
		WHILE @MAX<>0
		BEGIN
			SELECT @nModelno=MODELNO
			FROM #POINT_DELETED 
			WHERE IDX=@MAX		
			
			SET @nPoint1 = ISNULL((SELECT SUM(POINT) FROM TBL_GOODS_INFO_POINT
									  WHERE G_MODELNO=@nModelno AND FLAG='1'), 0)		
			SET @nPoint2 = ISNULL((SELECT SUM(POINT) FROM TBL_GOODS_INFO_POINT
									  WHERE G_MODELNO=@nModelno AND FLAG='2'), 0)		
			SET @nBasePrice = ISNULL((SELECT POINT FROM TBL_GOODS_INFO_POINT
										 WHERE G_MODELNO=@nModelno AND GIG_NO=0), 0)		

			SET @nMinPrice = ISNULL(
				(SELECT TOP 1 (CASE PL_RIGHTNLEFT WHEN '1' THEN PL_PRICE
												  ELSE PL_PRICE + 2500 END) AS MINPRICE
				 FROM PRICELIST
				 WHERE PL_MODELNO = @nModelno AND PL_STATUS < '3' AND PL_SRVFLAG = '0'
				 ORDER BY MINPRICE), 0)
			
			IF @nPoint1 > 0
				SET @nPoint1 = @nPoint1 + 50
			IF @nPoint2 > 0
				SET @nPoint2 = @nPoint2 + 50
			IF @nPoint1 > 100
				SET @nPoint1 = 99
			IF @nPoint2 > 100
				SET @nPoint2 = 99
			
			-- 가격 적절성 평점
			IF @nMinPrice > 0
			BEGIN
				SET @nPoint3 = ROUND((2*@nPoint1+@nPoint2)*@nBasePrice*100.0/300.0/@nMinPrice,0)
				IF @nPoint3 > 100
					SET @nPoint3 = 99
			END
			ELSE
				SET @nPoint3 = 0

			UPDATE GOODS
			SET G_INFO_POINT1 = @nPoint1,
				G_INFO_POINT2 = @nPoint2,
				G_INFO_POINT3 = @nPoint3
			WHERE G_MODELNO = @nModelno

			SET @MAX = @MAX-1
		END
	END	
END