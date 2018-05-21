/* *************************************************************************
 * NAME : dbo.UDP_VA_SHOPLIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-07-26 18:25:00.357
 *        Modify: 2018-05-03 17:23:34.127
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_VA_SHOPLIST
	@SHOPCODE INT,

	@LISTSIZE	INT,
	@PAGESIZE	INT,
	@PAGE		INT
	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @SEEK INT
	SET @SEEK = @LISTSIZE * @PAGE

	DECLARE @SQL NVARCHAR(3000)
	DECLARE @CNTSQL NVARCHAR(1000)
	DECLARE @DETAILSQL NVARCHAR(1000)
	DECLARE @ORDERSQL NVARCHAR(100)
	
	SET @CNTSQL = N' SELECT COUNT(IDX) '
	SET @DETAILSQL =  N' SELECT TOP  ' + CONVERT( VARCHAR(15), @SEEK)
	SET @DETAILSQL = @DETAILSQL +  N' D.IDX, '
	SET @DETAILSQL = @DETAILSQL +  N' D.V_CODE, '
	SET @DETAILSQL = @DETAILSQL +  N' S.SHOP_NAME, '
	SET @DETAILSQL = @DETAILSQL +  N' D.V_VA, '
	SET @DETAILSQL = @DETAILSQL +  N' D.V_REGDATE, '
	SET @DETAILSQL = @DETAILSQL +  N' D.V_COMMENT '


	SET @SQL = N' FROM TBL_VALIST D '
	SET @SQL = @SQL +  N' INNER JOIN SHOPLIST S '
	SET @SQL = @SQL +  N' ON D.V_CODE = S.SHOP_VCODE '

	IF @SHOPCODE>0 
	BEGIN
		SET @SQL = @SQL +  N' WHERE D.V_CODE = ' + CAST( @SHOPCODE  AS VARCHAR(10))
	END

	SET @ORDERSQL = N' ORDER BY D.V_CODE DESC, D.V_VA DESC '
	
	DECLARE @LASTSQL	NVARCHAR(4000)
	--1. 전체 갯수확인
	SET @LASTSQL = @CNTSQL + @SQL
	EXEC SP_EXECUTESQL @LASTSQL

	--2. 리스트 확인
	SET @LASTSQL = @DETAILSQL + @SQL + @ORDERSQL
	EXEC SP_EXECUTESQL @LASTSQL

	
END
