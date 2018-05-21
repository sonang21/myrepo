/* *************************************************************************
 * NAME : dbo.UDP_DBA_INDEX_USAGE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-28 14:37:11.11
 *        Modify: 2012-09-28 14:37:21.493
 *        Backup: 20180521_1739
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROC UDP_DBA_INDEX_USAGE
	@TABLE_NAME	SYSNAME = NULL
AS
	-- ----------------------------------------
	-- �ۼ��� : WOOKKI25
	-- �ۼ��� : W2007.12.04
	-- ��  �� : �ε��� ��뷮 ����͸�
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
	

