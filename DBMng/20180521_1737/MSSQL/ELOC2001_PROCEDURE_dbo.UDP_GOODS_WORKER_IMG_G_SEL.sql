/* *************************************************************************
 * NAME : dbo.UDP_GOODS_WORKER_IMG_G_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-07-29 14:45:26.923
 *        Modify: 2018-05-03 17:23:34.083
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_GOODS_WORKER_IMG_G_SEL
	@PAGE		INT
,	@PAGE_SIZE	INT
,	@WHERE_QRY	VARCHAR(MAX)
,	@sdate		smalldatetime
 AS 
		SET NOCOUNT ON 
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		-- ----------------------------------------------
		-- 작성자 : WOOKKI25 / 2010-03-02
		-- 설  명 : 작업자 이미지 확인
		-- ----------------------------------------------
		-- ----------------------------------------------
		-- 수정내역
		-- ----------------------------------------------
		/* 
		수정일:			수정자:			수정내용:
		-------------------------------------------------
		2013.07.24		wookki25		job_goods 참조하도록 수정 : goods에 실제 모델이 추가된 날짜 정보가 없어서..
		
		*/
		DECLARE @SQL VARCHAR(MAX)

		--오늘 데이터는 logdb 참조
		select jg_modelno
		into #worker
		from logdb.dbo.job_goods 
		where (datediff(d, @sdate, getdate()) = 0) and jg_id= 'ENURI_AUTO' and jg_date >= @sdate and jg_date < @sdate + 1
		union all
		--오늘 이전 데이터는 196 참조
		select jg_modelno
		from OLTPLOG_196.OLTPLOG.dbo.job_goods 
		where (datediff(d, @sdate, getdate()) > 0) and jg_id= 'ENURI_AUTO' and jg_date >= @sdate and jg_date < @sdate + 1

		SET @SQL = ' SELECT COUNT(*) FROM GOODS WITH (READUNCOMMITTED) inner join #worker on g_modelno=jg_modelno WHERE '+@WHERE_QRY
		EXEC(@SQL)
	

		SET @SQL = ' WITH CTE_MODELNO(ROWNUM, MODELNO) AS '
		SET @SQL = @SQL + ' ( '
		SET @SQL = @SQL + '	 SELECT ROW_NUMBER() OVER (ORDER BY G_MODELNO DESC) AS ROWNUM, G_MODELNO	AS MODELNO '
		SET @SQL = @SQL + '	 FROM GOODS  WITH (READUNCOMMITTED) inner join #worker on g_modelno=jg_modelno  WHERE ' + @WHERE_QRY
		SET @SQL = @SQL + ' ) '
		SET @SQL = @SQL + ' SELECT	G_MODELNO, G_MODELNM, G_IMGCHK, G_JOBCODE, G_PARTCODE, (select count(*) from tbl_danawa_goods_on_db where modelno=g_modelno) as is_danawa'
		SET @SQL = @SQL + ' FROM CTE_MODELNO  A WITH (READUNCOMMITTED) INNER JOIN GOODS B WITH (READUNCOMMITTED) ON A.MODELNO = B.G_MODELNO '
		SET @SQL = @SQL + ' WHERE ROWNUM BETWEEN '+ CAST(((@PAGE-1)*@PAGE_SIZE)+1 AS VARCHAR(MAX)) +' AND '+CAST(@PAGE*@PAGE_SIZE AS VARCHAR(MAX))
		SET @SQL = @SQL + ' ORDER BY ROWNUM '
		EXEC(@SQL)

