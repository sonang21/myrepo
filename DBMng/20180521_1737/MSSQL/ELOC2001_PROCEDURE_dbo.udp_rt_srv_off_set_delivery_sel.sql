/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-05 14:17:00.203
 *        Modify: 2018-05-03 17:23:35.763
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_rt_srv_off_set_delivery_sel]
	@category varchar(6)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.05.12
	-- 설  명 : 실시간 단종 3처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select category, limit_price1, limit_price2
	from tbl_rt_srv_off_set_delivery
	where category like @category +'%'
	order by category
