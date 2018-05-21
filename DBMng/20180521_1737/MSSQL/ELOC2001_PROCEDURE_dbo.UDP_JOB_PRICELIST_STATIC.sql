/* *************************************************************************
 * NAME : dbo.UDP_JOB_PRICELIST_STATIC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-06-29 13:48:13.56
 *        Modify: 2015-05-15 03:31:33.8
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE    PROC UDP_JOB_PRICELIST_STATIC
	@CATEGORY	VARCHAR(10),
	@SDATE		DATETIME,
	@EDATE		DATETIME,
	@FLAG		VARCHAR(1),
	
	@IRETURN	INT	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT @IRETURN = COUNT(*)
	FROM (
		SELECT JP_PLISTNO
		FROM  LOGDB_193.LOGDB.DBO.JOB_PRICELIST
		INNER JOIN ELOC2001..GOODS B WITH (READUNCOMMITTED)
		ON JP_MODELNO=G_MODELNO
			AND B.G_CATEGORY LIKE @CATEGORY + '%'
		WHERE JP_DATE>@SDATE AND JP_DATE< @EDATE 
			AND JP_FLAG=@FLAG
		GROUP BY JP_PLISTNO
	) C
END



