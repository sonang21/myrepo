/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ins_fee_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 17:51:05.9
 *        Modify: 2018-05-03 17:23:34.68
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_fee_v3]
	@shopcode	int,
	@fee_date	datetime,
	@money		money,
	@sale_flag	char(1)
as begin
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.03.13
	-- ��  �� : ap ��ü ������ ������ �Է�
	-- ��  �� : udp_jca_ap_data_ins_fee 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/

	set @fee_date  = EOMONTH(@fee_date)

	-- ����̽��� ������ : delete & insert
	delete from tbl_ap_fee where shop_vcode=@shopcode and fee_date=@fee_date and sale_flag = @sale_flag
	if @money > 0 begin
		insert into tbl_ap_fee (shop_vcode, fee_date, fee, sale_flag)
		values (@shopcode, @fee_date, @money, @sale_flag)
	end
	
	-- ����̽� ���յ����� : delete & insert
	delete from tbl_ap_fee where shop_vcode=@shopcode and fee_date=@fee_date and sale_flag = 'w'
	insert into tbl_ap_fee (shop_vcode, fee_date, fee, sale_flag)
	select @shopcode, @fee_date, sum(fee), 'w' 
	from tbl_ap_fee where shop_vcode=@shopcode and fee_date=@fee_date and sale_flag in ('p','m')
	having sum(fee) > 0
end

