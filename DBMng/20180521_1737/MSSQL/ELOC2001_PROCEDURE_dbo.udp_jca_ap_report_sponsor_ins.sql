/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 10:06:42.913
 *        Modify: 2018-05-03 17:23:35.59
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_jca_ap_report_sponsor_ins
	@shopcode int
,	@sale_date smalldatetime
,	@exp_cnt int
,	@hit_cnt int
,	@sales money
,	@data_opt char(1)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-08-11
	-- ��  �� : ��������ũ �����Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	if not exists(select top 1 * 
	from tbl_ap_sales_sponsor 
	where shop_vcode=@shopcode and sale_date=@sale_date and data_opt=@data_opt) 
	begin
		-- �Է�
		insert into tbl_ap_sales_sponsor(shop_vcode, sale_date, exp_cnt, hit_cnt, data_opt, sales)
		values (@shopcode, @sale_date, @exp_cnt, @hit_cnt, @data_opt, @sales)
	end else begin
		-- ������Ʈ
		update	tbl_ap_sales_sponsor
		set		exp_cnt = @exp_cnt
		,		hit_cnt = @hit_cnt
		,		sales = @sales
		where	shop_vcode = @shopcode and
				sale_date = @sale_date
		and		data_opt = @data_opt
	end
