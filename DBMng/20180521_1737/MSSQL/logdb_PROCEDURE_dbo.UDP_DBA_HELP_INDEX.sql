/* *************************************************************************
 * NAME : dbo.UDP_DBA_HELP_INDEX
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-28 14:36:29.79
 *        Modify: 2015-05-15 00:53:14.5
 *        Backup: 20180521_1737
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROC UDP_DBA_HELP_INDEX
	@TBNAME SYSNAME
AS
	-- --------------------------------
	-- 작성자 : WOOKKI25 / 2007.12.14
	-- 설  명 : 인덱스 맞춤 정보
	-- 사  용 : UDP_DBA_HELP_INDEX @TABLE_NAME
	-- --------------------------------
	-- 생성일
	SELECT	NAME, CREATE_DATE AS TABLE_CREATE_DATE 
	FROM	SYS.TABLES 
	WHERE	OBJECT_ID = OBJECT_ID(@TBNAME)
	
	-- 용량
	EXEC SP_SPACEUSED @TBNAME
	
	-- 인덱스 정보
	EXEC SP_HELPINDEX @TBNAME
		
	-- 인덱스 (인클루드)
	SELECT	OBJECT_NAME(A.OBJECT_ID),
			C.NAME AS INDEX_NAME, 
			B.NAME AS COLUMN_NAME, 
			A.IS_INCLUDED_COLUMN
	FROM	SYS.INDEX_COLUMNS  A
				INNER JOIN 
			SYS.INDEXES C
				ON A.OBJECT_ID = C.OBJECT_ID
				AND A.INDEX_ID = C.INDEX_ID			
				INNER JOIN
			SYS.COLUMNS B
				ON A.OBJECT_ID = B.OBJECT_ID
				AND A.COLUMN_ID = B.COLUMN_ID
				INNER JOIN
			(
			-- INCLUDE 컬럼을 가지고 있는 테이블
			SELECT DISTINCT OBJECT_ID FROM SYS.INDEX_COLUMNS
			WHERE IS_INCLUDED_COLUMN = 1
			)   TMP
				ON A.OBJECT_ID = TMP.OBJECT_ID
	WHERE A.IS_INCLUDED_COLUMN = 1 AND A.OBJECT_ID=OBJECT_ID(@TBNAME)
	ORDER BY A.INDEX_ID
	
	-- 인덱스 사용량
	EXEC UDP_DBA_INDEX_USAGE @TBNAME 


