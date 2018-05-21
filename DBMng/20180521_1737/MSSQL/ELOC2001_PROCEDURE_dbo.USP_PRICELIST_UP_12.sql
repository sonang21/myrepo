/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_12
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 18:10:25.857
 *        Modify: 2018-05-03 17:23:36.033
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_UP_12]
	@PL_VCODE INT,
	@PL_NO bigINT,
	@PL_GOODSCODE VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST
	SET PL_STATUS = '5',
		PL_DATE = GETDATE()
	WHERE PL_VCODE = @PL_VCODE
		AND PL_NO = @PL_NO
		AND PL_GOODSCODE = @PL_GOODSCODE
		AND PL_GOODSCODE_CS = CHECKSUM(@PL_GOODSCODE)
END

