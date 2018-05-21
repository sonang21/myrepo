/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_25
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-28 09:41:25.96
 *        Modify: 2018-05-03 17:23:34.277
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [dbo].[USP_PRICELIST_SEL_25]
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT PL_GOODSNM, PL_MODELNO
	FROM PRICELIST
	WHERE PL_VCODE=@PL_VCODE
		AND PL_GOODSNM<>''
	GROUP BY PL_GOODSNM, PL_MODELNO
	HAVING COUNT(*)>1
END 