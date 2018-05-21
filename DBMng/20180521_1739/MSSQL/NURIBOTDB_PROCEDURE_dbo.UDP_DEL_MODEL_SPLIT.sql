/* *************************************************************************
 * NAME : dbo.UDP_DEL_MODEL_SPLIT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.03
 *        Modify: 2015-05-15 00:52:25.97
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_DelModelSplit    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:34:43 ******/
CREATE    PROC UDP_DEL_MODEL_SPLIT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
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
END

