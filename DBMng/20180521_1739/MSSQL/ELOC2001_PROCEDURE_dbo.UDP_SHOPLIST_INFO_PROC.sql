/* *************************************************************************
 * NAME : dbo.UDP_SHOPLIST_INFO_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.937
 *        Modify: 2018-05-03 17:23:35.757
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.UP_SHOPLIST_INFO_PROC    스크립트 날짜: 2004-10-23 오전 11:05:35 ******/

-- UP_SHOPLIST_INFO_PROC  :   2004.7.19 --

CREATE    PROC UDP_SHOPLIST_INFO_PROC
	@s_vcode Char(4)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT SHOP_NAME, SHOP_URL
	FROM SHOPLIST (nolock)
	WHERE SHOP_VCODE = @s_vcode
	
	SET NOCOUNT OFF




