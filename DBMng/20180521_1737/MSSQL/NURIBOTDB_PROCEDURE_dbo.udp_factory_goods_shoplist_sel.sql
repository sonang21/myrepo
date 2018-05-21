/* *************************************************************************
 * NAME : dbo.udp_factory_goods_shoplist_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-01-09 14:10:32.19
 *        Modify: 2015-05-15 00:52:26.02
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc [dbo].[udp_factory_goods_shoplist_sel]
	@groupinfo char(3)
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-12-26
	-- 설  명 : 제조사 신상품
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select shop_vcode, shop_name
	from tbl_nb_shoplist inner join eloc2001.dbo.shoplist on vcode = shop_vcode
	where groupinfo = @groupinfo and shop_service='0'


