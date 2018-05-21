/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SHOP_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-18 13:01:17.857
 *        Modify: 2018-05-03 17:23:35.433
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE  PROC [dbo].[UDP_JCA_AP_REPORT_SHOP_LIST]
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.13
	-- 설  명 : AP 업체목록
	-- 실  행 : UDP_JCA_AP_REPORT_SHOP_LIST
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	2009.03.20		wookki25		where절에 SHOP_GRADE = 'CC' 추가
	*/
	SELECT	SHOP_VCODE, SHOP_NAME
	FROM 
			(
				select	shop_vcode, shop_name from	shoplist where	shop_apflag = 1 and shop_service = '0' and shop_grade = 'cc' 
				union all
				select	shop_vcode, shop_name from	shoplist where	shop_vcode in(241, 6508)
				union all
				--select	6252,'하이마트쇼핑몰'
				--union 
				select	1733,'g마켓(순)'
				union 
				select	5893,'옥션(순)'
				union 
				select	1719,'인터파크(순)'				
				union 
				select	6052,'11번가(순)'				
			) A
	ORDER BY SHOP_NAME
