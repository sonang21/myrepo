/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_FEE_INS_MOD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 13:51:17.483
 *        Modify: 2018-05-03 17:23:34.1
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_fee_ins_mod]
	@shopcode	int,
	@fee_date	smalldatetime,
	@fee_sum	money,
	@shop_group char(1) = null-- tbl_ap_shop_sales.shop_group
as begin
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.03.10
	-- ��  �� : ap ��ü �Ϻ� ������ �Է�/����
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	set @fee_date  = EOMONTH(@fee_date)

	-- ������ : delete & insert
	delete tbl_ap_shop_fee where shop_vcode=@shopcode and fee_date=@fee_date and shop_group = @shop_group
	if @fee_sum > 0 begin
		insert into tbl_ap_shop_fee(shop_vcode, shop_group, fee_date, fee_sum)
		values (@shopcode, @shop_group, @fee_date, @fee_sum)
	end
end
