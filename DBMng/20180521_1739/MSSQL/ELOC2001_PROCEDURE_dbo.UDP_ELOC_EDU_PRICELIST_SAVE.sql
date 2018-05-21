/* *************************************************************************
 * NAME : dbo.UDP_ELOC_EDU_PRICELIST_SAVE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-01-25 19:15:40.34
 *        Modify: 2018-05-03 17:23:35.3
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_ELOC_EDU_PRICELIST_SAVE
	@PL_NO		bigINT,	
	@PL_VCODE		INT,	
	@PL_GOODSNM	NVARCHAR(200),
	@PL_PRICE		MONEY,
		
	@iRETURN		INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN
		UPDATE PRICELIST SET PL_GOODSNM = @PL_GOODSNM, PL_PRICE = @PL_PRICE, PL_DATE = GetDate()
		WHERE PL_VCODE = @PL_VCODE AND PL_NO = @PL_NO
	END

	IF @@ERROR<>0
		BEGIN

			SET @iRETURN = 99
		END
	ELSE
		BEGIN

			SET @iRETURN = 00
				
		END

END
