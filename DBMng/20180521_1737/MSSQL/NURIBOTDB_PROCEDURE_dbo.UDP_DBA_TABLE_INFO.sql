/* *************************************************************************
 * NAME : dbo.UDP_DBA_TABLE_INFO
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-10-22 13:12:13.643
 *        Modify: 2015-05-15 00:52:26.01
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_DBA_TABLE_INFO]
	@TBL_NAME VARCHAR(100)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.03.03
	-- 설  명 : 테이블 상세내역
	-- 실  행 : UDP_MNT_DESC_COLUMNS 'PRICELIST'
	-- ----------------------------------------------------------------------------------
	-- 테이블 코멘트
	EXEC UDP_DBA_TABLE_CMT_SEL @TBL_NAME

	-- 간략정보
	EXEC SP_SPACEUSED @TBL_NAME

	-- 간략 SELECT
	EXEC ('SELECT TOP 10 * FROM '+@TBL_NAME)

	-- 컬럼 코멘트
	EXEC UDP_DBA_COLUMN_CMT_SEL @TBL_NAME

	-- 인덱스	
	CREATE TABLE #INDEX(INDEX_NAME SYSNAME NOT NULL, INDEX_DESCRIPTION VARCHAR(210) NOT NULL, INDEX_KEYS NVARCHAR(2078) NOT NULL)
	INSERT INTO #INDEX
	EXEC SYS.SP_HELPINDEX @TBL_NAME
	SELECT * FROM #INDEX

	-- 제약조건
	CREATE TABLE #CONSTRAINT
	(CONSTRAINT_TYPE	NVARCHAR(146)
	,CONSTRAINT_NAME	SYSNAME
	,DELETE_ACTION	NVARCHAR(20)
	,UPDATE_ACTION	NVARCHAR(20)
	,STATUS_ENABLED	NVARCHAR(20)
	,STATUS_FOR_REPLICATION	NVARCHAR(20)
	,CONSTRAINT_KEYS NVARCHAR(2126)
	)
	INSERT INTO #CONSTRAINT
	EXEC SYS.SP_HELPCONSTRAINT @TBL_NAME,'NOMSG'
	SELECT * FROM #CONSTRAINT


