/* *************************************************************************
 * NAME : dbo.UDP_PRICELIST_INIT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-01-03 09:14:01.25
 *        Modify: 2018-05-16 11:01:11.8
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_PRICELIST_INIT]
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	IF OBJECT_ID('EP_INIT_TARGET') IS NOT NULL DROP TABLE EP_INIT_TARGET
	
	SELECT PL_NO
	INTO EP_INIT_TARGET
	FROM PRICELIST
	WHERE PL_MODELNO > 0 AND PL_PRICE > 0 AND PL_GOODSNM <> '' AND PL_STATUS IN ('0', '1', '2')
	  AND NOT (PL_SRVFLAG IN ('0', 'L', 'R', 'S', 'B') AND OPTION_FLAG2 = '0')
	  --AND PL_VCODE NOT IN (75,7871)
	OPTION (MAXDOP 1)
	
	--DROP TABLE #EP_INIT_TARGET_LOG
	SELECT JP_PLISTNO
	INTO #EP_INIT_TARGET_LOG
	FROM OPENQUERY(OLTPLOG_196, '
			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SELECT JP_PLISTNO
			FROM OLTPLOG.DBO.JOB_PRICELIST
			WHERE JP_DATE >= DATEADD(YEAR, -1, CAST(CONVERT(VARCHAR(10), GETDATE(), 120) AS DATETIME))
			  AND JP_PLISTNO IN (SELECT PL_NO FROM OPENQUERY(ELOC188, ''SELECT PL_NO FROM ELOC2001.DBO.EP_INIT_TARGET''))')
	OPTION (MAXDOP 1)
	
	-- EP 초기화
	CREATE TABLE #UPDATE_TARGET(PL_NO BIGINT, PL_MODELNO INT)
	UPDATE PRICELIST
	SET PL_MODELNO = 0, OPTION_FLAG2 = '0', PL_AIRCONFEETYPE = '0', PL_SRVFLAG = '0'
	OUTPUT DELETED.PL_NO, INSERTED.PL_MODELNO INTO #UPDATE_TARGET
	WHERE PL_MODELNO > 0 AND PL_PRICE > 0 AND PL_GOODSNM <> '' AND PL_STATUS IN ('0', '1', '2')
	  AND NOT (PL_SRVFLAG IN ('0', 'L', 'R', 'S', 'B') AND OPTION_FLAG2 = '0')
	  --AND PL_VCODE NOT IN (75,7871)
	  AND PL_NO IN (SELECT PL_NO FROM EP_INIT_TARGET WHERE PL_NO NOT IN (SELECT DISTINCT JP_PLISTNO FROM #EP_INIT_TARGET_LOG))
	OPTION (MAXDOP 1)
	-- 분산큐(PRICELIST)
	INSERT INTO TB_PL_CHG_HST(PL_NO, MODEL_NO, PGM_ID, DAT_CHG_DCD, FRW_YN, ORGN_DTM)
	SELECT PL_NO, PL_MODELNO, 'db_proc', 'U', 'N', GETDATE()
	FROM #UPDATE_TARGET
	
	INSERT INTO LOGDB.DBO.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_DATE, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_NOTE)
	SELECT PL_NO, PL_MODELNO, PL_VCODE, 'Lab_Reset', '0', GETDATE(), PL_GOODSNM, PL_PRICE, PL_CATEGORY, PL_INSTANCE_PRICE, PL_NOTE
	FROM PRICELIST WITH (READUNCOMMITTED)
	WHERE PL_NO IN (SELECT PL_NO FROM #UPDATE_TARGET)
	OPTION (MAXDOP 1)
END
