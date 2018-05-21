/* *************************************************************************
 * NAME : dbo.UDP_NB_STATICS_NOW_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.827
 *        Modify: 2015-05-15 00:52:25.99
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_NB_STATICS_NOW_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:39:36 ******/
-- UP_NB_STATICS_NOW_PROC  :   2004.7.23 --
-- ���� �˻��� ī��Ʈ �� �ҷ�����
CREATE      PROC UDP_NB_STATICS_NOW_PROC
	@n_vcode INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT isNull(NBST_ALLCNT, 0) as NBST_ALLCNT 
	FROM TBL_NB_STATICS WITH(READUNCOMMITTED) 
	WHERE NBST_VCODE = @n_vcode AND 
		NBST_SEQNO = (SELECT MAX(NBST_SEQNO)
			             FROM TBL_NB_STATICS WITH(READUNCOMMITTED) 
			             WHERE NBST_VCODE = @n_vcode)
END

