/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_INSERT_LOGDB_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-01-19 09:59:58.67
 *        Modify: 2018-05-03 17:23:34.877
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE                PROC UDP_ELOC_PRICELIST_INSERT_LOGDB_del

	@VCODE			INT,
	@GOODSNM		VARCHAR(200),
	@CHKLOG		VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	INSERT INTO LOGDB..JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag)
		SELECT pl_no, pl_modelno , pl_vcode, @CHKLOG, '0' 
		FROM PRICELIST WITH(READUNCOMMITTED) 
		WHERE pl_vcode = @VCODE and pl_goodsnm = @GOODSNM
		


END


