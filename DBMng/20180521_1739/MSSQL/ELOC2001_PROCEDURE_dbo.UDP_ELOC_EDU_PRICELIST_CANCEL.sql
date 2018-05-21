/* *************************************************************************
 * NAME : dbo.UDP_ELOC_EDU_PRICELIST_CANCEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-01-25 19:15:40.14
 *        Modify: 2018-05-03 17:23:35.213
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_ELOC_EDU_PRICELIST_CANCEL	
	@PL_VCODE		INT,	
	@PL_NO			bigINT,	
	@PL_STATUS		CHAR(1),	
	@iRETURN		INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST SET PL_STATUS = @PL_STATUS WHERE PL_VCODE = @PL_VCODE AND PL_NO = @PL_NO
	
	IF @@ERROR<>0
		BEGIN	
			SET @iRETURN = 99
		END
	ELSE
		BEGIN	
			SET @iRETURN = 0
				
		END

END
