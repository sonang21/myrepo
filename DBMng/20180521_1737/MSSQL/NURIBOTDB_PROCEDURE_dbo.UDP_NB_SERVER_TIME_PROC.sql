/* *************************************************************************
 * NAME : dbo.UDP_NB_SERVER_TIME_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.56
 *        Modify: 2004-11-02 03:36:36.56
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_SERVER_TIME_PROC    스크립트 날짜: 2004-10-21 오후 3:38:29 ******/
-- UP_NB_SERVER_TIME_PROC  :   2004.7.23 --
-- 검색 시작 시간 체크
CREATE      PROC UDP_NB_SERVER_TIME_PROC
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT GETDATE()
	
END

