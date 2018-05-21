/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_14
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:00:33.92
 *        Modify: 2018-05-03 17:23:35.943
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_SEL_14]
	@PL_VCODE INT,
	@PL_MODELNO INT,
	@PL_GOODSNM NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT PL_NO 
	FROM PRICELIST --WITH (INDEX(NCL_PRICELIST_3))
	WHERE PL_VCODE= @PL_VCODE 
		AND PL_MODELNO = @PL_MODELNO
		AND PL_GOODSNM_CS = CHECKSUM(@PL_GOODSNM) 
		AND PL_GOODSNM = @PL_GOODSNM
	ORDER BY PL_DATE DESC
END





