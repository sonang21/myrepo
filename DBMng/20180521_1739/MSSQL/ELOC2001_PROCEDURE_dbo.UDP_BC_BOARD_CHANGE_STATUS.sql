/* *************************************************************************
 * NAME : dbo.UDP_BC_BOARD_CHANGE_STATUS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.437
 *        Modify: 2018-05-03 17:23:34.937
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_BC_BOARD_CHANGE_STATUS    스크립트 날짜: 2004-10-23 오전 10:55:11 ******/
CREATE  PROC UDP_BC_BOARD_CHANGE_STATUS
	@GROUP INT,
	@REF	INT,
	@STATUS VARCHAR(1),

	@iRETURN INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	BEGIN TRAN
		UPDATE TBL_BC_BOARD 
		SET BB_STATUS=@STATUS
		WHERE BB_GROUP = @GROUP
			AND BB_REF = @REF
		
	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRAN
		SET @iRETURN=99
	END
	ELSE
	BEGIN
		COMMIT TRAN
		SET @iRETURN=0	
	END
	
END


