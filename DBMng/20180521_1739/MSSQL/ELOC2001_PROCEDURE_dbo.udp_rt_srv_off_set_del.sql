/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-15 13:56:51.58
 *        Modify: 2018-05-03 17:23:35.053
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_rt_srv_off_set_del
	@category varchar(4)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-07-15
	-- 설  명 : 실시간 단종 3처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	delete tbl_rt_srv_off_set where category = @category
