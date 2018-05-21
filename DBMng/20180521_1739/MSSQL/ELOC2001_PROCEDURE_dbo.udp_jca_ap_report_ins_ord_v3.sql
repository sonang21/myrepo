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
	-- 작성자 : wookki25 / 2008.03.13
	-- 설  명 : ap 업체 일별 주문액 데이터 입력
	-- 실  행 : udp_jca_ap_data_ins_ord 536, 2008, 12, 6, 6000
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/

	-- 디바이스별 데이터 : delete & insert
	delete from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = @sale_flag
	if @money > 0 begin
		insert into tbl_ap_sales (shop_vcode, sale_date, sales, sale_flag)
		values (@shopcode, @sale_date, @money, @sale_flag)
	end

	-- 디바이스 통합데이터 : delete & insert
	delete from tbl_ap_sales where shop_vcode=@shopcode and sale_date=@sale_date and sale_flag = 'w'
	if @shopcode = 55 and @sale_date < '2015-01-16' begin
		--인팍은 '2015-01-15'일 이전에는 모바일 제휴 안되어 있어 전체에 모바일 제외
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
