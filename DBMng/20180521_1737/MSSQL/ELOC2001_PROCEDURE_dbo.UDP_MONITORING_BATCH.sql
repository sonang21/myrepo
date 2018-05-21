/* *************************************************************************
 * NAME : dbo.UDP_MONITORING_BATCH
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-01-20 17:23:38.69
 *        Modify: 2018-05-03 17:23:35.97
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [dbo].[UDP_MONITORING_BATCH]
	@FILTER VARCHAR(4000) = ''
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	IF @FILTER <> ''
	BEGIN
		DECLARE @QRY NVARCHAR(4000)
		SET @QRY = N'
			DELETE FROM TBL_MONITORING_TARGET
			'+ @FILTER + ' AND P_STATUS = ''I'' AND ASSIGN_MM_ID IS NOT NULL'
				
		EXEC (@QRY)
		SET ROWCOUNT 0 
	End
