/* *************************************************************************
 * NAME : dbo.UDP_NB_SERVER_TIME_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.56
 *        Modify: 2004-11-02 03:36:36.56
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_NB_SERVER_TIME_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:38:29 ******/
-- UP_NB_SERVER_TIME_PROC  :   2004.7.23 --
-- �˻� ���� �ð� üũ
CREATE      PROC UDP_NB_SERVER_TIME_PROC
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT GETDATE()
	
END

