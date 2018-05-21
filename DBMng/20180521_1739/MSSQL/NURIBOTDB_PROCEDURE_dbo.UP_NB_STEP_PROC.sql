/* *************************************************************************
 * NAME : dbo.UP_NB_STEP_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:51.327
 *        Modify: 2015-05-15 00:52:25.997
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE     PROC UP_NB_STEP_PROC
	@n_vcode Char(4),
	@n_step char(1)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE TBL_NB_SHOP 
	SET NBS_STEP = @n_step, NBS_END_DATE =  GETDATE()
	WHERE NBS_VCODE= @n_vcode
	SET NOCOUNT OFF


