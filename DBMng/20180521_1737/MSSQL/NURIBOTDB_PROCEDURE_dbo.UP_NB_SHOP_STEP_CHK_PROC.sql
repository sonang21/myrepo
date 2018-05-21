/* *************************************************************************
 * NAME : dbo.UP_NB_SHOP_STEP_CHK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:48.403
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1737
 ************************************************************************* */

-- UP_NB_SHOP_STEP_CHK_PROC  :   2004.7.23 --
CREATE        PROC UP_NB_SHOP_STEP_CHK_PROC
	@n_vcode Char(4),
	@n_step char(1)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT COUNT(NBS_VCODE) 
	FROM TBL_NB_SHOP WITH(READUNCOMMITTED)
	WHERE NBS_VCODE = @n_vcode AND NBS_STEP = @n_step
   
	SET NOCOUNT OFF
