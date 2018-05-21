/* *************************************************************************
 * NAME : dbo.UDP_WEBB_DEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-07-16 15:04:31.503
 *        Modify: 2018-05-03 17:23:34.487
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[UDP_WEBB_DEL]

	@VCODE			INT,
	@GOODSCODE		VARCHAR(50),
		
	@iRETURN	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	update pricelist set pl_date = getdate(), pl_status = '3'
	Where pl_vcode = @VCODE and pl_goodscode = @GOODSCODE and PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE) and pl_status <> '5'

	IF @@ERROR = 0 and @@rowcount > 0
		BEGIN
			SET @iRETURN = 0
		END
	ELSE 
		BEGIN
			SET @iRETURN = 99
		END
	
END
