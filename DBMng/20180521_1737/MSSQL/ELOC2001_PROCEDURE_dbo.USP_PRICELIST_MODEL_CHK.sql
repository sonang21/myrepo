/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_MODEL_CHK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-05-15 17:39:10.393
 *        Modify: 2018-05-03 17:23:34.977
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE PROC [dbo].[USP_PRICELIST_MODEL_CHK]	
	@PL_VCODE INT,
	@PL_GOODSNM NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT TOP 1 PL_MODELNO, PL_PRICE, PL_CATEGORY, PL_SRVFLAG, PL_AIRCONFEETYPE
	FROM PRICELIST 
	WHERE pl_vcode = @PL_VCODE and pl_goodsnm = @PL_GOODSNM and pl_goodsnm_cs = checksum(@PL_GOODSNM) and pl_modelno > 0 
	ORDER BY pl_price

END



