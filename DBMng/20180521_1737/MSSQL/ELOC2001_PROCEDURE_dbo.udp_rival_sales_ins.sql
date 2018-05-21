/* *************************************************************************
 * NAME : dbo.udp_rival_sales_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-18 15:31:02.02
 *        Modify: 2018-05-03 17:23:35.45
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_rival_sales_ins
	@shop_vcode int
,	@rival_name varchar(100)
,	@sales	money
,	@sale_date	smalldatetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-04-18
	-- ��  �� : ����� ���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	if exists(select 1 from tbl_ap_sales_rival where sale_date = @sale_date and shop_vcode = @shop_vcode and rival_name=@rival_name) begin
		update tbl_ap_sales_rival
		set sales = @sales
		where sale_date = @sale_date and shop_vcode = @shop_vcode and rival_name=@rival_name
	end else begin
		insert into tbl_ap_sales_rival(shop_vcode, rival_name, sales,sale_date)
		values(@shop_vcode, @rival_name, @sales, @sale_date)
	end