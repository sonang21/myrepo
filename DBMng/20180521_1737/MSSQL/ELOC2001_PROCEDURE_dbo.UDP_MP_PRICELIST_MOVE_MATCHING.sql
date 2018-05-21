/* *************************************************************************
 * NAME : dbo.UDP_MP_PRICELIST_MOVE_MATCHING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:22:08.063
 *        Modify: 2018-05-16 11:00:44.557
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [DBO].[UDP_MP_PRICELIST_MOVE_MATCHING]
	@PREMODELNO INT,
	@NOWMODELNO INT,
	@MM_ID VARCHAR(15)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CATEGORY VARCHAR(12)
	SELECT @CATEGORY = G_CATEGORY
	FROM GOODS
	WHERE G_MODELNO = @NOWMODELNO
	
	CREATE TABLE #UPDATE_TARGET(PL_NO BIGINT, PL_MODELNO INT)
	UPDATE PRICELIST
	SET PL_MODELNO = -5
      , PL_NOTE = '분할오류'
      , PL_SRVFLAG = (CASE WHEN PL_SRVFLAG = '8' THEN PL_SRVFLAG ELSE '1' END)
	  , PL_STATUS = '5'
	OUTPUT DELETED.PL_NO, INSERTED.PL_MODELNO INTO #UPDATE_TARGET
	WHERE PL_MODELNO = @PREMODELNO AND PL_COPYPLNO IN (SELECT DISTINCT PL_COPYPLNO FROM PRICELIST WITH (READUNCOMMITTED) WHERE PL_MODELNO = @NOWMODELNO AND ISNULL(PL_COPYPLNO, 0) > 0)
	OPTION (MAXDOP 1)
	
	UPDATE PRICELIST
	SET PL_MODELNO = @NOWMODELNO
	  , PL_CATEGORY = @CATEGORY
	OUTPUT DELETED.PL_NO, INSERTED.PL_MODELNO INTO #UPDATE_TARGET
	WHERE PL_MODELNO = @PREMODELNO
	OPTION (MAXDOP 1)
	-- 분산큐(PRICELIST)
	INSERT INTO TB_PL_CHG_HST(PL_NO, MODEL_NO, PGM_ID, DAT_CHG_DCD, FRW_YN, ORGN_DTM)
	SELECT PL_NO, PL_MODELNO, 'db_proc', 'U', 'N', GETDATE()
	FROM #UPDATE_TARGET
	
	INSERT INTO LOGDB.DBO.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_DATE, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_NOTE)
	SELECT PL_NO, PL_MODELNO, PL_VCODE, @MM_ID, '0', GETDATE(), PL_GOODSNM, PL_PRICE, PL_CATEGORY, PL_INSTANCE_PRICE, PL_NOTE
	FROM PRICELIST WITH (READUNCOMMITTED)
	WHERE PL_NO IN (SELECT PL_NO FROM #UPDATE_TARGET)
	OPTION (MAXDOP 1)
END
