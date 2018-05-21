/* *************************************************************************
 * NAME : dbo.udp_list_exclude_cate_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-27 14:01:45.28
 *        Modify: 2018-05-03 17:23:35.557
 *        Backup: 20180521_1737
 ************************************************************************* */

create PROC udp_list_exclude_cate_del
	@lec_seq	int
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 리스트 제외 분류 del / 2010-04-27
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	If @lec_seq > 0
		delete from tbl_list_exclude_cate where lec_seq = @lec_seq	
	
