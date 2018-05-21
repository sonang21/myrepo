/* *************************************************************************
 * NAME : dbo.UDP_DEL_PRICELIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.31
 *        Modify: 2015-05-15 03:31:33.723
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE   PROC UDP_DEL_PRICELIST
AS
BEGIN

	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DELETE FROM SEARCHKEY_193.SEARCHKEY.DBO.TBL_PRICELIST_KEYWORD WHERE PK_PLNO IN (
	SELECT PL_NO FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_date < DateAdd(mm,-2,getdate()) and pl_status = '5'
		)

	-- 2개월전 가격자료 삭제
	DELETE FROM PRICELIST WHERE pl_date < DateAdd(mm,-2,getdate()) and pl_status = '5'
END
