/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-05 14:16:59.98
 *        Modify: 2018-05-03 17:23:35.693
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[udp_rt_srv_off_set_delivery_del]
	@category varchar(6)
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
	
	delete tbl_rt_srv_off_set_delivery where category = @category

