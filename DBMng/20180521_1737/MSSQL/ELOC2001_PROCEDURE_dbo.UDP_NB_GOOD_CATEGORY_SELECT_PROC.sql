/* *************************************************************************
 * NAME : dbo.UDP_NB_GOOD_CATEGORY_SELECT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.513
 *        Modify: 2018-05-03 17:23:35.373
 *        Backup: 20180521_1737
 ************************************************************************* */




-- UDP_NB_GOOD_CATEGORY_SELECT_PROC  :   2004.7.23 --
CREATE    PROC UDP_NB_GOOD_CATEGORY_SELECT_PROC
	@xintAutoModelNo INT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
		SELECT g_category 
		FROM GOODS WITH(READUNCOMMITTED)
		WHERE g_modelno =@xintAutoModelNo
	SET NOCOUNT OFF



