/* *************************************************************************
 * NAME : dbo.UDP_DBA_COLUMN_CMT_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-10-22 12:59:28.747
 *        Modify: 2012-09-28 14:32:51.983
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_DBA_COLUMN_CMT_SEL]
	@TBL_NAME VARCHAR(100)
AS
	SET NOCOUNT ON
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.03
	-- 설  명 : 테이블 상세내역
	-- 실  행 : UDP_MNT_DESC_COLUMNS 'PRICELIST'
	-- ----------------------------------------------------------------------------------
	SELECT
		  TB.NAME,
		  C.NAME,
		  CAST(P.[VALUE] AS VARCHAR(1000)) AS CMT,
		  T.NAME AS TYPENAME,
--		  C.MAX_LENGTH AS LENGTH,
		  COLUMNPROPERTY(C.OBJECT_ID, C.NAME, 'PRECISION')  PRECISION,
		  C.IS_NULLABLE,
		  C.IS_IDENTITY
	FROM SYS.COLUMNS C
		 INNER JOIN SYS.OBJECTS TB ON TB.OBJECT_ID = C.OBJECT_ID	
		 INNER JOIN SYS.SCHEMAS U ON U.SCHEMA_ID = TB.SCHEMA_ID
		 INNER JOIN SYS.TYPES T ON C.USER_TYPE_ID = T.USER_TYPE_ID		 
		 LEFT OUTER JOIN SYS.EXTENDED_PROPERTIES P ON P.MAJOR_ID = C.OBJECT_ID
			  AND P.MINOR_ID = C.COLUMN_ID
			  AND P.CLASS = 1
			  AND P.NAME = 'MS_Description'
	WHERE TB.NAME = @TBL_NAME AND U.NAME = 'DBO'
	ORDER BY C.COLUMN_ID


