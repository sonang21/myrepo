/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_18
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:12:46.967
 *        Modify: 2018-05-03 17:23:36.043
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_SEL_18]
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT PL_NO 
	FROM PRICELIST --WITH (INDEX(NCL_PRICELIST_2))
	WHERE PL_STATUS IN ('1','2','3') 
		AND PL_VCODE = @PL_VCODE 
END

