/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_DATE_CHECK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.59
 *        Modify: 2018-05-03 17:23:35.383
 *        Backup: 20180521_1739
 ************************************************************************* */





-- UDP_NB_PRICELIST_DATE_CHECK_PROC  :   2004.7.20 --
CREATE    PROC UDP_NB_PRICELIST_DATE_CHECK_PROC
	@p_vcode INT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
	UPDATE PRICELIST 
	SET PL_STATUS = '3'
	WHERE PL_VCODE = @p_vcode  and PL_MODELNO > 0 and (PL_GOODSNM Is Null or Len(PL_GOODSNM) < 2) and 
PL_STATUS < '3' 
	--and DATEDIFF(d, getdate(), pl_date) < -2
	and pl_date < DATEadd(d,-2, getdate())
	
	SET NOCOUNT OFF




