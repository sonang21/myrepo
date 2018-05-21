/* *************************************************************************
 * NAME : dbo.udp_pricelist_special_goods_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-21 17:11:55.59
 *        Modify: 2018-05-03 17:23:35.177
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_pricelist_special_goods_del
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
