/* *************************************************************************
 * NAME : dbo.UDP_AUTH_ALLOC_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.2
 *        Modify: 2018-05-03 17:23:34.873
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_AUTH_ALLOC_LIST    스크립트 날짜: 2004-10-23 오전 10:54:49 ******/
CREATE  PROC UDP_AUTH_ALLOC_LIST
	@AUA_AUPNO	INT --GROUP()
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT AUA_NO,
		AUA_MMID,
		ISNULL(MM_NM,'') MM_NM,
		AUA_MMID + '@enuri.com' MM_EMAIL,
		AUA_AUGNUM --권한(1:ADMIN, 2:...)
	FROM AUTH_ALLOC
	LEFT JOIN MM_ENURI
	ON AUA_MMID = MM_ID
	WHERE AUA_AUPNO=@AUA_AUPNO
	ORDER BY MM_NM ASC

END



