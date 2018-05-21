/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_cate_set_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-22 16:53:31.11
 *        Modify: 2018-05-03 17:23:34.3
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_monitoring_target_cate_set_del
	@category varchar(12)
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2016.06.22
	-- ��  �� : ���ݸ���͸�.�ǽð� ����͸� �з��� �α���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/

	delete tbl_monitoring_target_cate_set where  category = @category
