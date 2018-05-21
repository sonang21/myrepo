/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_shop_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-28 17:21:53.03
 *        Modify: 2018-05-03 17:23:34.097
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_jca_ex_keyword_shop_sel
	@cate varchar(6)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-01-28
	-- 설  명 : 자동그룹핑 기준몰
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select shop_code from tbl_ex_keyword_shop where category = @cate

