/* *************************************************************************
 * NAME : dbo.UP_NB_STATICS_TOP30_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:50.717
 *        Modify: 2015-05-15 00:52:25.997
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UP_NB_STATICS_TOP30_PROC  :   2004.7.25 --
-- 통계 자료 불러오기
CREATE       PROC UP_NB_STATICS_TOP30_PROC
	@n_vcode Char(4)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT TOP 30 NBST_VCODE, NBST_SEQNO, NBST_ALLCNT, NBST_MODCNT, NBST_ADDCNT, NBST_DELCNT, NBST_DATE
	FROM TBL_NB_STATICS WITH (ReadUncommitted) 
	WHERE NBST_VCODE = @n_vcode
	ORDER BY NBST_SEQNO DESC
	SET NOCOUNT OFF
