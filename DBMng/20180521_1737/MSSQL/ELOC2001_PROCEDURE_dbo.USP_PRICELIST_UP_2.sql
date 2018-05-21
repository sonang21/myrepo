/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:39:11.477
 *        Modify: 2018-05-03 17:23:35.567
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_UP_2
	@PL_VCODE INT,
	@PL_CATEGORY VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_CATEGORY = '00' 
	WHERE PL_VCODE = @PL_VCODE AND PL_CATEGORY = @PL_CATEGORY
END