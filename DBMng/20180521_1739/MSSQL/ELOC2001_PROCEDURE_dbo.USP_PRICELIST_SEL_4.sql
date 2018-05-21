/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_SEL_4
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 16:00:24.21
 *        Modify: 2018-05-03 17:23:35.77
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC USP_PRICELIST_SEL_4
	@PL_VCODE INT,
	@PL_DATE SMALLDATETIME	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT PL_NO, PL_GOODSCODE 
	FROM PRICELIST 
	WHERE PL_VCODE = @PL_VCODE 
		AND PL_GOODSNM > '' 
		AND PL_STATUS IN ('0','8','9') 
		AND PL_DATE < @PL_DATE
END

