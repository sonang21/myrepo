/* *************************************************************************
 * NAME : dbo.UDP_NB_STATICS_TOP30_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:37.03
 *        Modify: 2015-05-15 00:52:25.993
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_STATICS_TOP30_PROC    스크립트 날짜: 2004-10-21 오후 3:40:18 ******/
-- UP_NB_STATICS_TOP30_PROC  :   2004.7.25 --
-- 통계 자료 불러오기
CREATE        PROC UDP_NB_STATICS_TOP30_PROC
	@n_vcode INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT TOP 30 NBST_VCODE, NBST_SEQNO, NBST_ALLCNT, NBST_MODCNT, NBST_ADDCNT, NBST_DELCNT, NBST_DATE
	FROM TBL_NB_STATICS WITH (ReadUncommitted) 
	WHERE NBST_VCODE = @n_vcode
	ORDER BY NBST_SEQNO DESC
END

