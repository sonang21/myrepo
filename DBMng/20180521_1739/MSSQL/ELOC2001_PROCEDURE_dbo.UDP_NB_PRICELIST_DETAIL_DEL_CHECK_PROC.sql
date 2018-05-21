/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DETAIL_DEL_CHECK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.827
 *        Modify: 2018-05-03 17:23:35.43
 *        Backup: 20180521_1739
 ************************************************************************* */





-- UDP_NB_PRICELIST_DETAIL_DEL_CHECK_PROC  :   2004.7.23 --
CREATE    PROC UDP_NB_PRICELIST_DETAIL_DEL_CHECK_PROC
	@p_vcode INT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT pl_goodsnm 
	FROM PRICELIST WITH(READUNCOMMITTED)
	WHERE pl_vcode = @p_vcode and pl_goodsnm is NOT NULL and Len(pl_goodsnm) > 1 and pl_status < '3'
	SET NOCOUNT OFF




