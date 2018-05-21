/* *************************************************************************
 * NAME : dbo.UP_NB_MODELIN_UPDATE_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:47.827
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UP_NB_MODELIN_UPDATE_PROC  :   2004.7.23 --
CREATE   PROC UP_NB_MODELIN_UPDATE_PROC
	@szInsCcode Char(4),
	@szInsMcode NVARChar(400)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		UPDATE TBL_NB_MODEL_IN 
		SET nbmi_moddate = getdate() 
		WHERE nbmi_vcode = @szInsCcode  and nbmi_goodsnm = @szInsMcode
	SET NOCOUNT OFF
