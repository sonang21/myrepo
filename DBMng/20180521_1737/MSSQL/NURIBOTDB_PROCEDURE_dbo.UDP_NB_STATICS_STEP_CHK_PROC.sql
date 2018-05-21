/* *************************************************************************
 * NAME : dbo.UDP_NB_STATICS_STEP_CHK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.92
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_STATICS_STEP_CHK_PROC    스크립트 날짜: 2004-10-21 오후 3:39:56 ******/
-- UP_NB_STATICS_STEP_CHK_PROC  :   2004.7.23 --
CREATE        PROC UDP_NB_STATICS_STEP_CHK_PROC
	@n_vcode INT,
	@n_delcnt int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	UPDATE TBL_NB_STATICS 
	SET NBST_DELCNT = @n_delcnt
 	WHERE NBST_SEQNO = (SELECT MAX(NBST_SEQNO) FROM TBL_NB_STATICS WITH (ReadUnCommitted) WHERE NBST_VCODE = @n_vcode) AND NBST_VCODE = @n_vcode
   
END

