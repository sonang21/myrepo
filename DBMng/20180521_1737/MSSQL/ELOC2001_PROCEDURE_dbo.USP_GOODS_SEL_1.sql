/* *************************************************************************
 * NAME : dbo.USP_GOODS_SEL_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-26 17:51:19.263
 *        Modify: 2018-05-03 17:23:35.84
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC USP_GOODS_SEL_1
	@G_MODELNO INT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT G_CATEGORY 
	FROM GOODS WITH(READUNCOMMITTED) 
	WHERE G_MODELNO =@G_MODELNO
END
