/* *************************************************************************
 * NAME : dbo.UP_NB_STATICS_STEP_CHK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:50.107
 *        Modify: 2015-05-15 00:52:25.997
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UP_NB_STATICS_STEP_CHK_PROC  :   2004.7.23 --
CREATE       PROC UP_NB_STATICS_STEP_CHK_PROC
	@n_vcode Char(4),
	@n_delcnt int
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	UPDATE TBL_NB_STATICS 
	SET NBST_DELCNT = @n_delcnt
 	WHERE NBST_SEQNO = (SELECT MAX(NBST_SEQNO) FROM TBL_NB_STATICS WITH (ReadUnCommitted) WHERE NBST_VCODE = @n_vcode) AND NBST_VCODE = @n_vcode
   
	SET NOCOUNT OFF
