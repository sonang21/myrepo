/* *************************************************************************
 * NAME : dbo.UDP_DEL_PRICELIST3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-01-17 15:30:21.717
 *        Modify: 2018-05-03 17:23:35.827
 *        Backup: 20180521_1739
 ************************************************************************* */











CREATE          PROC [dbo].[UDP_DEL_PRICELIST3]
	@NDATE DATETIME,
	@NUM	INT
AS
BEGIN

	SET NOCOUNT ON
	SET XACT_ABORT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @MAX INT
	DECLARE @TNO INT
	DECLARE @T TABLE
	( IDX INT IDENTITY(1,1),
	  PL_NO INT)
		

	INSERT INTO @T(PL_NO)
	SELECT PL_NO FROM PRICELIST WITH (READUNCOMMITTED) 
	WHERE  pl_date < @NDATE 
		AND PL_DUTYCODE=@NUM
		and pl_status = '5'
	
	SELECT @MAX = MAX(IDX) FROM @T

	WHILE @MAX<>0
	BEGIN
		BEGIN TRAN --DISTRIBUTED TRAN
		SELECT @TNO = PL_NO
		FROM @T
		WHERE IDX = @MAX

		--DELETE FROM SEARCHKEY_193.SEARCHKEY.DBO.TBL_PRICELIST_KEYWORD WHERE PK_PLNO = @TNO
		DELETE FROM PRICELIST WHERE PL_NO = @TNO
		SET @MAX = @MAX-1
		COMMIT TRAN
	END		
	
	
END








