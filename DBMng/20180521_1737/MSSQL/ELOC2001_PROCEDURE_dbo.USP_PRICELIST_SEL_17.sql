/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_17
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:11:44.467
 *        Modify: 2018-05-03 17:23:36.04
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC USP_PRICELIST_SEL_17
	@PL_VCODE INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT PL_NO 
	FROM PRICELIST 
	WHERE PL_STATUS IN ('1','2','3')
		AND PL_MODELNO > 0 
		AND PL_SRVFLAG = '0' 
		AND PL_VCODE =@PL_VCODE
END
