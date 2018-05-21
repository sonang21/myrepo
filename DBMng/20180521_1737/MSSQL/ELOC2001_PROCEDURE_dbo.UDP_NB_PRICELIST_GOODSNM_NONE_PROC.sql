/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_GOODSNM_NONE_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.98
 *        Modify: 2018-05-03 17:23:35.463
 *        Backup: 20180521_1737
 ************************************************************************* */





-- UDP_NB_PRICELIST_GOODSNM_NONE_PROC  :   2004.7.23 --
CREATE      PROC UDP_NB_PRICELIST_GOODSNM_NONE_PROC
	@p_list_1 int,
	@p_list_2 INT,
	@p_list_4 nvarChar(400)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED		
	
		SELECT COUNT(*) 
		FROM PRICELIST WITH(READUNCOMMITTED)
		WHERE PL_NO = @p_list_1
		
	SET NOCOUNT OFF




