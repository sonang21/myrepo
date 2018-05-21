/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DEL_PROC_WEBB
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-09-12 15:54:01.81
 *        Modify: 2018-05-03 17:23:35.177
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE       PROC [dbo].[UDP_NB_PRICELIST_DEL_PROC_WEBB]
	@p_vcode INT,
	@p_goodscode varChar(50)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST
	SET PL_STATUS = '3', PL_DATE = getdate()
	WHERE 	PL_VCODE = @p_vcode AND PL_GOODSCODE = @p_goodscode
END
