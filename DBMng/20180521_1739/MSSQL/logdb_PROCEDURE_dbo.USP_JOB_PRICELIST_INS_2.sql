/* *************************************************************************
 * NAME : dbo.USP_JOB_PRICELIST_INS_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-11 15:31:13.567
 *        Modify: 2015-10-20 17:39:06.31
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[USP_JOB_PRICELIST_INS_2]
	@JP_PLISTNO BIGINT,
	@JP_ID VARCHAR(15),
	@JP_FLAG CHAR(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	INSERT INTO JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_DATE, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_NOTE)
	SELECT PL_NO, PL_MODELNO, PL_VCODE, @JP_ID, @JP_FLAG, GETDATE(), PL_GOODSNM, PL_PRICE, PL_CATEGORY, PL_INSTANCE_PRICE, PL_NOTE
	FROM ELOC2001.DBO.PRICELIST
	WHERE PL_NO = @JP_PLISTNO
END