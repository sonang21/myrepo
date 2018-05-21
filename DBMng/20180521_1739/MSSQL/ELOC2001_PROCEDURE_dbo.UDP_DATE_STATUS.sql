/* *************************************************************************
 * NAME : dbo.UDP_DATE_STATUS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.23
 *        Modify: 2018-05-03 17:23:35.113
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE  PROCEDURE UDP_DATE_STATUS 
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	UPDATE PRICELIST SET pl_status = '1' WHERE pl_vcode in
		(select tmp_vcode from TMP_JOB where DATEDIFF(dd,getdate(),tmp_date) = 0)
		and pl_status = '0' and pl_modelno > 0 and pl_date < '2004-3-19'
END
