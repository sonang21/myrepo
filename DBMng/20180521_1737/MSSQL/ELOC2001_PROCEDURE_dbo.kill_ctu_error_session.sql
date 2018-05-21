/* *************************************************************************
 * NAME : dbo.kill_ctu_error_session
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-09-19 00:47:01.407
 *        Modify: 2018-05-03 17:23:34.317
 *        Backup: 20180521_1737
 ************************************************************************* */

-- 에러 세션 강제로 종료하는 프로시저
CREATE proc kill_ctu_error_session

as 

	CREATE TABLE #TmpWho(spid INT)

	INSERT INTO #TmpWho
	select r.session_id

		FROM
		SYS.DM_EXEC_REQUESTS R	INNER JOIN
		SYS.DM_EXEC_SESSIONS SS		ON		R.SESSION_ID = SS.SESSION_ID
		CROSS APPLY SYS.DM_EXEC_SQL_TEXT(R.SQL_HANDLE) AS QT
	WHERE
		R.SESSION_ID > 50 
		and ss.host_name like 'ENURIASED01'
		and R.TOTAL_ELAPSED_TIME > 1000
		--and left(QT.TEXT, len('(@P0 nvarchar(4000),@P1 int,@P2 nvarchar(4000),@P3 nvarchar(4000),@P4 nvarchar(4000)) UPDATE pricelist SET pl_coupon =')) = '(@P0 nvarchar(4000),@P1 int,@P2 nvarchar(4000),@P3 nvarchar(4000),@P4 nvarchar(4000)) UPDATE pricelist SET pl_coupon ='
 --and left(QT.TEXT, len('(@P0 varchar(8000),@P1 int,@P2 varchar(8000),@P3 varchar(8000),@P4 varchar(8000)) UPDATE pricelist SET pl_coupon = @P0')) = '(@P0 varchar(8000),@P1 int,@P2 varchar(8000),@P3 varchar(8000),@P4 varchar(8000)) UPDATE pricelist SET pl_coupon = @P0'

                                   

	DECLARE @spid INT
	DECLARE @tString VARCHAR(15)


	DECLARE @getspid CURSOR
	SET @getspid =   CURSOR FOR
	SELECT spid
	FROM #TmpWho


	OPEN @getspid
	FETCH NEXT FROM @getspid INTO @spid
		WHILE @@FETCH_STATUS = 0
			BEGIN
			SET @tString = 'KILL ' + CAST(@spid AS VARCHAR(5))
			EXEC(@tString)
			FETCH NEXT FROM @getspid INTO @spid
		END
	CLOSE @getspid
	DEALLOCATE @getspid
	DROP TABLE #TmpWho