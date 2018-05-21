/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_INSERT_LOGDB_WEBB_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-01-19 10:00:10.293
 *        Modify: 2018-05-03 17:23:34.903
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE              PROC [dbo].[UDP_ELOC_PRICELIST_INSERT_LOGDB_WEBB_del]

	@VCODE			INT,
	@GOODSCODE		VARCHAR(50),
	@CHKLOG		VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	INSERT INTO LOGDB..JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag)
		SELECT pl_no, pl_modelno , pl_vcode, @CHKLOG, '0'
		FROM PRICELIST WITH(READUNCOMMITTED)

		WHERE pl_vcode = @VCODE and pl_goodscode = @GOODSCODE


END
