/* *************************************************************************
 * NAME : dbo.UDP_BC_BOARD_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.687
 *        Modify: 2018-05-03 17:23:34.973
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-10-23 ���� 10:55:46 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-09-11 ���� 8:35:38 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-29 ���� 5:33:17 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-08 ���� 12:47:56 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-07 ���� 6:42:37 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-07 ���� 6:20:22 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-07 ���� 11:48:30 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-07 ���� 11:30:36 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-07 ���� 10:22:32 ******/

/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_LIST    ��ũ��Ʈ ��¥: 2004-07-06 ���� 2:39:17 ******/

 --exec UP_BC_BOARD_LIST 1,'1',10,10,1,  '''''','','','',  ''
--
--select * from TBL_BC_BOARD where bb_group=7 and bb_ref=46
--order by BB_REF DESC, BB_DEPTH ASC, BB_STEP ASC


CREATE           PROC UDP_BC_BOARD_LIST
	@GROUP	INT,
	@STATUS	VARCHAR(10),
	@LISTSIZE	INT,
	@PAGESIZE	INT,
	@PAGE		INT,

	@TARGETFIELD	VARCHAR(1024),
	@KEYFIELD	VARCHAR(255),
	--@KEYFIELD_OLD	VARCHAR(255),
	@ORDERBY	VARCHAR(20),


	@TOTALLIST	INT	OUTPUT,
	@TOTALPAGE	INT	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @SEEK INT
	SET @SEEK = @LISTSIZE * @PAGE

	DECLARE @SQL NVARCHAR(3000)
	DECLARE @CNTSQL NVARCHAR(1000)
	DECLARE @DETAILSQL NVARCHAR(1000)
	DECLARE @ORDERSQL NVARCHAR(100)
	
	SET @CNTSQL = N' SELECT COUNT(BB_IDX) '

	SET @DETAILSQL =  N' SELECT TOP  ' + CONVERT( VARCHAR(15), @SEEK)
	SET @DETAILSQL = @DETAILSQL +  N' BB_IDX,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_GROUP,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_NO,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_REF,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_STEP,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_DEPTH,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_USERID,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_USERNAME,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_RECEIVER,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_REFERER,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_TITLE,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_CONTENT,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_REGDATE,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_HITS,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_HTML,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_STATUS,'
	SET @DETAILSQL = @DETAILSQL +  N' BB_DELFLAG'

	SET @SQL = N' FROM TBL_BC_BOARD (NOLOCK) '
	SET @SQL = @SQL +  N' WHERE BB_GROUP  = '+ cast(@GROUP as varchar(12)) +' '
	SET @SQL = @SQL +  N' 	AND BB_DELFLAG=''0'' '

	IF @TARGETFIELD<>''
	BEGIN	
		SET @SQL = @SQL +  N' AND ( BB_USERNAME IN ( '            + REPLACE(@TARGETFIELD,' ','')+ ' ) '
		SET @SQL = @SQL +  N' 		OR BB_RECEIVER  IN (' + REPLACE(@TARGETFIELD,' ','') +' ) '
		
		DECLARE @T_TARGET NVARCHAR(15)
		DECLARE @T_TARGETFIELD NVARCHAR(1024)
	
		SET @T_TARGETFIELD = @TARGETFIELD
		
		WHILE CHARINDEX(',', @T_TARGETFIELD)<>0
		BEGIN
			SET @T_TARGET = SUBSTRING(@T_TARGETFIELD,1,CHARINDEX(',', @T_TARGETFIELD)-1)
			SET @T_TARGETFIELD = SUBSTRING( @T_TARGETFIELD, CHARINDEX(',', @T_TARGETFIELD)+1,LEN(@T_TARGETFIELD) )
			SET @SQL = @SQL +  N' OR BB_REFERER LIKE ''%' +  REPLACE(@T_TARGET,'''','') + '%'' '
		END
		SET @SQL = @SQL +  N' OR BB_REFERER LIKE ''%' +  REPLACE(@T_TARGETFIELD,'''','') + '%'') '
	END


	IF @STATUS<>''
	BEGIN	
		SET @SQL = @SQL +  N' AND BB_STATUS = ''' + @STATUS + ''' '
	END
	/*
	IF @KEYFIELD_OLD<>''
	BEGIN
		SET @SQL = @SQL +  N' AND (      BB_TITLE	LIKE ''%' + @KEYFIELD_OLD + '%'' '
		SET @SQL = @SQL +  N' 	      OR BB_USERNAME LIKE ''%' + @KEYFIELD_OLD + '%'' '
		SET @SQL = @SQL +  N'           OR BB_RECEIVER LIKE ''%' + @KEYFIELD_OLD + '%'' '
		SET @SQL = @SQL +  N'           OR BB_REFERER LIKE ''%' + @KEYFIELD_OLD + '%'') '
	END
	*/

	IF @KEYFIELD<>''
	BEGIN
		SET @SQL = @SQL +  N' AND (    BB_TITLE	LIKE ''%' + @KEYFIELD + '%'' '
		SET @SQL = @SQL +  N'        OR BB_USERNAME LIKE ''%' + @KEYFIELD + '%'' '
		SET @SQL = @SQL +  N'    	   OR BB_RECEIVER LIKE ''%' + @KEYFIELD + '%'' '
		SET @SQL = @SQL +  N' 	   OR BB_REFERER LIKE ''%' + @KEYFIELD + '%'') '
	END
	
	IF @ORDERBY=''
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_REF DESC, BB_DEPTH ASC, BB_STEP ASC '
	END
	
	ELSE IF @ORDERBY='TITLE'
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_TITLE ASC '
	END
	
	ELSE IF @ORDERBY='BB_USERNAME'
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_USERNAME ASC '
	END

	ELSE IF @ORDERBY='BB_REGDATE'
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_REGDATE DESC '
	END

	ELSE IF @ORDERBY='BB_RECEIVER'
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_RECEIVER ASC '
	END

	ELSE
	BEGIN
		SET @ORDERSQL = N' ORDER BY BB_REF DESC, BB_STEP ASC '
	END
	
	
	DECLARE @LASTSQL NVARCHAR(4000)

	--1. ��ü ����Ȯ��
	SET @LASTSQL = @CNTSQL + @SQL
	EXEC SP_EXECUTESQL @LASTSQL

	--2. ����Ʈ Ȯ��
	SET @LASTSQL = @DETAILSQL + @SQL + @ORDERSQL
	EXEC SP_EXECUTESQL @LASTSQL

	--PRINT @LASTSQL
	--EXEC SP_EXECUTESQL @SQL
		
END








