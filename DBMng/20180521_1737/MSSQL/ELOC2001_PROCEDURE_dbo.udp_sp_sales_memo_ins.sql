/* *************************************************************************
 * NAME : dbo.udp_sp_sales_memo_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-15 16:19:43.96
 *        Modify: 2018-05-03 17:23:35.18
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_sp_sales_memo_ins
	@memo_date smalldatetime
,	@memo varchar(500)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-06-15
	-- 설  명 : 매출데이터 특이사항 메모
	--sp_help_udp 'udp_sp_sales_memo_ins', 'wookki25', '매출데이터 특이사항 메모'
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	if exists(select 1 from tbl_ap_sales_memo where memo_date = @memo_date)
		update tbl_ap_sales_memo set memo=@memo where memo_date = @memo_date
	else
		insert into tbl_ap_sales_memo(memo_date, memo) values(@memo_date, @memo)


