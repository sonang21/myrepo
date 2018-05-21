/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_chk
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 15:29:32.57
 *        Modify: 2018-05-03 17:23:34.383
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_chk
	@shop_vcode int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-09-26
	-- ��  �� : ap �����ڵ� ���� & db �����층���� üũ�� �� ����
	-- ap �ڵ� ���� & �ѱ����� ����
	-- select �÷� �����(�߰�,����) [shoplist_ap_code_chk_log],[udp_shoplist_ap_code_chk_log] �Բ� ����������Ѵ�.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	declare @apcode1 varchar(100)
	declare @apcode2 varchar(100)

	select @apcode1 = isnull(shop_apcode1,''), @apcode2 = isnull(shop_apcode2,'') from shoplist_ap_code where shop_vcode = @shop_vcode

	if @apcode1 <> '' and @apcode2 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '����+����' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode2, pl_url)+charindex(@apcode1, pl_url)=0) or len(pl_url) <> datalength(pl_url)) 		
		and pl_status not in ('3','5')
	end else if @apcode1 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '����' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode1, pl_url)=0)  or len(pl_url) <> datalength(pl_url)) 
		and pl_status not in ('3','5')
	end else if @apcode2 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '����' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode2, pl_url)=0)  or len(pl_url) <> datalength(pl_url)) 
		and pl_status not in ('3','5')
	end else begin
		select @shop_vcode, 'ap�ڵ� �����Դϴ�.', 0, '','',''
	end

