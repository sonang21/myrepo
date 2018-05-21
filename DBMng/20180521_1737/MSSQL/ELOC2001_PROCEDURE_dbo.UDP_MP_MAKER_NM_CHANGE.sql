/* *************************************************************************
 * NAME : dbo.UDP_MP_MAKER_NM_CHANGE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:23:22.54
 *        Modify: 2018-05-03 17:23:34.973
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_MAKER_NM_CHANGE]
	@MAKER_ID INT,
	@MAKER_NM VARCHAR(200),
	@MM_ID VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	UPDATE TBL_ENURI_MAKER
	SET MAKER_NM		= @MAKER_NM,
	    UPD_DATE		= GETDATE(),
		UPD_OPRT		= @MM_ID
	WHERE MAKER_ID		= @MAKER_ID

	UPDATE GOODS
	SET G_FLAG = '1',
	    G_FACTORY		= (SELECT MAKER_NM FROM TBL_ENURI_MAKER WHERE MAKER_ID = @MAKER_ID)
	WHERE MAKER_ID		= @MAKER_ID

	INSERT INTO LOGDB.DBO.JOB_GOODS(JG_MODELNO, JG_ID, JG_FLAG, JG_DATE, JG_CATEGORY)
	SELECT G_MODELNO, @MM_ID, '3', GETDATE(), G_CATEGORY
	FROM GOODS
	WHERE MAKER_ID		= @MAKER_ID
END
