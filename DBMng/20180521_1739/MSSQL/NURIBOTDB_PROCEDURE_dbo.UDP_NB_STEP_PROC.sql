/* *************************************************************************
 * NAME : dbo.UDP_NB_STEP_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:37.123
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_STEP_PROC    스크립트 날짜: 2004-10-21 오후 3:40:38 ******/
CREATE      PROC UDP_NB_STEP_PROC
	@n_vcode INT,
	@n_step char(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE TBL_NB_SHOP 
	SET NBS_STEP = @n_step, NBS_END_DATE =  GETDATE()
	WHERE NBS_VCODE= @n_vcode
	SET NOCOUNT OFF
END

