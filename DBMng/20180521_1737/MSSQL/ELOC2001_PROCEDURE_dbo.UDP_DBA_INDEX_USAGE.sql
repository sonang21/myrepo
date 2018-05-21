/* *************************************************************************
 * NAME : dbo.UDP_DBA_INDEX_USAGE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-08-19 09:31:41.14
 *        Modify: 2018-05-03 17:23:34.673
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_DBA_INDEX_USAGE
	@TABLE_NAME	SYSNAME = NULL
AS
	-- ----------------------------------------
	-- 작성자 : WOOKKI25
	-- 작성일 : W2007.12.04
	-- 설  명 : 인덱스 사용량 모니터링
	-- ----------------------------------------
	SET NOCOUNT ON
	SELECT	DB_NAME(A.DATABASE_ID) AS [DB_NAME]
	,		OBJECT_NAME(A.OBJECT_ID) AS [TABLE_NAME]
	,		A.INDEX_ID
	,		B.NAME
	,		USER_SEEKS
	,		USER_SCANS
	,		USER_LOOKUPS
	,		USER_UPDATES
	FROM	SYS.DM_DB_INDEX_USAGE_STATS A
				INNER JOIN 
			SYS.INDEXES B
				ON A.OBJECT_ID = B.OBJECT_ID AND A.INDEX_ID  = B.INDEX_ID
	WHERE	OBJECTPROPERTY(A.OBJECT_ID,'ISUSERTABLE') = 1
	AND		A.DATABASE_ID = DB_ID()
	AND		A.OBJECT_ID = OBJECT_ID(@TABLE_NAME)
	