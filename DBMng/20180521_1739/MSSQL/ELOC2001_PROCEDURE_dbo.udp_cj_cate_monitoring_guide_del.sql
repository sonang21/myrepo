/* *************************************************************************
 * NAME : dbo.udp_cj_cate_monitoring_guide_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-28 14:39:15.19
 *        Modify: 2018-05-03 17:23:35.75
 *        Backup: 20180521_1739
 ************************************************************************* */

create PROC udp_cj_cate_monitoring_guide_del
	@seqno varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.28
	-- 설  명 : 분류별 서비스 가이드
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	delete tbl_cj_cate_monitoring_guide where seqno = @seqno
