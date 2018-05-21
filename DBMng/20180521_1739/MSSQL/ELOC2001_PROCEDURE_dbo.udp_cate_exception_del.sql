/* *************************************************************************
 * NAME : dbo.udp_cate_exception_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-30 17:13:17.817
 *        Modify: 2018-05-03 17:23:34.06
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_cate_exception_del
	@category varchar(12)
,	@exception_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-06-15
	-- 설  명 : 분류별 예외처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	delete tbl_cate_exception where category = @category and exception_flag = @exception_flag

