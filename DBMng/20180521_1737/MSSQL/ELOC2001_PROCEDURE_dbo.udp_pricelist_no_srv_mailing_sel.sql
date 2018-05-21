/* *************************************************************************
 * NAME : dbo.udp_pricelist_no_srv_mailing_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-07-20 17:22:01.79
 *        Modify: 2018-05-03 17:23:34.943
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pricelist_no_srv_mailing_sel
	@shop_vcode int
as 
--	set fmtonly off 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-07-14
	-- ��  �� : ������ �Һи� ��ǰ ����Ʈ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select
		isnull(cl_name,'-') as cl_name
	,	pl_goodsnm
	,	pl_goodscode
	,	pl_price
	,	pl_url
	,	pl_date
	,	isnull(nullif(pl_note,''), '��ǰ���� �Һи�') as pl_note
	,	pl_no
	,	pl_vcode
	from pricelist left outer join c_lcate on left(pl_category,2) = cl_lcode
	where pl_vcode = @shop_vcode
	and pl_srvflag = 'o'
	and pl_status in ('0','1','2', '8','9')
