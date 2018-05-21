/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SALES_INS_MOD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 13:51:30.46
 *        Modify: 2018-05-03 17:23:34.163
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_sales_ins_mod]
	@shopcode	int,
	@sales_date	smalldatetime,
	@sales_sum	money,
	@shop_group char(1) = null-- tbl_ap_shop_sales.shop_group
as begin
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.03.10
	-- ��  �� : ap ��ü �Ϻ� ����� �Է�/����
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/

	-- ������ : delete & insert
	delete tbl_ap_shop_sales where shop_vcode=@shopcode and sales_date=@sales_date and shop_group = @shop_group
	if @sales_sum > 0 begin
		insert into tbl_ap_shop_sales(shop_vcode, shop_group, sales_date, sales_sum)
		values (@shopcode, @shop_group, @sales_date, @sales_sum)
	end
end