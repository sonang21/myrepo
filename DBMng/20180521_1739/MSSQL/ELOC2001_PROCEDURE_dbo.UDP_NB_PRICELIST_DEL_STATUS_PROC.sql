/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DEL_STATUS_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.747
 *        Modify: 2018-05-03 17:23:35.41
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE    PROC UDP_NB_PRICELIST_DEL_STATUS_PROC
	@p_no int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
	UPDATE PRICELIST SET PL_STATUS = '3' WHERE PL_NO = @p_no
END
