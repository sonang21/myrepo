/* *************************************************************************
 * NAME : dbo.UP_DelModelSplit
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-08-11 16:25:12.483
 *        Modify: 2015-05-15 00:52:26.01
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE   PROC UP_DelModelSplit
AS
	SET NOCOUNT ON

	DELETE FROM TBL_NB_MODEL_IN
		WHERE
			NBMI_MODDATE < DateAdd(mm,-2,getdate())
			AND NBMI_VCODE  IN (SELECT NBS_VCODE FROM TBL_NB_SHOP WITH (ReadUncommitted) WHERE NBS_SERVICE = '0')

	DELETE FROM TBL_NB_MODEL_OUT
	WHERE
		NBMO_NBMI NOT IN
		(
			SELECT NBMI_NO FROM TBL_NB_MODEL_IN  WITH (ReadUncommitted)
		)



