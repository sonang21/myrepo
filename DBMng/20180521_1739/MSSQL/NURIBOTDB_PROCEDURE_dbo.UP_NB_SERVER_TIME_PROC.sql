/* *************************************************************************
 * NAME : dbo.UP_NB_SERVER_TIME_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-07-31 11:23:46.653
 *        Modify: 2004-07-31 11:23:46.653
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UP_NB_SERVER_TIME_PROC  :   2004.7.23 --
-- 검색 시작 시간 체크
CREATE     PROC UP_NB_SERVER_TIME_PROC
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT GETDATE()
	SET NOCOUNT OFF
