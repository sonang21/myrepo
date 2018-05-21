/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_delivery_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-08-05 14:17:00.203
 *        Modify: 2018-05-03 17:23:35.763
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_rt_srv_off_set_delivery_sel]
	@category varchar(6)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.05.12
	-- ��  �� : �ǽð� ���� 3ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	select category, limit_price1, limit_price2
	from tbl_rt_srv_off_set_delivery
	where category like @category +'%'
	order by category
