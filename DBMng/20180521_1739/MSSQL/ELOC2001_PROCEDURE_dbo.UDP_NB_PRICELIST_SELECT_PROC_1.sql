/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_SELECT_PROC_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-01-26 09:54:25.437
 *        Modify: 2015-05-15 03:31:33.867
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.UP_NB_PRICELIST_SELECT_PROC    스크립트 날짜: 2004-10-23 오전 11:04:24 ******/
-- UP_NB_PRICELIST_SELECT_CHECK_PROC  :   2004.7.23 --
CREATE            PROC UDP_NB_PRICELIST_SELECT_PROC_1
	@xstrVcode int,
	@xstrGoodsNm VARCHAR(1000)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT pl_no ,isNull(pl_modelno, -100) ,isNull(pl_category, '00') ,pl_price ,pl_url ,isNull(pl_status, '0') , pl_imgurl, pl_coupon, pl_delfeetype, pl_delprice, pl_deliveryflag
		FROM PRICELIST WITH (READUNCOMMITTED) 
		WHERE pl_vcode = @xstrVcode and pl_goodsnm = @xstrGoodsNm
	SET NOCOUNT OFF






