/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_MODLENO_SELECT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.31
 *        Modify: 2018-05-03 17:23:35.533
 *        Backup: 20180521_1739
 ************************************************************************* */




-- UDP_NB_PRICELIST_SELECT_MODLENO_CHECK_PROC  :   2004.7.23 --
CREATE     PROC UDP_NB_PRICELIST_MODLENO_SELECT_PROC
	@xstrVcode INT,
	@xstrUrl VARCHAR(250)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
		SELECT pl_modelno 
		FROM PRICELIST WITH(READUNCOMMITTED)
		WHERE pl_vcode = @xstrVcode and pl_url = @xstrUrl and pl_modelno > '0' and pl_srvflag = '0'
			and pl_goodsnm <> ''
			and pl_goodsnm is NOT NULL
			and pl_status < '3'
	SET NOCOUNT OFF



