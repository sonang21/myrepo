/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_21
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:45:18.397
 *        Modify: 2018-05-03 17:23:36.12
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_SEL_21]
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT PL_NO, PL_GOODSNM_CS 
	FROM PRICELIST 
	WHERE PL_VCODE = @PL_VCODE 
		AND PL_GOODSNM >'' 
		AND PL_STATUS IN ('0','8','9') 
	ORDER BY PL_GOODSNM_CS
END