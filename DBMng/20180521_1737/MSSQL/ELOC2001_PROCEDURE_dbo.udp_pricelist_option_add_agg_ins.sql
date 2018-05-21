/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_add_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-12 15:23:26.217
 *        Modify: 2018-05-03 17:23:35.127
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pricelist_option_add_agg_ins
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013-09-12
	-- ��  �� : �ɼ� �߰� ����� �۾�����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	-- �ֱ� 7�ϰ� ������ ����.
	-- �ֱ� 7�� ���� �����ʹ� �����ϰ� �����Ѵ�.
	declare @sdate smalldatetime
	set @sdate  = convert(varchar(10), getdate() - 7, 120)

	-- ����
	insert into tbl_pricelist_option_add_agg(aggdate, mm_id, cnt)
	select @sdate, mm_id, count(*)
	from tbl_pricelist_option_add
	where p_status = 'd' and mm_id is not null
	and regdate>=@sdate and regdate < @sdate+1
	group by mm_id

	-- ����ó���� ���� ������ ����
	delete tbl_pricelist_option_add
	where regdate>=@sdate and regdate < @sdate+1

	-- ���赥���� 6������ ����
	-- ���� 6���� ���� ������ �����Ѵ�.
	delete tbl_pricelist_option_add_agg
	where aggdate < dateadd(mm, -6, getdate())
