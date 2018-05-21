/* *************************************************************************
 * NAME : dbo.udp_orderdata_dashboard_mod_now_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 13:52:44.82
 *        Modify: 2018-05-14 13:52:44.82
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_orderdata_dashboard_mod_now_cate
	@yyyymm char(6)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013-06-20
	-- ��  �� : ������ ���� ����з� ���� ��������.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	declare @sdate smalldatetime
	declare @edate smalldatetime
	set @sdate = cast(@yyyymm+'01' as smalldatetime) 
	set @edate = dateadd(m, 1, @sdate)
/*
	-- �Է´�� �з��� ��� ������Ʈ : ����ó��
	update tbl_orderdata_dashboard
	set category_now = category
	where od_date>= @sdate and od_date <@edate
	and category_now is null
*/
	-- ��ǰ������ ��Ī�ؼ� ������Ʈ : �Ϻ�ó��
	while @sdate < @edate begin

		-- pc
		update a
		set  category_now = g_category
		from tbl_orderdata_dashboard a inner join analstore.dbo.goods on modelno = g_modelno
		where od_date>= @sdate and od_date < @sdate +1 
		and category <> g_category
		and left(g_category,2) <> '00' -- 2015.08.04 �߰�
		and modelno>0

		-- �����
		update a
		set  category_now = g_category
		from tbl_orderdata_dashboard_mobile a inner join analstore.dbo.goods on modelno = g_modelno
		where od_date>= @sdate and od_date < @sdate +1 
		and category <> g_category
		and left(g_category,2) <> '00' -- 2015.08.04 �߰�
		and modelno>0

		set @sdate = @sdate + 1
	end

