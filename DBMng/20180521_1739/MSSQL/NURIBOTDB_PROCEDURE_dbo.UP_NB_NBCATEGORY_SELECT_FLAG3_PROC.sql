/* *************************************************************************
 * NAME : dbo.UP_NB_NBCATEGORY_SELECT_FLAG3_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-08-26 08:32:13.297
 *        Modify: 2015-05-15 00:52:26.01
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UP_NB_NBCATEGORY_SELECT_FLAG3_PROC  :   2004.8.26 --
-- TBL_NB_CATEGORY FLAG=3 카테고리 추출
CREATE     PROC UP_NB_NBCATEGORY_SELECT_FLAG3_PROC
	@szVcode Char(4)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT nbc_no ,nbc_category ,nbc_url 
		FROM TBL_NB_CATEGORY WITH(READUNCOMMITTED) 
		WHERE nbc_vcode = @szVcode and nbc_flag = '3'
		ORDER BY nbc_category
		DESC, nbc_no
	SET NOCOUNT OFF

