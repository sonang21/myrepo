/* *************************************************************************
 * NAME : dbo.UP_EX_SELECT_CATEGORY_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-08-17 14:31:00.077
 *        Modify: 2015-05-15 00:52:26.01
 *        Backup: 20180521_1739
 ************************************************************************* */




-- UP_EX_SELECT_CATEGORY_PROC   :   2004.8.17 --
CREATE       PROC UP_EX_SELECT_CATEGORY_PROC 
	@szInsCcode INT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		SELECT NBSE_NO, NBSE_CATEGORY, NBSE_ATYPE, NBSE_BTYPE
		FROM TBL_NB_SHOP_EX WITH (READUNCOMMITTED) 
		WHERE NBSE_VCODE = @szInsCcode ORDER BY NBSE_NO ASC
	SET NOCOUNT OFF



