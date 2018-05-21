/* *************************************************************************
 * NAME : dbo.UDP_GOODS_WORKER_IMG_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-02 16:35:06.553
 *        Modify: 2018-05-03 17:23:35.833
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_GOODS_WORKER_IMG_SEL]
	@PAGE		INT
,	@PAGE_SIZE	INT
,	@WHERE_QRY	VARCHAR(MAX)
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
		2013.05.29		wookki25			select 쿼리에 다나와 상품여부 확인 컬럼 추가. is_danawa
		*/
		DECLARE @SQL VARCHAR(MAX)

		SET @SQL = ' SELECT COUNT(*) FROM GOODS WITH (READUNCOMMITTED) WHERE '+@WHERE_QRY
		EXEC(@SQL)
	

		SET @SQL = ' WITH CTE_MODELNO(ROWNUM, MODELNO) AS '
		SET @SQL = @SQL + ' ( '
		SET @SQL = @SQL + '	 SELECT ROW_NUMBER() OVER (ORDER BY G_MODELNO DESC) AS ROWNUM, G_MODELNO	AS MODELNO '
		SET @SQL = @SQL + '	 FROM GOODS  WITH (READUNCOMMITTED) WHERE ' + @WHERE_QRY
		SET @SQL = @SQL + ' ) '

		SET @SQL = @SQL + ' SELECT	G_MODELNO, G_MODELNM, G_IMGCHK, G_JOBCODE, G_PARTCODE,'
		SET @SQL = @SQL + ' case when exists (select 1 from tbl_danawa_goods_on_db where modelno=g_modelno) then 1 when exists (select 1 from tbl_danawa_goods_on_web where modelno=g_modelno) then 1 else 0 end as is_danawa'
		SET @SQL = @SQL + ' FROM CTE_MODELNO  A WITH (READUNCOMMITTED) INNER JOIN GOODS B WITH (READUNCOMMITTED) ON A.MODELNO = B.G_MODELNO '
		SET @SQL = @SQL + ' WHERE ROWNUM BETWEEN '+ CAST(((@PAGE-1)*@PAGE_SIZE)+1 AS VARCHAR(MAX)) +' AND '+CAST(@PAGE*@PAGE_SIZE AS VARCHAR(MAX))
		SET @SQL = @SQL + ' ORDER BY ROWNUM '
		EXEC(@SQL)

