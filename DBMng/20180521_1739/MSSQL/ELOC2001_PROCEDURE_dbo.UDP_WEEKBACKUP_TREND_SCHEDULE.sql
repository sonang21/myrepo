/* *************************************************************************
 * NAME : dbo.UDP_WEEKBACKUP_TREND_SCHEDULE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-05 13:23:51.64
 *        Modify: 2015-05-15 03:31:33.87
 *        Backup: 20180521_1739
 ************************************************************************* */






CREATE       PROC UDP_WEEKBACKUP_TREND_SCHEDULE
	@RETURN INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
/*
이 프로시져는 매주 1회 수행됨을 기준으로 작성됨.
*/
	DECLARE @LASTID VARCHAR(8)
	DECLARE @NEXTID VARCHAR(8)
	SET @LASTID='19000101'
	--가장최근 백업한 주 확인.
	SELECT TOP 1 @LASTID = WG_DATE_ID
	FROM TBL_WEEK_GOODS 
	ORDER BY WG_NO DESC

	SET @NEXTID = DBO.UDF_GET_WEEKPERIOD(GETDATE())
	--PRINT @LASTID
	--PRINT @NEXTID

	IF @LASTID >= @NEXTID 
	BEGIN
		SET @RETURN=1 --이미 작업되었거나, 과거 처리임(중복가능성이 있어서 스킵한다.).
	END
	ELSE
	BEGIN
		INSERT INTO TBL_WEEK_GOODS(wg_modelno, wg_date_id, wg_jobcode, wg_modelnm, wg_factory, wg_minprice, wg_avgprice, wg_maxprice, wg_shop_cnt)
		SELECT g_modelno,@NEXTID,isNull(g_jobcode, '0') as g_jobcode,g_modelnm,g_factory,g_minprice,g_avgprice,g_maxprice,g_mallcnt
		FROM ELOC2001.DBO.GOODS 
		WHERE g_minprice > 0 
		     and (g_openexpectflag <> '1' or g_openexpectflag is NULL)
		--option (maxdop 6)
		SET @RETURN=0

	END

	--PRINT @RETURN
END





