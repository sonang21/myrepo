/* *************************************************************************
 * NAME : dbo.UDP_BC_MEMBERS_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.077
 *        Modify: 2018-05-03 17:23:35.073
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_BC_MEMBERS_LIST    스크립트 날짜: 2004-10-23 오전 10:56:29 ******/

/****** 개체: 저장 프로시저 dbo.UP_BC_MEMBERS_LIST    스크립트 날짜: 2004-07-08 오후 4:07:51 ******/
CREATE   PROC UDP_BC_MEMBERS_LIST

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT 	BM_NO,
		BM_USERID,
		ISNULL(BM_NAME,'') BM_NAME,
		ISNULL(BM_EMAIL,'') BM_EMAIL,
		BM_PART
	FROM TBL_BC_MEMBERS (NOLOCK)
	ORDER BY BM_PART ASC, BM_NAME ASC
END




