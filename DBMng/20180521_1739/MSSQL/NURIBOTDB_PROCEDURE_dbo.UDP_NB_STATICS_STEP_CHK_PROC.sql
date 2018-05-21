/* *************************************************************************
 * NAME : dbo.UDP_NB_STATICS_STEP_CHK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.92
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_NB_STATICS_STEP_CHK_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:39:56 ******/
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

