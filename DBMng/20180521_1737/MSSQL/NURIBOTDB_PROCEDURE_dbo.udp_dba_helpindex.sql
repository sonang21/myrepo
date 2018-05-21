/* *************************************************************************
 * NAME : dbo.udp_dba_helpindex
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-08-19 09:34:22.857
 *        Modify: 2015-05-15 00:52:26.0
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_DBA_HELP_INDEX
	@TBNAME SYSNAME
AS
	-- --------------------------------
	-- �ۼ��� : WOOKKI25 / 2007.12.14
	-- ��  �� : �ε��� ���� ����
	-- ��  �� : UDP_DBA_HELP_INDEX @TABLE_NAME
	-- --------------------------------
	-- ������
	SELECT	NAME, CREATE_DATE AS TABLE_CREATE_DATE 
	FROM	SYS.TABLES 
	WHERE	OBJECT_ID = OBJECT_ID(@TBNAME)
	
	-- �뷮
	SELECT 'SP_SPACEUSED----------------------------------------------------'
	EXEC SP_SPACEUSED @TBNAME
	
	-- �ε��� ����
	SELECT 'SP_HELPINDEX----------------------------------------------------'
	EXEC SP_HELPINDEX @TBNAME
		
	-- �ε��� (��Ŭ���)
	SELECT 'INCLUDE COLUMN----------------------------------------------------'
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
			-- INCLUDE �÷��� ������ �ִ� ���̺�
			SELECT DISTINCT OBJECT_ID FROM SYS.INDEX_COLUMNS
			WHERE IS_INCLUDED_COLUMN = 1
			)   TMP
				ON A.OBJECT_ID = TMP.OBJECT_ID
	WHERE A.IS_INCLUDED_COLUMN = 1 AND A.OBJECT_ID=OBJECT_ID(@TBNAME)
	ORDER BY A.INDEX_ID
	
	-- �ε��� ��뷮
	SELECT 'UDP_DBA_INDEX_USAGE----------------------------------------------------'
	EXEC UDP_DBA_INDEX_USAGE @TBNAME 


