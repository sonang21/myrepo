/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_del
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-05 14:16:59.98
 *        Modify: 2018-05-03 17:23:35.693
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[udp_rt_srv_off_set_delivery_del]
	@category varchar(6)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-07-15
	-- ��  �� : �ǽð� ���� 3ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	delete tbl_rt_srv_off_set_delivery where category = @category

