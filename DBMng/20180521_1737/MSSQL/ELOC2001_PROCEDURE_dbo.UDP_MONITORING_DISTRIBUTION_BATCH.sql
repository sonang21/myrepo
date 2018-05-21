/* *************************************************************************
 * NAME : dbo.UDP_MONITORING_DISTRIBUTION_BATCH
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-01-20 14:43:13.91
 *        Modify: 2018-05-03 17:23:35.943
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [dbo].[UDP_MONITORING_DISTRIBUTION_BATCH]
	@ID VARCHAR(12) = ''
,	@INT INT = 0
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	IF @ID <> '' AND @INT > 0
	BEGIN
		-- 모집단 분배
		UPDATE TBL_MONITORING_TARGET
		SET ASSIGN_MM_ID = @ID
		WHERE PL_NO IN (
			SELECT PL_NO
			FROM (
				SELECT PL_NO, RANK() OVER(ORDER BY CHG_TYPE, PL_NO) NRANK
				FROM TBL_MONITORING_TARGET
				WHERE ASSIGN_MM_ID IS NULL AND P_STATUS = 'I'
			) A
			WHERE (NRANK - 1) % @INT = 0
		)
		
		-- 최저가 경고창 분배
		UPDATE PRICELIST_MATCHING_ALARM_SRCH
		SET ASSIGN_MM_ID = @ID
		WHERE PL_NO IN (
			SELECT PL_NO
			FROM (
				SELECT PL_NO, RANK() OVER(ORDER BY PL_NO) NRANK
				FROM PRICELIST_MATCHING_ALARM_SRCH
				WHERE ALARM_FLAG = '2' AND ASSIGN_MM_ID IS NULL AND P_STATUS = 'I'
			) A
			WHERE (NRANK - 1) % @INT = 0
		)
	END
