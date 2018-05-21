/* *************************************************************************
 * NAME : dbo.udp_ap_sales_srv_group_cost_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-30 14:59:08.117
 *        Modify: 2018-05-03 17:23:36.007
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_ap_sales_srv_group_cost_ins
	@cost_yyyymm	date
,	@cost		numeric(15,0)
,	@group_code	smallint
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.11.30
	-- ��  �� : �濵��.���ϸ�.���� �׷� ����Ʈ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	-- �Է��� �ſ� 1��
	set @cost_yyyymm = dateadd(d, 1, dateadd(d, -datepart(d, @cost_yyyymm), @cost_yyyymm))
	-- �ش���� ��¥���� ���༭ �Ϻ� ������ ����
	declare @day_of_month numeric(15,0)
	set @day_of_month  = datepart(d, dateadd(d, -1, dateadd(m, 1, @cost_yyyymm)))


	-- �����ϰ�
	delete from tbl_ap_sales_srv_group_cost where cost_yyyymm = convert(char(6), @cost_yyyymm, 112) and group_code = @group_code

	-- �Է��ϰ�	
	insert into tbl_ap_sales_srv_group_cost(cost_yyyymm, month_cost, day_cost, group_code)
	select convert(char(6), @cost_yyyymm, 112), @cost, @cost/@day_of_month, @group_code where @cost > 0
