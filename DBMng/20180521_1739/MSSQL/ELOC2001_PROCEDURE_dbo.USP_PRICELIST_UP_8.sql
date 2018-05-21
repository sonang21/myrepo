/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_8
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 16:03:33.11
 *        Modify: 2018-05-03 17:23:35.773
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC USP_PRICELIST_UP_8
	@PL_NO bigINT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_STATUS = '3', 
		PL_DATE = GETDATE() 
	WHERE PL_NO = @PL_NO
END

