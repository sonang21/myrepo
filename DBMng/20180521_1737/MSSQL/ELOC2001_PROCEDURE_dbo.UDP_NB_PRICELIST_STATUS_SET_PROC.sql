/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_STATUS_SET_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.623
 *        Modify: 2018-05-03 17:23:35.617
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE     PROC UDP_NB_PRICELIST_STATUS_SET_PROC
	@p_no int,
	@p_status char(1)
	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
		UPDATE PRICELIST 
		SET PL_STATUS = @p_status
		WHERE PL_NO = @p_no AND PL_STATUS <> '0'
	
END
