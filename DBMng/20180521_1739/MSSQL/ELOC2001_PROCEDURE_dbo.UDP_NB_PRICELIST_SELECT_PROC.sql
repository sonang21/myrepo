/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_SELECT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.543
 *        Modify: 2015-05-15 03:31:33.957
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE            PROC UDP_NB_PRICELIST_SELECT_PROC
	@xstrVcode int,
	@xstrGoodsNm VARCHAR(400)
AS
begin
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT pl_no ,isNull(pl_modelno, -100) ,isNull(pl_category, '00') ,pl_price ,pl_url ,isNull(pl_status, '0') ,isNull(pl_rightnleft, '0'), pl_imgurl, pl_coupon, pl_delfeetype, isnull(pl_delprice,0), pl_deliveryflag
	FROM PRICELIST
	WHERE pl_vcode = @xstrVcode and pl_goodsnm = @xstrGoodsNm
end
