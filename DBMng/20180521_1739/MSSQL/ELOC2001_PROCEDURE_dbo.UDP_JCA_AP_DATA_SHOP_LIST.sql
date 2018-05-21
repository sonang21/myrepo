/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_DATA_SHOP_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-13 13:16:38.06
 *        Modify: 2018-05-03 17:23:35.067
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JCA_AP_DATA_SHOP_LIST
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.13
	-- 설  명 : AP 업체목록
	-- 실  행 : UDP_JCA_AP_DATA_SHOP_LIST
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	SELECT	SHOP_VCODE, SHOP_NAME
	FROM 
			(
			SELECT	SHOP_VCODE, SHOP_NAME 
			FROM	SHOPLIST
			WHERE	SHOP_APFLAG = 1 AND SHOP_SERVICE = '0'
			UNION ALL
			SELECT	'1733','G마켓(순)'
			UNION ALL
			SELECT	'5893','옥션(순)'
			) A
	ORDER BY SHOP_NAME