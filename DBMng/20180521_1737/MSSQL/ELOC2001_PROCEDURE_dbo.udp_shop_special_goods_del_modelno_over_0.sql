/* *************************************************************************
 * NAME : dbo.udp_shop_special_goods_del_modelno_over_0
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-20 17:59:31.617
 *        Modify: 2018-05-03 17:23:34.94
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_shop_special_goods_del_modelno_over_0
	@shop_code int
,	@regdate datetime
,	@group_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-06-18
	-- 설  명 : 쇼핑몰 특가 상품 관리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	delete a
	from tbl_shop_special_goods a inner join pricelist b on a.pl_vcode = b.pl_vcode and a.pl_no = b.pl_no
	where a.pl_vcode = @shop_code and regdate >= @regdate and regdate < @regdate+1 and pl_modelno > 0

