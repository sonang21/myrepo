/* *************************************************************************
 * NAME : dbo.UDP_NB_ATYPE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-10-10 14:34:44.343
 *        Modify: 2015-05-15 00:52:26.02
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_NB_ATYPE
	@SHOP_CODE INT,
	@ATYPE VARCHAR(2) OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET @ATYPE=''
	SELECT @ATYPE=NBS_ATYPE
	FROM TBL_NB_SHOP
	WHERE NBS_VCODE = @SHOP_CODE
END
