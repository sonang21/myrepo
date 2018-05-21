/* *************************************************************************
 * NAME : dbo.UDP_MNT_STATISTICS_DATE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-07-12 09:15:56.107
 *        Modify: 2018-05-03 17:23:35.87
 *        Backup: 20180521_1739
 ************************************************************************* */

/******************************************************
-- 작성자 : wookki25
-- 작성일 : 2007-07-12(목)
-- 설  명 : 인덱스별 통계 업데이트 날자
*******************************************************/
CREATE PROC [DBO].[UDP_MNT_STATISTICS_DATE]
	@TABLENM	VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	'INDEX NAME' = NAME, 'STATISTICS DATE' = STATS_DATE(OBJECT_ID, I.INDEX_ID)
	FROM	SYS.INDEXES I
	WHERE	OBJECT_ID= OBJECT_ID(@TABLENM)
	ORDER BY 'STATISTICS DATE'
END