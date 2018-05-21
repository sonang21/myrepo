/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ins_ord_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 17:48:11.473
 *        Modify: 2018-05-03 17:23:34.327
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_ord_2]
	@shopcode	int,
	@sale_date	datetime,
	@money		money
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.13
	-- ��  �� : ap ��ü �Ϻ� �ֹ��� ������ �Է�
	-- ��  �� : udp_jca_ap_data_ins_ord 536, 2008, 12, 6, 6000
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/
	if not exists(select top 1 * from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date)
	begin
		insert into tbl_ap_sales (shop_vcode, sale_date, sales)
		values (@shopcode, @sale_date, @money)
	end

	if @money < 0
		delete from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date


	update tbl_ap_sales
	set sales = @money
	where shop_vcode=@shopcode and sale_date=@sale_date
