/* *************************************************************************
 * NAME : dbo.UDP_DBA_TABLE_CMT_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-10-22 12:59:28.81
 *        Modify: 2012-09-28 14:32:32.59
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_DBA_TABLE_CMT_SEL
	@TABLE_NAME		NVARCHAR(128) = '%'
AS
	SET NOCOUNT ON
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.03
	-- 설  명 : 테이블 설명
	-- 실  행 : UDP_DBA_TABLE_CMT_SEL
	-- ----------------------------------------------------------------------------------
	SELECT
		  TBLS.NAME,							-- 테이블명
		  CAST(P.[VALUE] AS VARCHAR(300)) AS CMT,	-- 설명
		  CREATE_DATE							-- 생성일
	FROM	SYS.TABLES TBLS
			INNER JOIN SYS.SCHEMAS U
				ON U.SCHEMA_ID = TBLS.SCHEMA_ID
			LEFT OUTER JOIN SYS.EXTENDED_PROPERTIES P
				ON P.MAJOR_ID = TBLS.OBJECT_ID
					AND P.CLASS = 1 AND MINOR_ID=0
					AND P.NAME = 'MS_Description'
	WHERE	TBLS.NAME LIKE @TABLE_NAME
	ORDER BY TBLS.NAME

