/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-12 17:52:43.45
 *        Modify: 2018-05-03 17:23:35.713
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[udp_rt_srv_off_set_delivery_mod]
	@category varchar(6)
,	@limit_price1 varchar(12)
,	@limit_price2 varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : sung35 / 2015.08.12
	-- 설  명 : 배송비 제한가
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	update tbl_rt_srv_off_set_delivery set limit_price1 = (case when @limit_price1 = '' then null else @limit_price1 end), limit_price2 = (case when @limit_price2 = '' then null else @limit_price2 end)
	where category = @category