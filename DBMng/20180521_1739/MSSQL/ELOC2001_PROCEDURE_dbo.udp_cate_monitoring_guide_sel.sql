/* *************************************************************************
 * NAME : dbo.udp_cate_monitoring_guide_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-21 15:13:46.81
 *        Modify: 2018-05-03 17:23:34.857
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cate_monitoring_guide_sel
	@category varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014.11.20
	-- 설  명 : 분류별 서비스 가이드
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	select seqno, category, guide_title, guide_desc, isnull(moddate, regdate)
	, ex_option1, ex_option2, isnull(guide_attri_desc,'')
	from tbl_cate_monitoring_guide 
	where category like @category +'%'
	order by category, guide_title

