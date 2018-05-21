/* *************************************************************************
 * NAME : dbo.udp_ap_sales_srv_group_sales_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-30 16:59:58.213
 *        Modify: 2018-05-03 17:23:34.34
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_ap_sales_srv_group_sales_ins
	@sales_date	date
,	@sales		numeric(15,0)
,	@group_code	smallint
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.11.30
	-- 설  명 : 경영진.메일링.서비스 그룹 리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/

	-- 삭제하고
	delete from tbl_ap_sales_srv_group where sale_date = @sales_date and group_code = @group_code
	

	-- 새로입력
	insert into tbl_ap_sales_srv_group(sale_date, sales, group_code)
	select  @sales_date, @sales, @group_code where @sales > 0
