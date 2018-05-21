/* *************************************************************************
 * NAME : dbo.UDP_NB_SERVER_TIME_PROC_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-06-29 10:05:45.187
 *        Modify: 2015-05-15 00:52:25.997
 *        Backup: 20180521_1737
 ************************************************************************* */


/****** ��ü: ���� ���ν��� dbo.UP_NB_SERVER_TIME_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:38:29 ******/
-- UP_NB_SERVER_TIME_PROC  :   2004.7.23 --
-- �˻� ���� �ð� üũ
CREATE       PROC UDP_NB_SERVER_TIME_PROC_1
	@vcode INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT NBS_START_DATE
		FROM TBL_NB_SHOP
		WHERE NBS_VCODE = @vcode
	
END


