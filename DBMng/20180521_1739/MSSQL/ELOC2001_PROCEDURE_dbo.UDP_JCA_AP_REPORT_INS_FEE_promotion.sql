/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_INS_FEE_promotion
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-05-02 15:52:59.963
 *        Modify: 2018-05-03 17:23:34.323
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_fee_promotion]
	@shopcode	int,
	@fee_date	datetime,
	@money		money
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2011.05.02
	-- 설  명 : ap 업체 수수료 데이터 입력-프로모션 적용
	-- 실  행 : udp_jca_ap_data_ins_fee 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	if not exists(select top 1 * from tbl_ap_fee_promotion where shop_vcode=@shopcode and fee_date=@fee_date)
	begin
		insert into tbl_ap_fee_promotion (shop_vcode, fee_date, fee)
		values (@shopcode, @fee_date, @money)
	end

	if @money < 0
		delete from tbl_ap_fee_promotion where shop_vcode=@shopcode and fee_date=@fee_date


	update tbl_ap_fee_promotion
	set fee = @money
	where shop_vcode=@shopcode and fee_date=@fee_date

