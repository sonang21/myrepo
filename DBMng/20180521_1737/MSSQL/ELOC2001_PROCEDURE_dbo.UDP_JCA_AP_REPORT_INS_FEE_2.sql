/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_INS_FEE_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 17:50:04.707
 *        Modify: 2018-05-03 17:23:34.34
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_INS_FEE_2]
	@SHOPCODE	INT,
	@fee_date	datetime,
	@MONEY		MONEY
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2008.03.13
	-- ��  �� : AP ��ü ������ ������ �Է�
	-- ��  �� : UDP_JCA_AP_DATA_INS_FEE 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/
	if not exists(select top 1 * from tbl_ap_fee where shop_vcode=@shopcode and fee_date=@fee_date) begin
		insert into tbl_ap_fee (shop_vcode, fee_date, fee)
		values (@shopcode, @fee_date, @money)
	end else if @money = -1 begin
		delete from tbl_ap_fee where shop_vcode=@shopcode and fee_date=@fee_date
	end else  begin
		update tbl_ap_fee
		set fee = @money
		where shop_vcode=@shopcode and fee_date=@fee_date
	end

