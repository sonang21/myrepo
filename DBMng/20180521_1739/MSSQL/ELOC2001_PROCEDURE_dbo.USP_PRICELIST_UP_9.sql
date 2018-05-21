/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_9
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 17:45:20.01
 *        Modify: 2018-05-03 17:23:35.817
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC USP_PRICELIST_UP_9
	@PL_STATUS CHAR(1),
	@PL_NO bigINT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = @PL_STATUS 
	WHERE PL_NO = @PL_NO 
END


