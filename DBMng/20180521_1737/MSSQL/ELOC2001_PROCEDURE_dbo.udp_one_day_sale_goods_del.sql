/* *************************************************************************
 * NAME : dbo.udp_one_day_sale_goods_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-06-18 10:07:23.177
 *        Modify: 2018-05-03 17:23:36.133
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_one_day_sale_goods_del
	@seqno_csv varchar(1000)
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
	if @seqno_csv is null
		return 0

	exec('delete from pricelist_special_goods where seqno in ('+@seqno_csv+')')	