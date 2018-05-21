/* *************************************************************************
 * NAME : dbo.UP_NB_STATICS_NOW_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:49.547
 *        Modify: 2015-05-15 00:52:25.997
 *        Backup: 20180521_1737
 ************************************************************************* */

-- UP_NB_STATICS_NOW_PROC  :   2004.7.23 --
-- 현재 검색한 카운트 값 불러오기
CREATE     PROC UP_NB_STATICS_NOW_PROC
	@n_vcode Char(4)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT isNull(NBST_ALLCNT, 0) as NBST_ALLCNT 
	FROM TBL_NB_STATICS WITH(READUNCOMMITTED) 
	WHERE NBST_VCODE = @n_vcode AND 
		NBST_SEQNO = (SELECT MAX(NBST_SEQNO)
			             FROM TBL_NB_STATICS WITH(READUNCOMMITTED) 
			             WHERE NBST_VCODE = @n_vcode)
	SET NOCOUNT OFF
