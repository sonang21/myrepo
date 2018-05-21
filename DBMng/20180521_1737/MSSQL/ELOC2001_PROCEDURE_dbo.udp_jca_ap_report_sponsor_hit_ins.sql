/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_sponsor_hit_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-08-12 09:57:12.537
 *        Modify: 2018-05-03 17:23:35.493
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_ap_report_sponsor_hit_ins
	@shopcode int
,	@hit_date smalldatetime
,	@view_hit int
,	@move_hit int
,	@sales money
,	@data_opt char(1)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-08-11
	-- ��  �� : ��������ũ ����,Ŭ�� �Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	if not exists(select top 1 * 
	from tbl_ap_shop_sponsor_hit 
	where shop_vcode=@shopcode and hit_date=@hit_date and data_opt=@data_opt) 
	begin
		-- �Է�
		insert into tbl_ap_shop_sponsor_hit(shop_vcode, hit_date, view_hit, move_hit, data_opt,sales)
		values (@shopcode, @hit_date, @view_hit, @move_hit, @data_opt, @sales)
	end else begin
		-- ������Ʈ
		update	tbl_ap_shop_sponsor_hit
		set		view_hit = @view_hit
		,		move_hit = @move_hit
		,		sales = @sales
		where	shop_vcode = @shopcode and
				hit_date = @hit_date
		and		data_opt = @data_opt
	end
