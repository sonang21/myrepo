/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DEL_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.67
 *        Modify: 2018-05-03 17:23:35.397
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE     PROC UDP_NB_PRICELIST_DEL_PROC
	@p_vcode INT,
	@p_goodsnm nVarChar(800)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '3', PL_DATE = getdate() 
	WHERE 	PL_VCODE = @p_vcode AND PL_GOODSNM = @p_goodsnm
	
END 
