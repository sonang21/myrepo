/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-05 14:17:00.173
 *        Modify: 2018-05-03 17:23:35.753
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[udp_rt_srv_off_set_delivery_ins]
	@category varchar(6)
,	@limit_price1 varchar(12)
,	@limit_price2 varchar(12)
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
	DECLARE @Chk int

	update tbl_rt_srv_off_set_delivery set limit_price1 = (case when @limit_price1 = '' then null else @limit_price1 end), limit_price2 = (case when @limit_price2 = '' then null else @limit_price2 end) 
	where category = @category
	set @Chk = @@rowcount

	If ( @Chk = 0 )
		Begin
			insert into tbl_rt_srv_off_set_delivery(category, limit_price1, limit_price2) 
			values (@category, (case when @limit_price1 = '' then null else @limit_price1 end), (case when @limit_price2 = '' then null else @limit_price2 end))
		End
	