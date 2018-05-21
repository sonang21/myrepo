/* *************************************************************************
 * NAME : dbo.UDP_NB_NBCATEGORY_SELECT_FLAG3_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.373
 *        Modify: 2015-05-15 00:52:25.987
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_NB_NBCATEGORY_SELECT_FLAG3_PROC    스크립트 날짜: 2004-10-21 오후 3:37:25 ******/
-- UP_NB_NBCATEGORY_SELECT_FLAG3_PROC  :   2004.8.26 --
-- TBL_NB_CATEGORY FLAG=3 카테고리 추출
CREATE      PROC UDP_NB_NBCATEGORY_SELECT_FLAG3_PROC
	@szVcode INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT nbc_no ,nbc_category ,nbc_url 
	FROM TBL_NB_CATEGORY WITH(READUNCOMMITTED) 
	WHERE nbc_vcode = @szVcode and nbc_flag = '3'
	ORDER BY nbc_category
	DESC, nbc_no
END


