/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 15:34:57.413
 *        Modify: 2018-05-03 17:23:35.553
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_PRICELIST_UP_1
	@PL_URL1 VARCHAR(500),
	@PL_URL2 VARCHAR(500),
	@PL_VCODE INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	UPDATE PRICELIST
	SET PL_STATUS='1', PL_URL = REPLACE(PL_URL,@PL_URL1,@PL_URL2)
	WHERE PL_VCODE=@PL_VCODE
		AND PL_STATUS<'3'	
END