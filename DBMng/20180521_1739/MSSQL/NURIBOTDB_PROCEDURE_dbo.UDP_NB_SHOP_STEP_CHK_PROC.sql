/* *************************************************************************
 * NAME : dbo.UDP_NB_SHOP_STEP_CHK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.64
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_SHOP_STEP_CHK_PROC    스크립트 날짜: 2004-10-21 오후 3:38:49 ******/
-- UP_NB_SHOP_STEP_CHK_PROC  :   2004.7.23 --
CREATE         PROC UDP_NB_SHOP_STEP_CHK_PROC
	@n_vcode INT,
	@n_step char(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT COUNT(NBS_VCODE) 
	FROM TBL_NB_SHOP WITH(READUNCOMMITTED)
	WHERE NBS_VCODE = @n_vcode AND NBS_STEP = @n_step
   
END


