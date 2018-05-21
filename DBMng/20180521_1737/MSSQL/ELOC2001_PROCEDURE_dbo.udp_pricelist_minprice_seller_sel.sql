/* *************************************************************************
 * NAME : dbo.udp_pricelist_minprice_seller_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-12-18 17:23:14.2
 *        Modify: 2018-05-03 17:23:34.747
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE  PROC [dbo].[udp_pricelist_minprice_seller_sel]
	@mcate varchar(4) = null
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-12-18
	-- 설  명 : 최저가 판매자 수집
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2012.07.17		wookki25		pricelist join 조건 변경
									goodscode ---> pl_no
	2012.07.17		wookki25		worker, worker_memo, pl_goodsnm 필드 참조 삭제.. 사용안함
	*/
	
	select	g_category
	,		(select cl_name from c_lcate where cl_lcode = substring(g_category, 1,2))+'>'+
			(select cm_name from c_mcate where cm_lcode = substring(g_category, 1,2) and cm_mcode = substring(g_category, 3,2))
	,		seller_nick
	,		seller_url
	from pricelist_minprice_seller
	where g_category like isnull(@mcate+'%', '%')
	order by g_category
