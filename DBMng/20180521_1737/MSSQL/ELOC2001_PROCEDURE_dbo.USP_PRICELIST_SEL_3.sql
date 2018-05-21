/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:57:10.553
 *        Modify: 2018-05-03 17:23:35.76
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC USP_PRICELIST_SEL_3
	@PL_NO bigINT,
	@PL_VCODE INT,
	@PL_MODELNO INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT TOP 1 PL_NO 
	FROM PRICELIST 
	WHERE PL_NO<>@PL_NO
		AND PL_VCODE = @PL_VCODE 
		AND PL_MODELNO = @PL_MODELNO 
		AND PL_STATUS <= '2' 
	ORDER BY PL_PRICE ASC 
END

