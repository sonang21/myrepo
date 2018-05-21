/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DEL_PROC_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-02-05 13:56:18.047
 *        Modify: 2018-05-03 17:23:35.377
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE      PROC UDP_NB_PRICELIST_DEL_PROC_1
	@p_vcode INT,
	@p_no INT,
	@p_goodsnm nVarChar(800)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '3', PL_DATE = getdate() 
	WHERE 	PL_VCODE = @p_vcode AND PL_NO = @p_no AND PL_GOODSNM = @p_goodsnm
END
