/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ins_month_sales_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-22 10:50:26.667
 *        Modify: 2018-05-03 17:23:36.043
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ins_month_sales_v3]
	@shopcode	int,
	@sale_date	datetime,
	@money		money,
	@sale_flag	char(1)
as begin
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2014.07.22
	-- ��  �� : ap ��ü ���� �ֹ���	
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------
	*/

	set @sale_date  = EOMONTH(@sale_date)

	-- ����̽��� ������ : delete & insert
	delete from tbl_ap_sales_month where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = @sale_flag
	if @money > 0 begin
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		values (@shopcode, @sale_date, @money, @sale_flag)	
	end


	-- ����̽� ���յ����� : delete & insert
	delete from tbl_ap_sales_month	where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = 'w'
	if @shopcode = 55 and @sale_date < '2015-01-16' begin
		--������ '2015-01-15'�� �������� ����� ���� �ȵǾ� �־� ��ü�� ����� ����
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales_month 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p')
		having sum(sales) > 0
	end else begin
		insert into tbl_ap_sales_month (shop_vcode, sale_date, sales, sale_flag)
		select @shopcode, @sale_date, sum(sales), 'w' 
		from tbl_ap_sales_month 
		where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag in ('p','m')
		having sum(sales) > 0
	end
end

