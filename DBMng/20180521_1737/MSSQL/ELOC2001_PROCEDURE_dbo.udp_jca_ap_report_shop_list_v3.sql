/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_shop_list_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 17:43:49.01
 *        Modify: 2018-05-03 17:23:34.63
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_shop_list_v3]
	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.13
	-- 설  명 : ap 업체목록
	-- 실  행 : udp_jca_ap_report_shop_list
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	2009.03.20		wookki25		where절에 shop_grade = 'cc' 추가
	2014.09.30		wooki25			tbl_ap_sales_shop 테이블 생성
	*/
	if @sale_flag in ('w', 'm', 'p') begin
		select shop_vcode, shop_name, display_order from tbl_ap_sales_shop order by shop_name
		/*
		select	shop_vcode, shop_name
		from 
				(
				select	shop_vcode, shop_name 
				from	shoplist
				where	shop_apflag = 1 and shop_service = '0' and shop_grade = 'cc' 
				union 
				select	shop_vcode, shop_name 
				from	shoplist
				where	shop_vcode = 241
				union 
				select	shop_vcode, shop_name 
				from	shoplist
				where	shop_vcode in( 6508, 6547,  6641 )
				union 
				--select	6252,'하이마트쇼핑몰'
				--union 
				select	1733,'g마켓(순)'
				union 
				select	5893,'옥션(순)'
				union 
				select	1719,'인터파크(순)'				
				union 
				select	6052,'11번가(순)'				
				) a
		order by shop_name
	*/
	end
