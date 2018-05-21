/* *************************************************************************
 * NAME : dbo.UDP_DBA_TABLE_CMT_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-10-22 13:11:58.407
 *        Modify: 2018-05-03 17:23:34.827
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_DBA_TABLE_CMT_SEL
	@TABLE_NAME		NVARCHAR(128) = '%'
AS
	SET NOCOUNT ON
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.03
	-- ��  �� : ���̺� ����
	-- ��  �� : UDP_DBA_TABLE_CMT_SEL
	-- ----------------------------------------------------------------------------------
	SELECT
		  TBLS.NAME,							-- ���̺��
		  CAST(P.[VALUE] AS VARCHAR(300)) AS CMT,	-- ����
		  CREATE_DATE							-- ������
	FROM	SYS.TABLES TBLS
			INNER JOIN SYS.SCHEMAS U
				ON U.SCHEMA_ID = TBLS.SCHEMA_ID
			LEFT OUTER JOIN SYS.EXTENDED_PROPERTIES P
				ON P.MAJOR_ID = TBLS.OBJECT_ID
					AND P.CLASS = 1 AND MINOR_ID=0
					AND P.NAME = 'MS_Description'
	WHERE	TBLS.NAME LIKE @TABLE_NAME
	ORDER BY TBLS.NAME
