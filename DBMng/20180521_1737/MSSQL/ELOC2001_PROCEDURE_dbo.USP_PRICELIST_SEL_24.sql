/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_24
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-28 09:41:01.697
 *        Modify: 2018-05-03 17:23:34.27
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [dbo].[USP_PRICELIST_SEL_24]
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT PL_GOODSCODE, PL_MODELNO
	FROM PRICELIST
	WHERE PL_VCODE=@PL_VCODE
		AND PL_GOODSNM<>''
	GROUP BY PL_GOODSCODE, PL_MODELNO
	HAVING COUNT(*)>1

END 
