/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_LOGDB_INSERT_PROC_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-06-17 14:56:26.513
 *        Modify: 2018-05-03 17:23:35.523
 *        Backup: 20180521_1739
 ************************************************************************* */

-- UDP_NB_PRICELIST_LOGDB_INSERT_PROC  :   2004.7.23 --
CREATE     PROC UDP_NB_PRICELIST_LOGDB_INSERT_PROC_1
	@xintAutoModelNo INT,
	@xstrVcode INT,
	@xstrGoodsNm NVARCHAR(200)
	
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
		INSERT INTO LOGDB..JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag)
		SELECT pl_no, @xintAutoModelNo , @xstrVcode ,'XNURIBOT','0' FROM PRICELIST WITH(READUNCOMMITTED) 
WHERE pl_vcode = @xstrVcode and pl_goodsnm = @xstrGoodsNm
	SET NOCOUNT OFF




