/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_goodscode_retry
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-24 15:10:18.443
 *        Modify: 2018-05-03 17:23:35.49
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_external_report_goodscode_retry
	@shop_code int
as  begin 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.02.21
	-- ��  �� :  ���û ��ǰ ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	-- ���Ī ��û�� goodscode�� pricelist ���� ���� Ȯ��
	update a
	set pl_no = b.pl_no
	, pl_modelno =  b.pl_modelno
	, moddate = GETDATE()
	, pl_multicomment = b.pl_multicomment
	from tbl_external_request_raw a 
		left outer join pricelist b 
			on a.pl_goodscode = b.pl_goodscode and checksum(a.pl_goodscode) = b.pl_goodscode_cs and a.pl_vcode = b.pl_vcode 
	where moddate is null and a.pl_vcode = @shop_code


	-- ���Ī  ��û  �� �ش�Ǹ� �Է� 
	insert into TBL_EXTERNAL_REQUEST(pl_no, pl_modelno)
	select pl_no, max(pl_modelno) pl_modelno
	from tbl_external_request_raw a inner join tbl_external_category b on a.pl_multicomment = b.CATEGORY_NM
	where moddate >= cast(cast(GETDATE()  as date) as datetime)
	and pl_modelno not in (-100, -200, -300, 0)
	and SENDING_YN = 1 -- ���۴�� ���Ī�� �ִ´�. // 2017.03.06
	group by pl_no
end
