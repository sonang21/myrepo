/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ins_ord_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 17:48:42.49
 *        Modify: 2018-05-03 17:23:34.67
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_ord_v3]
	@shopcode	int,
	@sale_date	datetime,
	@money		money,
	@sale_flag char(1)
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

	-- ����̽��� ������ : delete & insert
	delete from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = @sale_flag
	if @money > 0 begin
		insert into tbl_ap_sales (shop_vcode, sale_date, sales, sale_flag)
		values (@shopcode, @sale_date, @money, @sale_flag)
	end

	-- ����̽� ���յ����� : delete & insert
	delete from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = 'w'
	if @shopcode = 55 and @sale_date < '2015-01-16' begin
		--������ '2015-01-15'�� �������� ����� ���� �ȵǾ� �־� ��ü�� ����� ����
		insert into tbl_ap_sales (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p')
		having sum(sales) > 0
	end else begin
		insert into tbl_ap_sales (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p','m')
		having sum(sales) > 0
	end
