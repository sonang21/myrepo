/* *************************************************************************
 * NAME : dbo.UDP_EX_SELECT_CATEGORY_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.2
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_EX_SELECT_CATEGORY_PROC    스크립트 날짜: 2004-10-21 오후 3:36:01 ******/
-- UP_EX_SELECT_CATEGORY_PROC   :   2004.8.17 --
CREATE       PROC UDP_EX_SELECT_CATEGORY_PROC 
	@szInsCcode INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT NBSE_NO, NBSE_CATEGORY, NBSE_ATYPE, NBSE_BTYPE
	FROM TBL_NB_SHOP_EX WITH (READUNCOMMITTED) 
	WHERE NBSE_VCODE = @szInsCcode ORDER BY NBSE_NO ASC
	
END

