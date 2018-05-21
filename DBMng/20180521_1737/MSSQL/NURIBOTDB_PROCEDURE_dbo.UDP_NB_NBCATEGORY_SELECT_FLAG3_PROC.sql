/* *************************************************************************
 * NAME : dbo.UDP_NB_NBCATEGORY_SELECT_FLAG3_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.373
 *        Modify: 2015-05-15 00:52:25.987
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_NB_NBCATEGORY_SELECT_FLAG3_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:37:25 ******/
-- UP_NB_NBCATEGORY_SELECT_FLAG3_PROC  :   2004.8.26 --
-- TBL_NB_CATEGORY FLAG=3 ī�װ� ����
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


