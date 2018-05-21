/* *************************************************************************
 * NAME : dbo.udp_cate_exception_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-30 17:16:24.383
 *        Modify: 2018-05-03 17:23:34.087
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cate_exception_sel
	@category varchar(12)
,	@exception_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013.09.30
	-- 설  명 : 분류별 예외처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	select category
	from tbl_cate_exception 
	where exception_flag = @exception_flag
	and category like isnull(@category,'')+'%'
	order by category
