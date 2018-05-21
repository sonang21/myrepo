/* *************************************************************************
 * NAME : dbo.UP_NB_NBCATEGORY_SELECT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:46.093
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC up_nb_nbcategory_select_proc
	@szVcode int
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT nbc_no ,nbc_category ,nbc_url
		FROM TBL_NB_CATEGORY WITH(READUNCOMMITTED) 
		WHERE nbc_vcode = @szVcode and nbc_flag < '2'
		ORDER BY nbc_category, nbc_no
	SET NOCOUNT OFF
